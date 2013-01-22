(function() {
  var image_sizes = ['1280', '500', '400', '250', '100'];
  var images_regex = new RegExp("_(" + image_sizes.join("|") + ")\\.(jpg|png|gif)$");

  function download_url(src) {
    var a = document.createElement("a");
    a.download = "";
    a.href = src;
    a.style.display = "none";
    document.body.appendChild(a);
    a.click();
  }

  function load_image_variant(src, sizes) {
    if(sizes.length == 0) return;

    var image = new Image();
    image.sizes = sizes;
    image.onerror = function() {
      load_image_variant(this.src, this.sizes.slice(1));
    };
    image.onload = function() {
      download_url(this.src);
    };
    image.src = src.replace(images_regex, "_" + sizes[0] + ".$2");
  }

  function load_image(event) {
    event.preventDefault();
    event.stopPropagation();

    load_image_variant(this.getAttribute("original") || this.src, image_sizes);
  }

  function fix_images() {
    var images = window.document.querySelectorAll("img:not([tumblr_images_fixed])");
    for(var i = 0; i < images.length; i++) {
      images[i].setAttribute("tumblr_images_fixed", "");
      var src = images[i].getAttribute("original") || images[i].src;
      if(images_regex.test(src)) {
        images[i].onclick = load_image;
        images[i].style.position = "relative";
        images[i].style.zIndex = "10000";
        images[i].style.cursor = "crosshair";
      }
    }
  }

  fix_images();
  if(window.document.querySelectorAll("body > div.photoset:first-child, body > div.iframe_controls:first-child").length == 0) window.setInterval(fix_images, 5000);
})();
