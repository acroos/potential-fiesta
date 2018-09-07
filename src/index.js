import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const root = document.getElementById('root');
const app = Main.embed(root);

const logKeys = (keyEvent) => {
    app.ports.bodyKeyPress.send(keyEvent.keyCode);
};

// Android broswers do not seem to respond to onkeypress, so I guess use onkeydown
if (navigator.appVersion.includes("Android")) {
    document.body.onkeydown = logKeys;
} else {
    document.body.onkeypress = logKeys;
}

app.ports.downloadFile.subscribe((config) => {
    const svg = document.querySelector("svg");
    var svgData = new XMLSerializer().serializeToString(svg);

    if (config.fileType == "png") {
        downloadAsPng(svgData, config);
    } else {
        downloadAsSvg(svgData);
    }
});

const downloadAsPng = (svgData, config) => {
    var canvas = document.createElement("canvas");
    canvas.height = config.height;
    canvas.width = config.width;
    var ctx = canvas.getContext("2d");
    
    var img = document.createElement("img");
    img.setAttribute( "src", "data:image/svg+xml;base64," + btoa( svgData ) );

    img.onload = () => {
        ctx.drawImage( img, 0, 0 );
        var url = canvas.toDataURL("image/png", 1)

        downloadFromUrl(url, "png");
    };
}

const downloadAsSvg = (svgData) => {
    const url = window.URL.createObjectURL(new Blob([svgData], { "type" : "text\/xml" }));
    downloadFromUrl(url, "svg");
}

const downloadFromUrl = (url, fileExtension) => {
    const a = document.createElement("a");
    a.setAttribute("download", "potential-fiesta." + fileExtension);
    a.setAttribute("href", url);
    a.style["display"] = "none";

    a.click();
}


registerServiceWorker();

root.onclick = (e) => {
    if (window.location.hash != "") {
        return;
    }
    let hiddenInput = document.getElementById('hidden-input');
    if (hiddenInput) {
        hiddenInput.focus();
    }
};
