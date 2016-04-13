$(function(){
  $(document).on('click', '.add-to-zip', function(e){
    if($(this).hasClass('red')){
      $(this).removeClass('red');
      $(this).addClass('green');
      $(this).html('<i class="fa fa-check"></i> Added!');
      var id = $(this).attr('data-id');
      $('#new-post-collection').append("<div class=\"post-"+id+"\">"+id+"</div>");
      $('#selected_posts').val('');
      var children = $('#new-post-collection').children();
      children.each(function(idx, val){
         $('#selected_posts').val($('#selected_posts').val() + ($(this).html()+','));
      });
      $('.download-selected').removeClass('hide');
      $('.fake-btn').addClass('hide');
    } else if ($(this).hasClass('green')){
      $(this).removeClass('green');
      $(this).addClass('red');
      $(this).html('NOT ADDED');
      elsClass = '.post-' + $(this).attr('data-id');
      $(elsClass).remove();
      $('#selected_posts').val('');
      var children = $('#new-post-collection').children();
      children.each(function(idx, val){
         $('#selected_posts').val($('#selected_posts').val() + ($(this).html()+','));
      });
      if(children.length < 1){
        $('.download-selected').addClass('hide');
        $('.fake-btn').removeClass('hide');
      }
    }
  });

  $('#scrollTop').on("click",function() {
      $('html, body').animate({ scrollTop: 0 }, 'slow', function () {
      });
  });

});
