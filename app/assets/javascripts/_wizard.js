$(function(){
  $('#new_post input:submit').click( function() {
    this.disabled = true;
    $('#new_post').submit();
  });
});


// email regex
var emailRegex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;

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
  $('.x-out').on('click', function(){
    $('#entryform').closeModal();
  });
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
		// Validation on next
    if (fieldValue.length <= 2){
    	// field length validation
    	if(fieldId == 'post_image_url'){
    		if(typeof $('#post_video_url').val() != 'undefined' && $('#post_video_url').val().length >= 2){
    			return true;
    		} else {
				errorMsg = 'Your filename must be longer than that.';
				Materialize.toast(errorMsg, 5000, 'red darken-4');
		    	return false;
    		}
    	} else if(fieldId == 'post_video_url'){
    		if(typeof $('#post_image_url').val() != 'undefined' && $('#post_image_url').val().length >= 2){
    			return true;
    		} else {
				errorMsg = 'Your filename must be longer than that.';
				Materialize.toast(errorMsg, 5000, 'red darken-4');
		    	return false;
    		}
    	} else {
	    	errorMsg = 'Your '+fieldLabel+' must be longer than that.';
			Materialize.toast(errorMsg, 5000, 'red darken-4');
	    	return false;
    	}
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


// VALIDATION FOR ON SUBMIT
$('.the-wizard').submit(function(e){
	var name = $('#post_full_name').val(),
	email = $('#post_email_address').val(),
	birthday = $('#post_dob').val(),
	image = $('#post_image_url').val(),
	video = $('#post_video_url').val(),
	bDate = birthday,
	bDay = +new Date(bDate),
    age = (Date.now() - bDay) / (31557600000);
	// name
	if (name.length <= 2){
		errorMsg = 'Your name must be longer than that.';
		Materialize.toast(errorMsg, 5000, 'red darken-4');
    	return false;
    	e.preventDefault();
	// email
	} else if (!emailRegex.test(email)) {
		errorMsg = 'Your email address must be valid.';
		Materialize.toast(errorMsg, 5000, 'red darken-4');
    	return false;
    	e.preventDefault();
	} else if (email.length <= 2){
		errorMsg = 'Your email address must be longer than that.';
		Materialize.toast(errorMsg, 5000, 'red darken-4');
    	return false;
    	e.preventDefault();
	// birthday
	} else if (birthday.length <= 2){
		errorMsg = 'Your date of birth must be longer than that.';
		Materialize.toast(errorMsg, 5000, 'red darken-4');
    	return false;
    	e.preventDefault();
	} else if (age <13){
        errorMsg = 'Sorry, but you are not eligible for this sweepstakes.';
		Materialize.toast(errorMsg, 5000, 'red darken-4');
        return false;
        e.preventDefault();
	} else if(typeof video != 'undefined' && video.length <= 2){
		if(image.length >= 2){
			return true;
		} else {
			errorMsg = 'Your filename must be longer than that.';
			Materialize.toast(errorMsg, 5000, 'red darken-4');
	    	return false;
	    	e.preventDefault();
		}
	} else if(typeof image != 'undefined' && image.length <= 2){
		if(video.length >= 2){
			return true;
		} else {
			errorMsg = 'Your filename must be longer than that.';
			Materialize.toast(errorMsg, 5000, 'red darken-4');
	    	return false;
	    	e.preventDefault();
		}
	}
});
