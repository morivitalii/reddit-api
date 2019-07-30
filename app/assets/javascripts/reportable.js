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

    $(document).on('ajax:success', '.reportForm', function (e) {
        var notification_text = e.detail[0];

        $('.modal').modal('hide');
        notification(notification_text);
    });

    $(document).on('change', '.reportForm .report-rule', function() {
        $('.reportForm').find('input[type="radio"]').prop('checked', false);
        $(this).prop('checked', true);
        $('#create_report_text').val($(this).val());
    });
});