$(document).ready(function() {
  $('#transactions form').submit(function() {
    var form = $(this);
    var data = form.serialize();
    var url  = form.attr('action');
    $.post(url, data, function(data) {
      $('.edited', form).animate({backgroundColor: '#fff'}, {
        duration: 1500,
        complete: function() { 
          $(this).removeClass('edited');
          $(this).css('backgroundColor', '');
        }
      });
    });
    return false;
  });
  
  $('#transactions input[type=text], #transactions textarea').blur(function() {
    $(this).addClass('edited');
    $(this).parent('form').submit();
  });
  
  $('#transactions input[type=submit]').remove();
});