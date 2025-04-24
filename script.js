// Function to toggle navigation menu visibility on small screens
const toggleNav = () => {
    const nav = document.getElementById("nav-links");
    nav.style.display = nav.style.display === "block" ? "none" : "block";
  };
  
  // Add event listener for the navigation toggle button
  document.getElementById("nav-toggle").addEventListener("click", toggleNav);
  
  // Form validation logic
  const form = document.getElementById("contact-form");
  
  form.addEventListener("submit", function(event) {
    // Prevent form submission if validation fails
    event.preventDefault();
    
    // Get form values
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const message = document.getElementById("message").value;
  
    let valid = true;
  
    // Validate name (required and at least 3 characters)
    if (name.trim().length < 3) {
      document.getElementById("name-error").innerText = "Name must be at least 3 characters long.";
      valid = false;
    } else {
      document.getElementById("name-error").innerText = "";
    }
  
    // Validate email (must be in valid email format)
    const emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
    if (!email.match(emailPattern)) {
      document.getElementById("email-error").innerText = "Please enter a valid email address.";
      valid = false;
    } else {
      document.getElementById("email-error").innerText = "";
    }
  
    // Validate message (required and at least 10 characters)
    if (message.trim().length < 10) {
      document.getElementById("message-error").innerText = "Message must be at least 10 characters long.";
      valid = false;
    } else {
      document.getElementById("message-error").innerText = "";
    }
  
    // If everything is valid, submit the form
    if (valid) {
      alert("Form submitted successfully!");
      form.reset();
    }
  });
  