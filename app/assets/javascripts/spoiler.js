$(document).ready(function() {
    $(document).on('ajax:success', '.spoiler', function(e) {
      var spoiler = e.detail[0].spoiler;
      var new_spoiler_link = e.detail[0].spoiler_link;
      var spoiler_link = $(this);

      if (spoiler === true) {
        $(spoiler_link).closest(".row").find(".info").append('<span class="spoiler">Спойлер</span>');
      } else if(spoiler === false) {
        $(spoiler_link).closest(".row").find(".info .spoiler").remove();
      }

      $(spoiler_link).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
      $(spoiler_link).replaceWith(new_spoiler_link);
    });
});