$(document).ready(function() {
    $(document).on('ajax:success', '.explicit', function(e) {
        var explicit = e.detail[0].explicit;
        var explicit_link = $(this);
        var explicit_link_icon = $(explicit_link).find("i");
        var explicit_data = "update_post[explicit]=true";
        var not_explicit_data = "update_post[explicit]=false";
        var explicit_icon = "fa-check-square-o";
        var not_explicit_icon = "fa-square-o";
        var data_attribute = "data-params";

        if (explicit === true) {
            $(explicit_link).attr(data_attribute, not_explicit_data);
            $(explicit_link_icon).removeClass(not_explicit_icon);
            $(explicit_link_icon).addClass(explicit_icon);
            $(explicit_link).closest(".row").find(".info").append('<span class="explicit">18+</span>');
        } else if(explicit === false) {
            $(explicit_link).attr(data_attribute, explicit_data);
            $(explicit_link_icon).removeClass(explicit_icon);
            $(explicit_link_icon).addClass(not_explicit_icon);
            $(explicit_link).closest(".row").find(".info .explicit").remove();
        }

        $(explicit_link).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
    });
});