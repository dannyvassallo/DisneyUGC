$(function(){
	$(".button-collapse").sideNav();
	$('.slider').slider({full_width: true});
	$('.modal-trigger').leanModal({
		complete: function() {
		    $('video').each(function(){ 
		      this.player.pause(); 
		    });
		} 
	});
});