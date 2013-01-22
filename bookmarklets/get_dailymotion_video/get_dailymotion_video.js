var script = document.createElement("script");
script.src = "https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js";
document.head.appendChild(script);

function get_dailymotion_videos($) {
  var dmvk = "";
  var cookies = document.cookie.split(' ');
  for(var i = 0; i < cookies.length; i++) {
    var matches = cookies[i].match(/^(.*?)=(.*)$/);
    if(matches[1] == 'dmvk') dmvk = matches[2];
  }
  var params = $(".dmpi_video_playerv4 > object > param[name='flashvars']").attr("value").split("&");
  for(var i = 0; i < params.length; i++) {
    var matches = params[i].match(/^(.*?)=(.*)$/);
    if(matches[1] == 'sequence') {
      var config = JSON.parse(decodeURIComponent(matches[2]));
      var video_config = config['sequence'][0]['layerList'][0]['sequenceList'][2]['layerList'][2]['param'];
      var url = video_config.hd720URL || video_config.hqURL || video_config.sdURL || video_config.ldURL;
      var matches = url.match(/video\/(.*?)\.mp4/);
      var video_id = matches[1];
      alert("curl -A '" + navigator.userAgent + "' -b 'dmvk=" + dmvk + "' -L '" + url + "' -o '" + video_id + ".mp4'");
    }
  }
}

window.setTimeout(function() {
  get_dailymotion_videos(jQuery.noConflict());
}, 2000);
