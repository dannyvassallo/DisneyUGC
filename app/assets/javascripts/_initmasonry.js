function forceBrowserRepaint() {
    $('#masonry-grid').append('<div style="width=100%" id="dummydiv"></div>');
    $('#dummydiv').width(function() { return $(this).width() - 1; }).width(function() { return $(this).width() + 1; });
    $('#dummydiv').remove();
}

var $container = $('#masonry-grid');

$(function(){
  // initialize
  $container.masonry({
    columnWidth: '.col',
    itemSelector: '.col'
  });

  $container.imagesLoaded().progress( function() {
    $container.masonry('layout');
  });
});
