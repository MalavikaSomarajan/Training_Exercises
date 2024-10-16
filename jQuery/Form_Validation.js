$(document).ready(function() {
  $('#loginForm input').on('input', function() {
    checkFormValidity();
  });

  // Email validation
  window.validateEmail = function() {
    const email = $('#email').val();
    const emailError = $('#emailError');
    if (email === '') {
      emailError.text('Email is required').show();
    } else if (!/^\S+@\S+\.\S+$/.test(email)) {
      emailError.text('Enter a valid email').show();
    } else {
      emailError.hide();
    }
  };

  // Password validation
  window.validatePassword = function() {
    const password = $('#password').val();
    const passwordError = $('#passwordError');
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;

    if (password === '') {
      passwordError.text('Password is required').show();
    } else if (!passwordRegex.test(password)) {
      passwordError.text('Password must be 6 characters with uppercase, lowercase, numbers, and special characters').show();
    } else {
      passwordError.hide();
    }
  };

  // Check form validity
  function checkFormValidity() {
     const email = $('#email').val();
     const password = $('#password').val();
     const isFormValid = email !== '' && password !== '' && $('#emailError').is(':hidden') && $('#passwordError').is(':hidden');
     $('#loginButton').prop('disabled', !isFormValid);
  }

  $('#loginForm').on('submit', function(event) {
       event.preventDefault();  // Prevents form from submitting & reloading page
       alert('Form Submitted!');
   });
});
