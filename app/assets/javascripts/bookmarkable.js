$(document).ready(function() {
    $(document).on('ajax:success', '.bookmark', function(e) {
        var bookmarked = e.detail[0].bookmarked;
        var bookmark_link_tooltip_message = e.detail[0].bookmark_link_tooltip_message;
        var bookmark_link = $(this);
        var bookmark_link_icon = $(bookmark_link).find("i");
        var method_attribute = "data-method";
        var bookmarked_icon_class = "fa-bookmark";
        var not_bookmarked_icon_class = "fa-bookmark-o";
        var bookmarked_method = "delete";
        var not_bookmarked_method = "post";
        var tooltip_attribute = "data-original-title";

        if(bookmarked === true) {
            $(bookmark_link).attr(method_attribute, bookmarked_method);
            $(bookmark_link_icon).removeClass(not_bookmarked_icon_class);
            $(bookmark_link_icon).addClass(bookmarked_icon_class);
        } else if (bookmarked === false) {
            $(bookmark_link).attr(method_attribute, not_bookmarked_method);
            $(bookmark_link_icon).removeClass(bookmarked_icon_class);
            $(bookmark_link_icon).addClass(not_bookmarked_icon_class);
        }

        $(bookmark_link).attr(tooltip_attribute, bookmark_link_tooltip_message);
        $(bookmark_link).tooltip("hide").tooltip("show");
    });
});