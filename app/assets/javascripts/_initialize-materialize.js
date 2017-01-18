$(function(){
	$('.button-collapse').sideNav();
	$('.slider').slider({full_width: true});
	$('.parallax').parallax();
	$('.feed-modal-trigger').leanModal({
		ready: function() {
			// pause featured video on modal open
			$('.primary-player video')[0].player.pause();
		 },
		complete: function() {
			// Pause this video on modal close
		    $('.feed-vid').each(function(){
		      this.player.pause();
		    });
		}
	});
	$('.modal-trigger').leanModal();
	// $('.datepicker').pickadate({
	// 	selectMonths: true, // Creates a dropdown to control month
	// 	selectYears: 100, // Creates a dropdown of 15 years to control year
	// 	container: 'body',
	// });
	$('.datepicker').dateDropper();
  $('.parallax').parallax();
});
