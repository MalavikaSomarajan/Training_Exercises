document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');
    const loginButton = document.getElementById('loginButton');
  
    // Add event listener for input changes
    loginForm.querySelectorAll('input').forEach(function(input) {
      input.addEventListener('input', checkFormValidity);
    });
  
    // Email validation
    window.validateEmail = function() {
      const email = emailInput.value;
      if (email === '') {
        emailError.textContent = 'Email is required';
        emailError.style.display = 'block';
      } else if (!/^\S+@\S+\.\S+$/.test(email)) {
        emailError.textContent = 'Enter a valid email';
        emailError.style.display = 'block';
      } else {
        emailError.style.display = 'none';
      }
    };
  
    // Password validation
    window.validatePassword = function() {
      const password = passwordInput.value;
      const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;
  
      if (password === '') {
        passwordError.textContent = 'Password is required';
        passwordError.style.display = 'block';
      } else if (!passwordRegex.test(password)) {
        passwordError.textContent = 'Password must be 6 characters with uppercase, lowercase, numbers, and special characters';
        passwordError.style.display = 'block';
      } else {
        passwordError.style.display = 'none';
      }
    };
  
    // Check form validity
    function checkFormValidity() {
      const email = emailInput.value;
      const password = passwordInput.value;
      const isFormValid = email !== '' && password !== '' && emailError.style.display === 'none' && passwordError.style.display === 'none';
      loginButton.disabled = !isFormValid;
    }
  
    // Form submit handler
    loginForm.addEventListener('submit', function(event) {
      event.preventDefault(); // Prevent form submission
      alert('Form Submitted!');
    });
  });
  