$(document).ready(function() {
  $(document).on('ajax:success', '.signUp', function (e) {
    $('.modal').modal('hide');
    $('body').append(e.detail[0].activeElement.innerHTML);
    $('.modal').modal('show');
  });

  $(document).on('ajax:error', '.signUpForm', function (e) {
    grecaptcha.reset();
  });
});