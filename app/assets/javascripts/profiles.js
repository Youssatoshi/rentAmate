

document.addEventListener('DOMContentLoaded', function() {
  // Add event listener to the submit button of the profile creation form
  var form = document.querySelector('#new_profile_form');
  if (form) {
    form.addEventListener('submit', function(event) {
      event.preventDefault(); // Prevent the default form submission

      // Perform client-side form validation here if needed

      // Submit the form via AJAX
      var formData = new FormData(form);
      var xhr = new XMLHttpRequest();
      xhr.open('POST', form.action, true);
      xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
      xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
          if (xhr.status === 200) {
            // Handle successful form submission
            console.log('Profile created successfully!');
          } else {
            // Handle form submission error
            console.error('Failed to create profile:', xhr.responseText);
          }
        }
      };
      xhr.send(formData);
    });
  }
});
