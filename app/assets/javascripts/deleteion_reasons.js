$(document).ready(function() {
    $(document).on('ajax:success', '#deletion_reasons .create', function(e) {
        $('#deletion_reasons').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#deletion_reasons .update', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#deletion_reasons .updateForm', function (e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.replaceWith(e.detail[0].activeElement.innerHTML);
    });

    $(document).on('click', '#deletion_reasons .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});
