$(document).ready(function() {
  $('#transactions form').submit(function() {
    var data = $(this).serialize();
    var url  = $(this).attr('action');
    $.post(url, data, function(data) {
      console.log(data);
    });
    return false;
  });
  
  $('#transactions input[type=text], #transactions textarea').blur(function() {
    $(this).parent('form').submit();
  });
  
  $('#transactions input[type=submit]').remove();
});