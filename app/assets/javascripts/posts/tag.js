$(document).ready(function () {
  $(document).on('ajax:success', '.post__tag-link', function (e) {
    $(this).closest('.post').append(e.detail[0].activeElement.innerHTML)
    $(this).closest('.post__actions').find('.dropdown-toggle').dropdown('toggle')
    $('.modal').modal('show')
  })
})
