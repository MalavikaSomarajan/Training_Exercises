    $(document).ready(function() {
            // First Name
            $('#first-name').on('focusout', function() {
                let firstName = $(this).val();
                if (firstName === '') {
                     $('#first-name-error').text('First name is required').show();
                } 
                else if (!/^[a-zA-Z]+$/.test(firstName)) {
                    $('#first-name-error').text("First name should only contain alphabets");
                } else {
                    $('#first-name-error').text("");
                }
            });

            // Last Name
            $('#last-name').on('focusout', function() {
                let lastName = $(this).val();
                if (lastName === '') {
                     $('#last-name-error').text('Last name is required').show();
                }
                else if (!/^[a-zA-Z]+$/.test(lastName)) {
                    $('#last-name-error').text("Last name should only contain alphabets");
                } else {
                    $('#last-name-error').text("");
                }
            });

            //DOB
            var todayDate = new Date();
            var month = todayDate. getMonth() + 1;
            var year = todayDate.getUTCFullYear();
            var tdate = todayDate. getDate();
            var maxDate = year + "-" + month + "-" +tdate;
            document.getElementById("dob").setAttribute("max",maxDate);

             //Phone no
            $('#phone-number').on('focusout', function() {
                let phone = $(this).val();
                if (phone === '') {
                     $('#phone-error').text('Phone number is required').show();
                }
                else if (!/^\d{10}$/.test(phone)) {
                    $('#phone-error').text("Phone number must be 10 digits.");
                } else {
                    $('#phone-error').text("");
                }
            });

            // Email
            $('#email').on('focusout', function() {
                let email = $(this).val();
                let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (email === '') {
                     $('#email-error').text('Email is required').show();
                }
                else if (!emailRegex.test(email)) {
                    $('#email-error').text("Please enter a valid email address.");
                }else {
                    $('#email-error').text("");
                }
            });

            // City State 
            $('#state').on('change', function() {
                let state = $(this).val();
                let cities = {
                    "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
                    "Karnataka": ["Bangalore", "Mysore", "Mangalore"],
                    "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"],
                    "Kerala": ["Kochi", "Thiruvananthapuram", "Kozhikode"]
                };
                $('#city').empty().append('<option value="" disabled selected>Select City</option>');
                if (state) {
                    $.each(cities[state], function(index, city) {
                        $('#city').append(`<option value="${city}">${city}</option>`);
                    });
                }
            });

            // Username
            $('#username').on('focusout', function() {
                let username = $(this).val();
                if (username === ''){
                     $('#username-error').text('Username is required').show();
                }
                else if (!/^[a-zA-Z]+$/.test(username)) {
                    $('#username-error').text("Username should only contain alphabets.");
                } else {
                    $('#username-error').text("");
                }
            });

            //Password
            $('#password').on('focusout', function() {
                let password = $(this).val();
                let passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$/;
                if (password === '') {
                     $('#password-error').text('Password is required').show();
                }
                else if (!passwordRegex.test(password)) {
                    $('#password-error').text("Password must be 8 characters long, and include uppercase, lowercase, numbers, and special characters.");
                } else {
                    $('#password-error').text("");
                }
            });

            // Confirm Password
            $('#confirm-password').on('focusout', function() {
                let password = $('#password').val();
                let confirmPassword = $(this).val();
                if (password !== confirmPassword) {
                    $('#confirm-password-error').text("Passwords do not match.");
                } else {
                    $('#confirm-password-error').text("");
                }
            });

            // Enable Sign Up button
            $('#registration-form').on('submit', function(e) {
                e.preventDefault();
                let errors = $('.error').text();
                if (!errors) {
                    alert("Form submitted successfully!");
                } else {
                    alert("Please fix the errors before submitting.");
                }
            });
        });
    