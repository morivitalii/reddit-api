$(document).ready(function() {
    $(document).on('ajax:success', '.explicit', function(e) {
      var explicit = e.detail[0].explicit;
      var new_explicit_link = e.detail[0].explicit_link;
      var explicit_link = $(this);

      if (explicit === true) {
        $(explicit_link).closest(".row").find(".info").append('<span class="explicit">18+</span>');
      } else if(explicit === false) {
        $(explicit_link).closest(".row").find(".info .explicit").remove();
      }

      $(explicit_link).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
      $(explicit_link).replaceWith(new_explicit_link);
    });
});