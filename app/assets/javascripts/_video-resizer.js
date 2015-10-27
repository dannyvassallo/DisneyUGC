function vidResizer(){  
  $('#feature').css('height',vH);  
}

$(function(){
  setTimeout(function(){
    $('video').ready(function(){
      vH = $('video').height();
      vidResizer(vH);     
    });
  }, 300);
});

$(window).resize(function(){
  vH = $('video').height();
  vidResizer(vH);
});