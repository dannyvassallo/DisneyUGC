$(function() {
  $(".sort_paginate_ajax").on("click", ".pagination a", function(){
    $.getScript(this.href).done(function(){    	
		$('video').each(function(){
			videojs(this);
		});
    	$.each(videojs.players, function (key, player) { if (player.isReady) { player.destroy(); } else { delete videojs.players[player.id]; } });
    });
    return false;
  });  
});