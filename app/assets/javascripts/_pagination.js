$(function() {
  $(".sort_paginate_ajax").on("click", ".pagination a", function(){
    setTimeout(function(){
      if ($('#helpers:checkbox:checked').val() === "on"){
        $('*').each(function(){
          if (typeof $(this).data("tooltip") === "undefined"){
            // Do NOTHING Element is not Tooltipped
          } else if ($(this).data().hasOwnProperty("tooltip") && !$(this).hasClass("tooltipped")) {
            // Add The tooltipped class
            $(this).addClass("tooltipped");
            // reinitialize tooltips
            $(this).tooltip({delay: 50});
          }
        });
      }
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




