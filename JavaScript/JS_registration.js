document.addEventListener('DOMContentLoaded', function() {
    // First Name
    document.getElementById('first-name').addEventListener('focusout', function() {
        let firstName = this.value;
        let firstNameError = document.getElementById('first-name-error');
        if (firstName === '') {
            firstNameError.textContent = 'First name is required';
            firstNameError.style.display = 'block';
        } else if (!/^[a-zA-Z]+$/.test(firstName)) {
            firstNameError.textContent = 'First name should only contain alphabets';
        } else {
            firstNameError.textContent = '';
        }
    });

    // Last Name
    document.getElementById('last-name').addEventListener('focusout', function() {
        let lastName = this.value;
        let lastNameError = document.getElementById('last-name-error');
        if (lastName === '') {
            lastNameError.textContent = 'Last name is required';
            lastNameError.style.display = 'block';
        } else if (!/^[a-zA-Z]+$/.test(lastName)) {
            lastNameError.textContent = 'Last name should only contain alphabets';
        } else {
            lastNameError.textContent = '';
        }
    });

    // Date of Birth (DOB)
    var todayDate = new Date();
    var month = todayDate.getMonth() + 1;
    var year = todayDate.getUTCFullYear();
    var tdate = todayDate.getDate();
    var maxDate = year + '-' + (month < 10 ? '0' + month : month) + '-' + (tdate < 10 ? '0' + tdate : tdate);
    document.getElementById('dob').setAttribute('max', maxDate);

    // Phone number
    document.getElementById('phone-number').addEventListener('focusout', function() {
        let phone = this.value;
        let phoneError = document.getElementById('phone-error');
        if (phone === '') {
            phoneError.textContent = 'Phone number is required';
            phoneError.style.display = 'block';
        } else if (!/^\d{10}$/.test(phone)) {
            phoneError.textContent = 'Phone number must be 10 digits';
        } else {
            phoneError.textContent = '';
        }
    });

    // Email
    document.getElementById('email').addEventListener('focusout', function() {
        let email = this.value;
        let emailError = document.getElementById('email-error');
        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email === '') {
            emailError.textContent = 'Email is required';
            emailError.style.display = 'block';
        } else if (!emailRegex.test(email)) {
            emailError.textContent = 'Please enter a valid email address';
        } else {
            emailError.textContent = '';
        }
    });

    // City and State
    document.getElementById('state').addEventListener('change', function() {
        let state = this.value;
        let cities = {
            "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
            "Karnataka": ["Bangalore", "Mysore", "Mangalore"],
            "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"],
            "Kerala": ["Kochi", "Thiruvananthapuram", "Kozhikode"]
        };
        let citySelect = document.getElementById('city');
        citySelect.innerHTML = '<option value="" disabled selected>Select City</option>';
        if (state && cities[state]) {
            cities[state].forEach(function(city) {
                let option = document.createElement('option');
                option.value = city;
                option.textContent = city;
                citySelect.appendChild(option);
            });
        }
    });

    // Username
    document.getElementById('username').addEventListener('focusout', function() {
        let username = this.value;
        let usernameError = document.getElementById('username-error');
        if (username === '') {
            usernameError.textContent = 'Username is required';
            usernameError.style.display = 'block';
        } else if (!/^[a-zA-Z]+$/.test(username)) {
            usernameError.textContent = 'Username should only contain alphabets';
        } else {
            usernameError.textContent = '';
        }
    });

    // Password
    document.getElementById('password').addEventListener('focusout', function() {
        let password = this.value;
        let passwordError = document.getElementById('password-error');
        let passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$/;
        if (password === '') {
            passwordError.textContent = 'Password is required';
            passwordError.style.display = 'block';
        } else if (!passwordRegex.test(password)) {
            passwordError.textContent = 'Password must be 8 characters long, and include uppercase, lowercase, numbers, and special characters';
        } else {
            passwordError.textContent = '';
        }
    });

    // Confirm Password
    document.getElementById('confirm-password').addEventListener('focusout', function() {
        let password = document.getElementById('password').value;
        let confirmPassword = this.value;
        let confirmPasswordError = document.getElementById('confirm-password-error');
        if (password !== confirmPassword) {
            confirmPasswordError.textContent = 'Passwords do not match';
        } else {
            confirmPasswordError.textContent = '';
        }
    });

    // Enable Sign Up button
    document.getElementById('registration-form').addEventListener('submit', function(e) {
        e.preventDefault();
        let errors = Array.from(document.getElementsByClassName('error')).some(el => el.textContent !== '');
        if (!errors) {
            alert('Form submitted successfully!');
        } else {
            alert('Please fix the errors before submitting.');
        }
    });
});
