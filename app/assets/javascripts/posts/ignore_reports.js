$(document).ready(function() {
    $(document).on('ajax:success', '.post .ignore_reports', function(e) {
        var ignore_reports = e.detail[0].ignore_reports;
        var ignore_reports_link = $(this);
        var ignore_reports_link_icon = $(ignore_reports_link).find("i");
        var ignore_reports_data = "update_post_form[ignore_reports]=true";
        var not_ignore_reports_data = "update_post_form[ignore_reports]=false";
        var ignore_reports_icon = "fa-check-square-o";
        var not_ignore_reports_icon = "fa-square-o";
        var data_attribute = "data-params";

        if (ignore_reports === true) {
            $(ignore_reports_link).attr(data_attribute, not_ignore_reports_data);
            $(ignore_reports_link_icon).removeClass(not_ignore_reports_icon);
            $(ignore_reports_link_icon).addClass(ignore_reports_icon);
        } else if(ignore_reports === false) {
            $(ignore_reports_link).attr(data_attribute, ignore_reports_data);
            $(ignore_reports_link_icon).removeClass(ignore_reports_icon);
            $(ignore_reports_link_icon).addClass(not_ignore_reports_icon);
        }

        $(ignore_reports_link).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
    });
});