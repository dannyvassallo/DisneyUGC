$('#campaign_bottom_color').minicolors();
$('#campaign_top_color').minicolors();
$('#campaign_text_color').minicolors();

function setPreview(){
  if(typeof(topColor) != 'undefined' && typeof(bottomColor) != 'undefined'){
    var webkit = '-webkit-linear-gradient('+topColor+', '+bottomColor+')';
    var o = '-o-linear-gradient('+topColor+', '+bottomColor+')';
    var moz = '-moz-linear-gradient('+topColor+', '+bottomColor+')';
    var lin = 'linear-gradient('+topColor+', '+bottomColor+')';
    $('.gradient-preview').css({
      'background': webkit,
      'background': o,
      'background': moz,
      'background': lin
    });
  }
  if(typeof(textColor) != 'undefined'){
    $('.colored-text').css('color', textColor);
  }
}

$('.minicolors-picker').mouseup(function(){
  bottomColor = $('#campaign_bottom_color').val();
  topColor = $('#campaign_top_color').val();
  textColor = $('#campaign_text_color').val();
  setPreview();
});

$(document).click(function(event) {
  if(!$(event.target).closest('.minicolors-panel').length) {
    if($('.minicolors-panel').is(":visible")) {
      bottomColor = $('#campaign_bottom_color').val();
      topColor = $('#campaign_top_color').val();
      textColor = $('#campaign_text_color').val();
      setPreview();
    }
  }
});


setPreview();

