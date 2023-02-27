/* 
* OPEN VISUAL
* window.location.href = "js-call:openVisual?path="+element.id;
* OPEN LIBRARY
* window.location.href = "js-call:openLibrary?file="+element.id;
*/
var hDocument = null

function setActive(id){
    document.getElementById("item-1").src = "assets/cmd01.png";
    document.getElementById("container-1").style.zIndex = "5";

    document.getElementById("item-2").src = "assets/cmd02.png";
    document.getElementById("container-2").style.zIndex = "4";

    document.getElementById("item-3").src = "assets/cmd03.png";
    document.getElementById("container-3").style.zIndex = "3";

    document.getElementById("item-4").src = "assets/cmd04.png";
    document.getElementById("container-4").style.zIndex = "2";

    document.getElementById("item-5").src = "assets/cmd05.png";
    document.getElementById("container-5").style.zIndex = "1";

    document.getElementById("item-"+id).src = "assets/cmd0"+id+"active.png";
    document.getElementById("container-"+id).style.zIndex = "1000";
    
    setCurrentScene("m0"+id+"0101", "kSceneTransitionCrossfade");
}

function documentLoaded(hypeDocument, element, event) {
    hDocument = hypeDocument;
    window.location.href = "js-call:loadComplete?loaded=1";
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

if("HYPE_eventListeners" in window === false){
    window.HYPE_eventListeners = Array();
}

window.HYPE_eventListeners.push({"type": "HypeDocumentLoad", "callback": documentLoaded});
