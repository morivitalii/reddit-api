$(document).ready(function() {
    $(document).on('ajax:success', '#tags .create', function(e) {
        $('#tags').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#tags .update', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#tags .updateForm', function (e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.replaceWith(e.detail[0].activeElement.innerHTML);
    });
});
