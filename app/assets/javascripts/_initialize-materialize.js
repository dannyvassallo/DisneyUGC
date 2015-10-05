$(function(){
	$('.button-collapse').sideNav();
	$('.slider').slider({full_width: true});
	$('.parallax').parallax();
	$('.modal-trigger').leanModal({
		complete: function() {
		    $('video').each(function(){ 
		      this.player.pause(); 
		    });
		} 
	});
});