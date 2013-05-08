(function() {
  function downloadUrl(src) {
    var a = document.createElement("a");
    a.download = "";
    a.href = src;
    a.style.display = "none";
    document.body.appendChild(a);
    a.click();
  }

  var backdrop = document.createElement("div");
  backdrop.style.cssText = "position: fixed; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.8); z-index: 1000000; overflow: auto; display: none;";
  backdrop.onclick = function() {
    backdrop.style.display = "none";
  };

  document.body.appendChild(backdrop);

  var performer = document.createElement("img");
  performer.style.cssText = "position: relative; top: 50%; left: 50%;";
  
  function showPerformer() {
    performer.style.display = "block";
    performer.style.marginLeft = -(performer.clientWidth / 2) + "px";
    performer.style.marginTop = -(performer.clientHeight / 2) + "px";
  }

  performer.onload = showPerformer;

  performer.onclick = function(event) {
    if(event.ctrlKey) {
      downloadUrl(performer.src);
    }
    else {
      if(performer.style.maxWidth == "100%") {
        performer.style.maxWidth = "";
        performer.style.maxHeight = "";
      }
      else {
        performer.style.maxWidth = "100%";
        performer.style.maxHeight = "100%";
      }
      showPerformer();
    }
    event.stopPropagation();
  }


  backdrop.appendChild(performer);

  function startShow() {
    performer.style.maxWidth = "100%";
    performer.style.maxHeight = "100%";
    performer.style.marginLeft = "0";
    performer.style.marginTop = "0";
    performer.style.display = "none";
    performer.src = this.href;
    backdrop.style.display = "block";

    return false;
  }

  //Bonus enhancement
  var endsWithImg = new RegExp("\\.(jpg|jpeg|png|gif)$");
  var imgurAlbum = new RegExp("^http://imgur.com/a/");
  var links = window.document.querySelectorAll('a[href^="http://imgur.com"]');
  for(var i = 0; i < links.length; i++) {
    if(!imgurAlbum.test(links[i].href) && !endsWithImg.test(links[i].href)) links[i].href = links[i].href + ".jpg";
  }

  var links = window.document.querySelectorAll("a[href$=jpg], a[href$=jpeg], a[href$=png], a[href$=gif]");
  for(var i = 0; i < links.length; i++) links[i].onclick = startShow;

  window.addEventListener("resize", showPerformer, false);
})();
