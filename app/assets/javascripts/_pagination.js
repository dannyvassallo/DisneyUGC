$(function() {
  $(".sort_paginate_ajax").on("click", ".pagination a", function(){    
  	imgloader().delay(1000);
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