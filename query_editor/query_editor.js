// from https://github.com/Microsoft/monaco-editor-samples/tree/master/browser-esm-parcel

/* global $ */

import 'monaco-editor/esm/vs/editor/browser/controller/coreCommands';
import 'monaco-editor/esm/vs/editor/contrib/suggest/suggestController';
import * as monaco from 'monaco-editor/esm/vs/editor/editor.api';
import 'monaco-editor/esm/vs/basic-languages/sql/sql.contribution';

import './style.css';
import { installCompletion } from './completion';

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
