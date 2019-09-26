$(document).ready(function () {
  $(document).on('ajax:success', '.comment__reports-link', function (e) {
    $(this).closest('.row').append(e.detail[0].activeElement.innerHTML)
    $('[data-toggle="tooltip"]').tooltip()
    $('.modal').modal('show')
  })
})
