function slideshowResizer(){
  $('#slideshow img').css('height',dH);
  $('#slideshow img').css('max-height',dH);
}

$(function(){
  setTimeout(function(){
    $('#slideshow').ready(function(){
      dH = Math.max(document.documentElement.clientHeight, window.innerHeight || 0)
      slideshowResizer(dH);
    });
  }, 300);
});

$(window).resize(function(){
  dH = Math.max(document.documentElement.clientHeight, window.innerHeight || 0)
  slideshowResizer(dH);
});