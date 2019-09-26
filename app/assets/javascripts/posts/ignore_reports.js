$(document).ready(function () {
  $(document).on('ajax:success', '.post__ignore-reports-link', function (e) {
    var new_ignore_reports_link = e.detail[0].ignore_reports_link
    var ignore_reports_link = $(this)

    $(ignore_reports_link).closest('.post__actions').find('.dropdown-toggle').dropdown('toggle')
    $(ignore_reports_link).replaceWith(new_ignore_reports_link)
  })
})
