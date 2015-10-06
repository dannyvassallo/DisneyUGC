$(function() {
  $(".sort_paginate_ajax").on("click", ".pagination a", function(){
    $.getScript(this.href).done(function(){    	
		$('video').each(function(){
			videojs(this);
		});    	
    });
    return false;
  });  
});