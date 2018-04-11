import 'babel-polyfill';

import { launchEditor } from './queryEditor';
import { installCompletion } from './completion';
import { switchToTextareaEditor } from './textareaEditor';

window.Adhoq.launchEditor = launchEditor;
window.Adhoq.installCompletion = installCompletion;
window.Adhoq.switchToTextareaEditor = switchToTextareaEditor;
