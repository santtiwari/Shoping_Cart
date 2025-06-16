$(function () {
    // Custom validation methods
    jQuery.validator.addMethod('lettersonly', function (value, element) {
        return this.optional(element) || /^[a-zA-Z\s]+$/.test(value);
    }, 'Letters only');

    jQuery.validator.addMethod('space', function (value, element) {
        return this.optional(element) || !/\s/.test(value);
    }, 'No spaces allowed');

    jQuery.validator.addMethod('numericOnly', function (value, element) {
        return this.optional(element) || /^[0-9]+$/.test(value);
    }, 'Digits only');

    // User Registration Form Validation
    $('#userRegister').validate({
        rules: {
            name: {
                required: true,
                lettersonly: true
            },
            email: {
                required: true,
                space: true,
                email: true
            },
            mobilenumber: {
                required: true,
                space: true,
                numericOnly: true,
                minlength: 10,
                maxlength: 12
            },
            password: {
                required: true,
                space: true
            },
            confirmpassword: {
                required: true,
                space: true,
                equalTo: '#pass'
            },
            address: {
                required: true,
                space: true
            },
            city: {
                required: true,
                lettersonly: true
            },
            state: {
                required: true,
                lettersonly: true
            },
            pincode: {
                required: true,
                space: true,
                numericOnly: true
            },
            img: {
                required: true
            }
        },
        messages: {
            name: {
                required: 'This field is required. Kindly fill the data.',
                lettersonly: 'Invalid name'
            },
            email: {
                required: 'Email is required',
                space: 'Space not allowed',
                email: 'Invalid email format'
            },
            mobilenumber: {
                required: 'Mobile number is required',
                space: 'Space not allowed',
                numericOnly: 'Only digits allowed',
                minlength: 'Minimum 10 digits required',
                maxlength: 'Maximum 12 digits allowed'
            },
            password: {
                required: 'Password is required',
                space: 'Space not allowed'
            },
            confirmpassword: {
                required: 'Confirm password is required',
                space: 'Space not allowed',
                equalTo: 'Passwords do not match'
            },
            address: {
                required: 'Address is required',
                space: 'Space not allowed'
            },
            city: {
                required: 'City is required',
                lettersonly: 'Letters only'
            },
            state: {
                required: 'State is required',
                lettersonly: 'Letters only'
            },
            pincode: {
                required: 'Pin code is required',
                space: 'Space not allowed',
                numericOnly: 'Only digits allowed'
            },
            img: {
                required: 'Image is required'
            }
        },
        errorClass: "is-invalid",
        validClass: "is-valid",
        errorElement: "div",
        errorPlacement: function (error, element) {
            error.addClass('invalid-feedback');
            error.insertAfter(element);
        },
        highlight: function (element) {
            $(element).addClass('is-invalid').removeClass('is-valid');
        },
        unhighlight: function (element) {
            $(element).removeClass('is-invalid').addClass('is-valid');
        }
    });

    // Reset Password Form (if needed)
    $('#resetPassword').validate({
        rules: {
            password: {
                required: true,
                space: true
            },
            confirmPassword: {
                required: true,
                space: true,
                equalTo: '#pass'
            }
        },
        messages: {
            password: {
                required: 'Password is required',
                space: 'Space not allowed'
            },
            confirmPassword: {
                required: 'Confirm password is required',
                space: 'Space not allowed',
                equalTo: 'Passwords do not match'
            }
        },
        errorClass: "is-invalid",
        validClass: "is-valid",
        errorElement: "div",
        errorPlacement: function (error, element) {
            error.addClass('invalid-feedback');
            error.insertAfter(element);
        },
        highlight: function (element) {
            $(element).addClass('is-invalid').removeClass('is-valid');
        },
        unhighlight: function (element) {
            $(element).removeClass('is-invalid').addClass('is-valid');
        }
    });
    
    // order Password Form (if needed)
    $('#orders').validate({
        rules: {
        	firstName: {
                required: true,
                lettersonly: true
            },
            lastName: {
                required: true,
                lettersonly: true
            },
            email: {
                required: true,
                space: true,
                email: true
            },
            mobileNo: {
                required: true,
                space: true,
                numericOnly: true,
                minlength: 10,
                maxlength: 12
            },
            address: {
                required: true,
                space: true
            },
            city: {
                required: true,
                lettersonly: true
            },
            state: {
                required: true,
                lettersonly: true
            },
            pincode: {
                required: true,
                space: true,
                numericOnly: true
            },
            paymentType: {
            	required: true,
            }
        },
        messages: {
        	firstName: {
                required: 'This field is required. Kindly fill the data.',
                lettersonly: 'Invalid name'
            },
            lastName: {
                required: 'This field is required. Kindly fill the data.',
                lettersonly: 'Invalid name'
            },
            email: {
                required: 'Email is required',
                space: 'Space not allowed',
                email: 'Invalid email format'
            },
            mobileNo: {
                required: 'Mobile number is required',
                space: 'Space not allowed',
                numericOnly: 'Only digits allowed',
                minlength: 'Minimum 10 digits required',
                maxlength: 'Maximum 12 digits allowed'
            },
            address: {
                required: 'Address is required',
                space: 'Space not allowed'
            },
            city: {
                required: 'City is required',
                lettersonly: 'Letters only'
            },
            state: {
                required: 'State is required',
                lettersonly: 'Letters only'
            },
            pincode: {
                required: 'Pin code is required',
                space: 'Space not allowed',
                numericOnly: 'Only digits allowed'
            },
            paymentType: {
            	required: 'select Payment type'
            }
        },
        errorClass: "is-invalid",
        validClass: "is-valid",
        errorElement: "div",
        errorPlacement: function (error, element) {
            error.addClass('invalid-feedback');
            error.insertAfter(element);
        },
        highlight: function (element) {
            $(element).addClass('is-invalid').removeClass('is-valid');
        },
        unhighlight: function (element) {
            $(element).removeClass('is-invalid').addClass('is-valid');
        }
    });
    
});
