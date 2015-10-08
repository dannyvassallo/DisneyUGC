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
		var field = $(this).find('input[type=file],input[type=email],input[type=text],textarea,select').filter(':visible:first'),
		fieldId = field.attr('id'),
		fieldValue = field.val();			
	    if (fieldValue.length <= 1){
	    	alert('NO WAY');
	    	return false;
	    } 
	}
});					

