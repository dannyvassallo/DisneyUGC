function mediaValueClear(clickObject, objectToClear){
  var filePath = $(objectToClear).parent().parent().children('.file-path-wrapper').children('.file-path');
  $(clickObject).on('click', function(){
    $(objectToClear).val('');
    filePath.val('');
    filePath.blur();
  });
}

mediaValueClear('#post_video_url','#post_image_url');
mediaValueClear('#post_image_url','#post_video_url');
mediaValueClear('#campaign_feature','#campaign_video');
mediaValueClear('#campaign_video','#campaign_feature');
