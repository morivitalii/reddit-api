$(document).ready(function() {
    $(document).on('ajax:success', '.approve', function(e) {
        var approve_link_tooltip_message = e.detail[0].approve_link_tooltip_message;
        var remove_link_tooltip_message = e.detail[0].remove_link_tooltip_message;
        var approve_link = $(this);
        var remove_link = $(approve_link).siblings(".remove");
        var approve_link_active_class = "text-success";
        var remove_link_active_class = "text-danger";
        var tooltip_attribute = "data-original-title";

        $(approve_link).addClass(approve_link_active_class);
        $(remove_link).removeClass(remove_link_active_class);
        $(approve_link).attr(tooltip_attribute, approve_link_tooltip_message);
        $(remove_link).attr(tooltip_attribute, remove_link_tooltip_message);
        $(approve_link).tooltip("hide").tooltip("show");
    });
});