// Add wave to btns
function addWave(el){
	$(el).addClass('waves-effect');
	$(el).addClass('waves-light');
	$(el).addClass('btn');
	$(el).addClass('grey');
	$(el).addClass('darken-4');
}
$(function(){
	addWave('.button-next');
	addWave('.button-back');
});

// init wizard
$('.the-wizard').stepy({ 
	description: false,
	transition: 'fade',
	next: function(index) {	
		// VALIDATION ON NEXT
		// field variables
		var field = $(this).find('input[type=file],input[type=email],input[type=text],textarea,select').filter(':visible:first'),
		fieldId = field.attr('id'),
		fieldLabel = field.prev('label').html().toLowerCase(),
		fieldValue = field.val(),
		errorMsg = '';		
		// email variables
		emailRegex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;		
		// Validation on next
	    if (fieldValue.length <= 2){
	    	// field length validation	    	
			errorMsg = 'Your '+fieldLabel+' must be longer than that.';
			Materialize.toast(errorMsg, 5000, 'red darken-4');
	    	return false;
    	// Email validation
	    } else if (fieldLabel == 'email address' && !emailRegex.test(fieldValue)){
	    	errorMsg = 'Your '+fieldLabel+' must be valid.';
			Materialize.toast(errorMsg, 5000, 'red darken-4');
	    	return false;
    	// Validate Age
	    } else if (fieldLabel == 'date of birth'){
	    	var bDate = fieldValue;
	    	var bDay = +new Date(bDate);
    	    var age = (Date.now() - bDay) / (31557600000);
		    if ( age < 13 ) {
		        errorMsg = 'Sorry, but you are not eligible for this sweepstakes.';
    			Materialize.toast(errorMsg, 5000, 'red darken-4');
		        return false;
		    }
	    }
	}
});					

