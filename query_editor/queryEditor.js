// from https://github.com/Microsoft/monaco-editor-samples/tree/master/browser-esm-parcel

import 'monaco-editor/esm/vs/editor/browser/controller/coreCommands';
import 'monaco-editor/esm/vs/editor/contrib/suggest/suggestController';
import * as monaco from 'monaco-editor/esm/vs/editor/editor.api';
import 'monaco-editor/esm/vs/basic-languages/sql/sql.contribution';

import './style.css';

export function launchEditor(element) {
  const editor = monaco.editor.create(element, {
    language: 'sql',
    value: '',
    automaticLayout: true,
    minimap: { enabled: false },
  });

  editor.getModel().updateOptions({ tabSize: 2 });

  const textarea = editor.domElement.getElementsByTagName('textarea')[0];
  textarea.setAttribute('placeholder', element.dataset.placeholder);
  textarea.setAttribute('id', element.dataset.id);
  textarea.setAttribute('name', element.dataset.name);

  return editor;
}
