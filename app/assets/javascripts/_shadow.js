var coloredText = $('.colored-text');

$('.campaign_text_shadow .materialize_radio_buttons').on('click', function(){
  var cssClass = this.value;
  for(i=1; i < 6; i++){
    var remClass = 'text-z-depth-'+([i]);
    coloredText.removeClass(remClass);
  }
  if(this.value != 'none'){
    coloredText.addClass(cssClass);
  }
});

function addTextShadow(){
  if(typeof(textShadow) != 'undefined' && textShadow != 'none'){
    coloredText.addClass(textShadow);
  }
}

addTextShadow();
