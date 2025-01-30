document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("[data-countdown-date]").forEach((countdownElement) => {
      const targetDate = new Date(countdownElement.dataset.countdownDate).getTime();
  
      function updateCountdown() {
        const now = new Date().getTime();
        const timeRemaining = targetDate - now;
  
        if (timeRemaining <= 0) {
          countdownElement.innerHTML = "<strong>General registration is now open!</strong>";
          clearInterval(interval);
        } else {
          const days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
          countdownElement.innerHTML = `<strong>${days} days left until general registration.</strong>`;
        }
      }
  
      updateCountdown(); // Run immediately
      const interval = setInterval(updateCountdown, 60000); // Update every minute
    });
  });
  