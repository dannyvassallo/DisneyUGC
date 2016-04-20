function appearInit(){
  $('.image-download').appear();

  $(document.body).on('appear', '.image-download', function(e, $affected) {
    $affected.each(function() {
      $(this).css('visibility', 'visible');
    });
  });

  $(document.body).on('disappear', '.image-download', function(e, $affected) {
    $affected.each(function() {
      $(this).css('visibility', 'hidden');
    });
  });

  $(document).on('load', '.image-download', function(){
    if($('.image-download').is(':appeared')){
      $(this).css('visibility', 'visible');
    }
  });
}

appearInit();
