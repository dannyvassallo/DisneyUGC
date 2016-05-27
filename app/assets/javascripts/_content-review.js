$(function(){
  $(document).on('click', '.add-to-zip', function(e){
    if($(this).hasClass('red')){
      $(this).removeClass('red');
      $(this).addClass('green');
      $(this).html('<i class="fa fa-check"></i> Added!');
      var id = $(this).attr('data-id');
      $('#new-post-collection').append("<div class=\"post-"+id+"\">"+id+"</div>");
      $('#selected_posts').val('');
      $('#selected_posts_for_review').val('');
      $('#approved_posts').val('');
      var children = $('#new-post-collection').children();
      children.each(function(idx, val){
         $('#selected_posts').val($('#selected_posts').val() + ($(this).html()+','));
         $('#selected_posts_for_review').val($('#selected_posts_for_review').val() + ($(this).html()+','));
         $('#approved_posts').val($('#approved_posts').val() + ($(this).html()+','));
      });
      $('.download-selected').removeClass('hide');
      $('.mark-for-review').removeClass('hide');
      $('.approve-posts').removeClass('hide');
      $('.fake-btn').addClass('hide');
    } else if ($(this).hasClass('green')){
      $(this).removeClass('green');
      $(this).addClass('red');
      $(this).html('NOT ADDED');
      elsClass = '.post-' + $(this).attr('data-id');
      $(elsClass).remove();
      $('#selected_posts').val('');
      $('#selected_posts_for_review').val('');
      $('#approved_posts').val('');
      var children = $('#new-post-collection').children();
      children.each(function(idx, val){
        $('#selected_posts').val($('#selected_posts').val() + ($(this).html()+','));
        $('#selected_posts_for_review').val($('#selected_posts_for_review').val() + ($(this).html()+','));
        $('#approved_posts').val($('#approved_posts').val() + ($(this).html()+','));
      });
      if(children.length < 1){
        $('.download-selected').addClass('hide');
        $('.fake-btn').removeClass('hide');
        $('.mark-for-review').addClass('hide');
        $('.approve-posts').addClass('hide');
      }
    }
  });

  $('#scrollTop').on("click",function() {
      $('html, body').animate({ scrollTop: 0 }, 'slow', function () {
      });
  });

});

var prevContent;

// ajax for zip creation
function ajaxZipDownloader(el){
  $(el).on("ajax:beforeSend", function(){
    var campaignId = $(el).data('campaign-id');
    $('#zip-downloader-modal').openModal();
    var checkIfReady = setInterval(function(){
      $.ajax({
        url: "/api/v1/campaigns/"+campaignId,
      }).success(function(data) {
        var url = data.zip_file.url;
        if(url){
          console.log(url);
          clearInterval(checkIfReady);
          var downloadLink = $('<a>').addClass('zip-download-link btn green').attr('href', url);
          var downloadLink = $(downloadLink).html("<i class='fa fa-download'></i> DOWNLOAD NOW");
          $('.zip-modal-header').html('Your zip file is ready!');
          $('.zip-modal-decription').html('Click the link below to download your new archive.');
          prevContent = $('.zip-modal-content').html();
          $('.zip-modal-content').empty();
          $('.zip-modal-content').append(downloadLink);
        } else {
          console.log('Nothing yet');
        }
      }).error(function(data){
        console.log('there was an error');
        clearInterval(checkIfReady);
      });
    }, 1000);
  });
}

$(document).on('click', '.zip-download-link', function(){
  $('#zip-downloader-modal').closeModal();
  $('.zip-modal-header').html('Your zip is being prepared...');
  $('.zip-modal-decription').html('Please wait while we download, organize, and zip up your files.');
  $('.zip-modal-content').empty();
  $('.zip-modal-content').append(prevContent);
});

$(function(){
  ajaxZipDownloader(".download-all-posts-btn");
  ajaxZipDownloader("#download-selected-posts-form");
});
