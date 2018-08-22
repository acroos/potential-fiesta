require('../public/index.html')
require('../public/background.svg')
require('../public/main.css')
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const app = Main.embed(document.getElementById('root'));

app.ports.downloadFile.subscribe((id) => {
    const svg = document.getElementById(id);
    const source = (new XMLSerializer()).serializeToString(svg);
    const url = window.URL.createObjectURL(new Blob([source], { "type" : "text\/xml" }));
    startDownload(url);
});

document.body.onkeypress = (e) => {
    // Only register keypress when we're on the main page
    if (window.location.hash == "") {
        app.ports.bodyKeyPress.send(e.keyCode);
    }
};

registerServiceWorker();

const startDownload = (url) => {
    const a = document.createElement("a");
    a.setAttribute("download", "potential-fiesta.svg");
    a.setAttribute("href", url);
    a.style["display"] = "none";

    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}