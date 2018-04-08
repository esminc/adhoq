import * as monaco from 'monaco-editor/esm/vs/editor/editor.api';
import { language as sql } from 'monaco-editor/esm/vs/basic-languages/sql/sql';
import { difference, uniq, throttle } from 'lodash';

/* global $ */

const { CompletionItemKind } = monaco.languages;
const keywords = [ ...sql.keywords, ...sql.operators, ...sql.builtinFunctions ];

function extractCompletionTokens(model) {
  const tokens = model.getValue().split(/[\s+;]/);

  return uniq(tokens.filter(item => item.length > 2));
}

function completionItem({ label, kind }) {
  const insertText = label;

  return { label, kind, insertText };
}

function updateLocalCompletionsLater(model) {
  const localWords = extractCompletionTokens(model);
  const allWords = [ ...keywords, ...this.tableColumnCompletions.map(i => i.label) ];

  this.localCompletions = difference(localWords, allWords).map(label => completionItem({
    label,
    kind: CompletionItemKind.Text,
  }));
}

class Completion {
  updateLocalCompletionsLater = throttle(updateLocalCompletionsLater, 1000)

  keywordCompletions = [];
  tableColumnCompletions = [];
  localCompletions = [];

  constructor(currentTablesPath) {
    this.currentTablesPath = currentTablesPath;
  }

  get items() {
    return [
      ...this.tableColumnCompletions,
      ...this.keywordCompletions,
      ...this.localCompletions,
    ];
  }

  install() {
    this.installKeywordCompletions();
    this.installTableColumnCompletions();
  }

  installKeywordCompletions() {
    this.keywordCompletions = keywords.map((keyword) => {
      const label = keyword.toLowerCase();

      return completionItem({ label, kind: CompletionItemKind.Keyword });
    });
  }

  async installTableColumnCompletions() {
    try {
      const tables = await $.getJSON(this.currentTablesPath);
      const columns = uniq(tables.reduce((acc, table) => (
        [ ...acc, ...table.columns.map(c => c.name) ]
      ), []));

      this.tableColumnCompletions = [
        ...tables.map(({ table_name }) => completionItem({ label: table_name, kind: CompletionItemKind.Interface })),
        ...columns.map(label => completionItem({ label, kind: CompletionItemKind.Field })),
      ];
    } catch (e) { /* NOP */ };
  }
}

// From performance perspective, it would be better to define a dedicated service worker for completions
export function installCompletion(currentTablesPath) {
  const completion = new Completion(currentTablesPath);

  completion.install();

  monaco.languages.registerCompletionItemProvider('sql', {
    provideCompletionItems(model) {
      completion.updateLocalCompletionsLater(model);

      return completion.items;
    },
  });
}

export default { installCompletion };
