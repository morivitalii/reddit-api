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

    $(document).on('click', '#bans .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});