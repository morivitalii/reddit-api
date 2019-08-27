$(document).ready(function() {
    $(document).on('ajax:success', '.entries .create', function(e) {
        $('.entries').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.entries .update', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.entries .edit_update_rule_form, .entries .edit_update_ban_form', function (e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.replaceWith(e.detail[0].activeElement.innerHTML);
        format_datetime();
    });

    $(document).on('click', '.entries .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});