$(function(){
	var d = document.documentElement.style
	if (('flexWrap' in d) || ('WebkitFlexWrap' in d) || ('msFlexWrap' in d)){
		// Do something if compatible
	} else {
		var errorMsg = 'This application uses FlexBox and your browser is incompatible!';        
		Materialize.toast(errorMsg, 5000, 'red darken-4');
	}
});