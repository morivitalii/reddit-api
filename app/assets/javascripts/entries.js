$(document).ready(function() {
    $(document).on('ajax:success', '.entries .create', function(e) {
        $('#bans').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.entries .update', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.entries .updateForm', function (e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.replaceWith(e.detail[0].activeElement.innerHTML);
        format_datetime();
    });

    $(document).on('click', '.entries .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});