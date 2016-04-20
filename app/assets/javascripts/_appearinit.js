$(function(){
  $('.image-download').appear();

  $(document.body).on('appear', '.image-download', function(e, $affected) {
    $affected.each(function() {
      // console.log($(this)+' visible.');
    });
  });

  $(document.body).on('disappear', '.image-download', function(e, $affected) {
    $affected.each(function() {
      // console.log($(this)+' hidden.');
    });
  });
});
