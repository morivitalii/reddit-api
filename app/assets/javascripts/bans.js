$(document).ready(function() {
    $(document).on('ajax:success', '#bans .create', function(e) {
        $('#bans').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#bans .update', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#bans .updateForm', function (e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.replaceWith(e.detail[0].activeElement.innerHTML);
        format_datetime();
    });

    $(document).on('ajax:success', '#bans .delete', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#bans .confirm', function() {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.remove();
    });

    $(document).on('click', '#bans .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});