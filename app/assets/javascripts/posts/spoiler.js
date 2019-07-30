$(document).ready(function() {
    $(document).on('ajax:success', '.spoiler', function(e) {
        var spoiler = e.detail[0].spoiler;
        var spoiler_link = $(this);
        var spoiler_link_icon = $(spoiler_link).find("i");
        var spoiler_data = "update_post[spoiler]=true";
        var not_spoiler_data = "update_post[spoiler]=false";
        var spoiler_icon = "fa-check-square-o";
        var not_spoiler_icon = "fa-square-o";
        var data_attribute = "data-params";

        if (spoiler === true) {
            $(spoiler_link).attr(data_attribute, not_spoiler_data);
            $(spoiler_link_icon).removeClass(not_spoiler_icon);
            $(spoiler_link_icon).addClass(spoiler_icon);
            $(spoiler_link).closest(".row").find(".info").append('<span class="spoiler">Спойлер</span>');
        } else if(spoiler === false) {
            $(spoiler_link).attr(data_attribute, spoiler_data);
            $(spoiler_link_icon).removeClass(spoiler_icon);
            $(spoiler_link_icon).addClass(not_spoiler_icon);
            $(spoiler_link).closest(".row").find(".info .spoiler").remove();
        }

        $(spoiler_link).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
    });
});