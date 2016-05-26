var contains = function(needle) {
    // Per spec, the way to identify NaN is that it is not equal to itself
    var findNaN = needle !== needle;
    var indexOf;

    if(!findNaN && typeof Array.prototype.indexOf === 'function') {
        indexOf = Array.prototype.indexOf;
    } else {
        indexOf = function(needle) {
            var i = -1, index = -1;

            for(i = 0; i < this.length; i++) {
                var item = this[i];

                if((findNaN && item !== item) || item === needle) {
                    index = i;
                    break;
                }
            }

            return index;
        };
    }

    return indexOf.call(this, needle) > -1;
};

function rememberClickedPosts(){
  if (typeof selectedPosts[0] == 'undefined') {
    selectedPosts = [];
  }
  $('#new-post-collection').children().each(function(){
    selectedPosts.push($(this).html());
  });
  console.log(selectedPosts);
  $('#masonry-grid').children().each(function(){
    var cardAction = $(this).children().children()[2],
    btn = $(cardAction).children()[0],
    dataId = $(btn).attr('data-id');
    if(contains.call(selectedPosts, dataId)){
      $(btn).removeClass('red');
      $(btn).addClass('green');
      $(btn).html('<i class="fa fa-check"></i> Added!');
    }
  });
}

var selectedPosts;

function iterateThroughMarkedPosts(){
  for (var i = 0; i < selectedPosts.length; i++) {
    var newDiv = $('<div>'),
    newDiv = newDiv.addClass('post-'+selectedPosts[i]),
    newDiv = newDiv.html(selectedPosts[i]);
    $('#new-post-collection').append(newDiv);
  }
  var children = $('#new-post-collection').children();
  children.each(function(idx, val){
     $('#selected_posts').val($('#selected_posts').val() + ($(this).html()+','));
     $('#selected_posts_for_review').val($('#selected_posts_for_review').val() + ($(this).html()+','));
  });
}

$(function(){
  if (typeof selectedPosts  != 'undefined' ){
    iterateThroughMarkedPosts();
    rememberClickedPosts();
    if($('#selected_posts').val().length > 0){
      $('.fake-btn').addClass('hide');
      $('.download-selected').removeClass('hide');
      $('.mark-for-review').removeClass('hide');
    }
  }
});

