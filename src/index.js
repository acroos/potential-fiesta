require('./index.html')
require('./main.css')
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'));

registerServiceWorker();

document.body.onkeypress = function(e) {
    app.ports.bodyKeyPress.send(e.keyCode);
};
