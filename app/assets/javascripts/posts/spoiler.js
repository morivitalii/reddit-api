$(document).ready(function () {
  $(document).on('ajax:success', '.post__spoiler-link', function (e) {
    var spoiler = e.detail[0].spoiler
    var new_spoiler_link = e.detail[0].spoiler_link
    var spoiler_link = $(this)

    if (spoiler === true) {
      $(spoiler_link).closest('.row').find('.post__information').append('<span class="post__spoiler-label">Спойлер</span>')
    } else if (spoiler === false) {
      $(spoiler_link).closest('.row').find('.post__information .post__spoiler-label').remove()
    }

    $(spoiler_link).closest('.post__actions').find('.dropdown-toggle').dropdown('toggle')
    $(spoiler_link).replaceWith(new_spoiler_link)
  })
})
