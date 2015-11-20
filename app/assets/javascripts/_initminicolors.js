$('#campaign_bottom_color').minicolors();
$('#campaign_top_color').minicolors();

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
}

$('.minicolors-picker').mouseup(function(){
  bottomColor = $('#campaign_bottom_color').val();
  topColor = $('#campaign_top_color').val();
  setPreview();
});

setPreview();
