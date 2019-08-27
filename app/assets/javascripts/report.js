$(document).ready(function() {
    $(document).on('ajax:success', '.reports', function(e) {
        $(this).closest('.row').append(e.detail[0].activeElement.innerHTML);
        $('[data-toggle="tooltip"]').tooltip();
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.report', function(e) {
        $(this).closest('.row').append(e.detail[0].activeElement.innerHTML);
        $(this).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.new_create_report_form', function (e) {
        var notification_text = e.detail[0];

        $('.modal').modal('hide');
        notification(notification_text);
    });

    $(document).on('change', '.new_create_report_form .reason', function() {
        $('.new_create_report_form').find('input[type="radio"]').prop('checked', false);
        $(this).prop('checked', true);
        $('#create_report_form_text').val($(this).val());
    });
});