// from https://github.com/Microsoft/monaco-editor-samples/tree/master/browser-esm-parcel

/* global $ */

import 'monaco-editor/esm/vs/editor/browser/controller/coreCommands';
import 'monaco-editor/esm/vs/editor/contrib/suggest/suggestController';
import * as monaco from 'monaco-editor/esm/vs/editor/editor.api';
import 'monaco-editor/esm/vs/basic-languages/sql/sql.contribution';
import { language as sql } from 'monaco-editor/esm/vs/basic-languages/sql/sql';
import { difference, uniq, throttle } from 'lodash';

import './style.css';

function completionItem({ label, kind }) {
  const insertText = label;

  return { label, kind, insertText };
}

const { CompletionItemKind } = monaco.languages;

const keywords = [
  ...sql.keywords,
  ...sql.operators,
  ...sql.builtinFunctions,
];

let tableColumnCompletions = [];
let localCompletions = [];
const keywordCompletions = keywords.map((keyword) => {
  const label = keyword.toLowerCase();

  return completionItem({ label, kind: CompletionItemKind.Keyword });
});

const updateLocalCompletionsLater = throttle((model) => {
  const localWords = uniq(model.getValue().split(/[\s+;]/).filter(item => item.length > 2));
  const allWords = [...keywords, ...tableColumnCompletions.map(i => i.label)];

  localCompletions = difference(localWords, allWords).map(label => completionItem({
    label,
    kind: CompletionItemKind.Text,
  }));
}, 1000);

const CompletionProvider = {
  provideCompletionItems(model) {
    updateLocalCompletionsLater(model);

    return [...tableColumnCompletions, ...keywordCompletions, ...localCompletions];
  },
};

// From performance perspective, it would be better to define a dedicated service worker for completions
async function installCompletion(currentTablesPath) {
  monaco.languages.registerCompletionItemProvider('sql', CompletionProvider);

  try {
    const tables = await $.getJSON(currentTablesPath);
    const columns = uniq(tables.reduce((acc, table) => (
      [...acc, ...table.columns.map(c => c.name)]
    ), []));

    tableColumnCompletions = [
      ...tables.map(({ table_name }) => completionItem({ label: table_name, kind: CompletionItemKind.Interface })),
      ...columns.map(label => completionItem({ label, kind: CompletionItemKind.Field })),
    ];
  } catch (e) { /* NOP */ };
}

function launchEditor($element) {
  const editor = monaco.editor.create($element[0], {
    language: 'sql',
    value: '',
    automaticLayout: true,
    minimap: { enabled: false },
  });

  editor.getModel().updateOptions({ tabSize: 2 });

  const textarea = editor.domElement.getElementsByTagName('textarea')[0];
  textarea.setAttribute('placeholder', $element.data('placeholder'))
  textarea.setAttribute('id', $element.data('id'));
  textarea.setAttribute('name', $element.data('name'));

  return editor;
}

$(() => {
  const $element = $('#query_field');

  if (!$element[0]) return;

  window.Adhoq.editor = launchEditor($element);
  installCompletion($element.data('current-tables-path'));
});
