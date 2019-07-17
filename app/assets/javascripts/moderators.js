$(document).ready(function() {
    $(document).on('ajax:success', '#moderators .create', function(e) {
        $('#moderators').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#moderators .delete', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#moderators .confirm', function(e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.remove();
    });

    $(document).on('click', '#moderators .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});