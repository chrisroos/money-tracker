// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require jquery-ui/effect
//= require twitter/bootstrap
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

  $("input.category").autocomplete({
    source: '/categories/search',
    minLength: 0, delay: 100
  });

  $("input.description").autocomplete({
    source: '/descriptions/search',
    minLength: 0, delay: 100
  });

  // I can't just pass a URL as the `source` option because I need to get the value of the associated
  // description at the time the autocomplete function fires.
  // This relies on the transaction container (a `tr` in bulk edit and the form in single edit) having
  // a class of 'transaction'.
  $("input.location").each(function() {
    var locationElement = $(this);
    $(this).autocomplete({
      source: function(request, response) {
        var transactionContainer = $(locationElement).parents('.transaction');
        var description = $('input.description', transactionContainer).val();
        var sourcePath = '/locations/search?description=' + encodeURIComponent(description) + '&term=' + request.term;
        $.ajax(sourcePath).done(function(data) { response(data); });
      },
      minLength: 0, delay: 100
    });
  });
});
