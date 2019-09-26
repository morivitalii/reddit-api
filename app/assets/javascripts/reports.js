$(document).on('click', '.reports__item-details-link', function (e) {
  $(this).closest('.reports__item').find('.reports__item-details').toggle()
})
