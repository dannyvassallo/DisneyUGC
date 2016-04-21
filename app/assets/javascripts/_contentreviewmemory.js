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
  var selectedPosts = [];
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

$(function(){
  rememberClickedPosts();
});

