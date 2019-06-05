$(document).ready(function() {
    $(document).on('ajax:success', '#blacklisted_domains .create', function(e) {
        $('#blacklisted_domains').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#blacklisted_domains .delete', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#blacklisted_domains .confirm', function(e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.remove();
    });
});
