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
	$('.datepicker').pickadate({
		selectMonths: true, // Creates a dropdown to control month
		showMonthsShort: true, // abreviate months
		selectYears: 100, // Creates a dropdown of 15 years to control year
		container: 'body',
		disable_picker: true
	});

	function selectDays(){
		$('<select class="picker__select--month browser-default" aria-controls="post_dob_table" title="Select a day">'+
			 	 '<option value="1">1</option>'+
			 	 '<option value="2">2</option>'+
			 	 '<option value="3">3</option>'+
			 	 '<option value="4">4</option>'+
			 	 '<option value="5">5</option>'+
			 	 '<option value="6">6</option>'+
			 	 '<option value="7">7</option>'+
			 	 '<option value="8">8</option>'+
			 	 '<option value="9">9</option>'+
			 	 '<option value="10">10</option>'+
			 	 '<option value="11">11</option>'+
				 '<option value="12">12</option>'+
				 '<option value="13">13</option>'+
				 '<option value="14">14</option>'+
				 '<option value="15">15</option>'+
				 '<option value="16">16</option>'+
				 '<option value="17">17</option>'+
				 '<option value="18">18</option>'+
				 '<option value="19">19</option>'+
				 '<option value="20">20</option>'+
				 '<option value="21">21</option>'+
				 '<option value="22">22</option>'+
				 '<option value="23">23</option>'+
				 '<option value="24">24</option>'+
				 '<option value="25">25</option>'+
				 '<option value="26">26</option>'+
				 '<option value="27">27</option>'+
				 '<option value="28">28</option>'+
				 '<option value="29">29</option>'+
				 '<option value="30">30</option>'+
				 '<option value="31">31</option>'+
			 '</select>').insertBefore('.picker__select--month');
	}
	selectDays();


  $('.parallax').parallax();
});
