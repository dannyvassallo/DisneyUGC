var my_delay = 5000;

function callAjax(img, postId, processing, url){
  var postClass = 'post-'+ postId;
  if (processing == true) {
    $.ajax({
      type: "GET",
      url: url,
      success: function(data){
        if (data.image_url_processing){
          theSpinner(img, postClass);
          setTimeout(callAjax(img, postId, processing, url), my_delay);
        } else if (data.video_url_processing){
          theSpinner(img, postClass);
          setTimeout(callAjax(img, postId, processing, url), my_delay);
        } else if (data.video_url.url != null && data.video_url.url.length > 0){
          console.log(data.video_url);
          $('.'+postClass).attr('src', data.video_url.thumb.url);
        } else {
          $('.'+postClass).attr('src', data.image_url.thumb.url);
        }
      }, error: function(){
        console.log('error');
      }
    });
  }
}

function imgloader(){
  $('.sort_paginate_ajax img').each(function(){
    var img = $(this),
    postId = $(img).data("id"),
    campaignName = $(img).data("campaign"),
    processing = $(img).data("processing"),
    url = '/api/v1/campaigns/' + campaignName + '/posts/' + postId;
    callAjax(img, postId, processing, url);
  });
}



function theSpinner(img, postClass){
  var spinner = "<div class=\"preloader-wrapper big active\"><div class=\"spinner-layer spinner-blue\"><div class=\"circle-clipper left\"><div class=\"circle\"></div></div><div class=\"gap-patch\"><div class=\"circle\"></div></div><div class=\"circle-clipper right\"><div class=\"circle\"></div></div></div><div class=\"spinner-layer spinner-red\"><div class=\"circle-clipper left\"><div class=\"circle\"></div></div><div class=\"gap-patch\"><div class=\"circle\"></div></div><div class=\"circle-clipper right\"><div class=\"circle\"></div></div></div><div class=\"spinner-layer spinner-yellow\"><div class=\"circle-clipper left\"><div class=\"circle\"></div></div><div class=\"gap-patch\"><div class=\"circle\"></div></div><div class=\"circle-clipper right\"><div class=\"circle\"></div></div></div><div class=\"spinner-layer spinner-green\"><div class=\"circle-clipper left\"><div class=\"circle\"></div></div><div class=\"gap-patch\"><div class=\"circle\"></div></div><div class=\"circle-clipper right\"><div class=\"circle\"></div></div></div></div>",
  theParent = $(img).parent(),
  theSource = $(img).attr("src");
  theParent.html(spinner);
  theParent.append('<img class=\"'+ postClass +' blank\" src=\"https://s3.amazonaws.com/rdugc/assets/blank.png\">');
}



$(function(){
  imgloader();
});



