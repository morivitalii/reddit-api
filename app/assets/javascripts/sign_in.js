$(document).ready(function() {
  $(document).on('ajax:success', '.signIn', function (e) {
    $('.modal').modal('hide');
    $('body').append(e.detail[0].activeElement.innerHTML);
    $('.modal').modal('show');
  });

  $(document).on('ajax:error', '.signInForm', function (e) {
    grecaptcha.reset();
  });
});