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
	$('.datepicker').pickadate({
		selectMonths: true, // Creates a dropdown to control month
		selectYears: 100, // Creates a dropdown of 15 years to control year
		container: 'body',		
	});
});