$(function(){
  $(document).on('click', '.add-to-zip', function(e){
    $(this).removeClass('red');
    $(this).addClass('green');
    $(this).html('<i class="fa fa-check"></i> Added!');
    var id = $(this).attr('data-id');
    id = id + ',';
    $('#selected_posts').append(id);
    e.preventDefault();
  });
});
