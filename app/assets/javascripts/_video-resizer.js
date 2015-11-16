function vidResizer(){  
  $('#feature').css('height',vH);  
}

$(function(){
  setTimeout(function(){
    $('#feature video').ready(function(){
      vH = $('#feature video').height();
      vidResizer(vH);     
    });
  }, 300);
});

$(window).resize(function(){
  vH = $('#feature video').height();
  vidResizer(vH);
});