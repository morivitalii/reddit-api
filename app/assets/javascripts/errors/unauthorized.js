document.addEventListener('ajax:error', function (e) {
  // If user is not signed in
  if(e.detail[2].status === 401) {
    // In response we have sign in form in modal, so we show it.
    // Before as well we need to close other modals.
    $('.modal').modal('hide');
    $('body').append(e.detail[0].activeElement.innerHTML);
    $('.modal').modal('show');
  }
});