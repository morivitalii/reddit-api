$(document).ready(function() {
  $(document).on('ajax:success', '.sign_in', function (e) {
    $('.modal').modal('hide');
    $('body').append(e.detail[0].activeElement.innerHTML);
    $('.modal').modal('show');
  });

  $(document).on('ajax:error', '.new_sign_in_form', function (e) {
    grecaptcha.reset();
  });
});