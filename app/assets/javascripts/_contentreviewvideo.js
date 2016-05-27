$(document).on('click', '.video-link', function(e){
  e.preventDefault();
  var link = $(this).data('video');
  window.open(link, "play video", "width=640,height=480");
});
