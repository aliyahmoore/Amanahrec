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
          const hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); 
          
          const dayText = days === 1 ? "day" : "days";
          const hourText = hours === 1 ? "hour" : "hours";
          countdownElement.innerHTML = `<strong>${days} ${dayText} and ${hours} ${hourText}</strong>`;          
        }
      }
  
      updateCountdown(); // Run immediately
      const interval = setInterval(updateCountdown, 60000); // Update every minute
    });
  });