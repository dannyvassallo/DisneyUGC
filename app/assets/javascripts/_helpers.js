$(function(){
  $('#helper-lever').on('click', function(){    
    setTimeout(function(){
      if ($('#helpers:checkbox:checked').val() === "on"){
        $('*').each(function(){
          if (typeof $(this).data("tooltip") === "undefined"){
            // Do NOTHING Element is not Tooltipped
          } else if ($(this).data().hasOwnProperty("tooltip")) {
            // Add The tooltipped class
            $(this).addClass("tooltipped");          
            // reinitialize tooltips
            $(this).tooltip({delay: 50});          
          }
        }); 
      } else {
        $('*').each(function(){
          if (typeof $(this).data("tooltip") === "undefined"){
            // Do NOTHING Element is not Tooltipped
          } else if ($(this).hasClass("tooltipped")) {
            // Remove The tooltipped class
            $(this).removeClass("tooltipped");
            $('.tooltipped').tooltip('remove');                           
          }
        }); 
      }
    }, 100);
  });
});