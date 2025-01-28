document.addEventListener("DOMContentLoaded", () => {
    const nonMemberLinks = document.querySelectorAll(".non-member-alert");
  
    nonMemberLinks.forEach(link => {
      link.addEventListener("click", (e) => {
        e.preventDefault(); // Prevent the default link behavior
  
        // Display an alert message without redirecting
        alert(
          "This event is currently in the early access period and available to members only. Please sign up for membership to access this event."
        );
      });
    });
  });
  