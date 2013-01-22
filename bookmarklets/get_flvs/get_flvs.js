var script = document.createElement("script");
script.src = "https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js";
document.head.appendChild(script);

function get_flvs($) {
  var kps = [];
  var outs = [];

  $("flashvars").each(function(i, fv) {
    kps.push($(fv).attr("value").split("&"));
  });
  $("embed[flashvars]").each(function(i, em) {
    kps.push($(em).attr("flashvars").split("&"));
  });
  $.each(kps, function(i, kp) {
    $.each(kp, function(j, kvp) {
      var match = kvp.match(/^(.*?)=(.*)$/);
      if(["video_url", "flvpathValue", "file", "flv_url"].indexOf(match[1]) > -1) outs.push(decodeURIComponent(match[2]));
    })
  });

  alert(outs.join("\n"));
}

window.setTimeout(function() {
  get_flvs(jQuery.noConflict());
}, 2000);
