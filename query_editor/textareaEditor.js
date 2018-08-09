export function switchToTextareaEditor({ editor, element, content }) {
  const textarea = document.createElement('textarea');

  textarea.innerText = content;
  textarea.classList.add('form-control');
  textarea.setAttribute('rows', 15);
  textarea.setAttribute('required', true);
  textarea.setAttribute('id', 'query_query');
  textarea.setAttribute('name', 'query[query]');

  element.parentNode.replaceChild(textarea, element);
  editor.dispose();
}
