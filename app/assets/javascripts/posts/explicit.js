$(document).ready(function () {
  $(document).on('ajax:success', '.post__explicit-link', function (e) {
    var explicit = e.detail[0].explicit
    var new_explicit_link = e.detail[0].explicit_link
    var explicit_link = $(this)

    if (explicit === true) {
      $(explicit_link).closest('.row').find('.post__information').append('<span class="post__explicit-label">18+</span>')
    } else if (explicit === false) {
      $(explicit_link).closest('.row').find('.post__information .post__explicit-label').remove()
    }

    $(explicit_link).closest('.post__actions').find('.dropdown-toggle').dropdown('toggle')
    $(explicit_link).replaceWith(new_explicit_link)
  })
})
