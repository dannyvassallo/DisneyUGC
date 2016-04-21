$(function() {
  $(".sort_paginate_ajax").on("click", ".pagination a", function(){
    setTimeout(function(){
      forceBrowserRepaint();
      $container.imagesLoaded().progress( function() {
        $container.masonry('layout');
      });
    }, 50);
    $('.feed-vid').each(function(){
  		videojs(this).dispose();
  	});
    $.getScript(this.href).done(function(){
  		$('.feed-vid').each(function(){
  			videojs(this);
  		});
    });
    return false;
  });
});




