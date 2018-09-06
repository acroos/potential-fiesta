import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const root = document.getElementById('root');
const app = Main.embed(root);

app.ports.downloadFile.subscribe((id) => {
    const svg = document.getElementById(id);
    const source = (new XMLSerializer()).serializeToString(svg);
    const url = window.URL.createObjectURL(new Blob([source], { "type" : "text\/xml" }));
    startDownload(url);
});

const logKeys = (keyEvent) => {
    app.ports.bodyKeyPress.send(keyEvent.keyCode);
};

// Android broswers do not seem to respond to onkeypress, so I guess use onkeydown
if (navigator.appVersion.includes("Android")) {
    document.body.onkeydown = logKeys;
} else {
    document.body.onkeypress = logKeys;
}

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

root.onclick = (e) => {
    if (window.location.hash != "") {
        return;
    }
    let hiddenInput = document.getElementById('hidden-input');
    if (hiddenInput) {
        hiddenInput.focus();
    }
};