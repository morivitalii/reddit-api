$(document).ready(function() {
    $(document).on('ajax:success', '#contributors .create', function(e) {
        $('#contributors').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#contributors .delete', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#contributors .confirm', function(e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.remove();
    });

    $(document).on('click', '#contributors .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});
