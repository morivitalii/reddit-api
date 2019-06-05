$(document).ready(function() {
    $(document).on('ajax:success', '#rules .create', function(e) {
        $('#rules').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#rules .update', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#rules .updateForm', function (e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.replaceWith(e.detail[0].activeElement.innerHTML);
    });

    $(document).on('ajax:success', '#rules .delete', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#rules .confirm', function(e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.remove();
    });

    $(document).on('click', '#rules .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});
