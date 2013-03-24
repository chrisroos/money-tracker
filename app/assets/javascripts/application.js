// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

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