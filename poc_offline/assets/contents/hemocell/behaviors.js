var hDocument = null

function setActive(id) {

    setCurrentScene("m0"+id+"0101", "kSceneTransitionCrossfade");


}

function documentLoaded(hypeDocument, element, event) {
    hDocument = hypeDocument;
    window.parent.postMessage( { type:"hypeviewer", subtype:"loaded", currentSceneName: hypeDocument.currentSceneName() }, "*" );
}

function getCurrentScene(){
    return hDocument.currentSceneName();
}

function setCurrentScene(scene){
    hDocument.showSceneNamed(scene);
}

function loadScene(){
    document.getElementById("menu").style.display = "none";
}

function unloadScene(){
    document.getElementById("menu").style.display = "block";
}

function doOpenVisual(id) {
    window.parent.postMessage( { type:"hypeviewer", id: id }, "*" );
}

function doOpenLibrary(id) {
    window.parent.postMessage( { type:"pdfviewer", id: id } ,"*" );
}

if("HYPE_eventListeners" in window === false){
    window.HYPE_eventListeners = Array();
}

window.HYPE_eventListeners.push({"type": "HypeDocumentLoad", "callback": documentLoaded});