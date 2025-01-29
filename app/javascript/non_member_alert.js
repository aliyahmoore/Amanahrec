document.addEventListener("DOMContentLoaded", () => {
    // Handle non-member alert clicks
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

    // Handle countdown timers
    const countdownElements = document.querySelectorAll("[id^='countdown-']");

    countdownElements.forEach(element => {
        const eventId = element.id.split('-')[1]; // Extract event ID from the element ID
        const countdownDate = element.getAttribute("data-countdown-date"); // Assume a `data-countdown-date` attribute in the view

        if (countdownDate) {
            const targetDate = new Date(countdownDate).getTime();

            const updateCountdown = () => {
                const now = new Date().getTime();
                const distance = targetDate - now;

                if (distance > 0) {
                    const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));

                    element.innerText = `${days} days`;
                } else {
                    element.innerText = "General registration is now open!";
                    clearInterval(timer); // Stop the timer once it reaches the target date
                }
            };

            const timer = setInterval(updateCountdown, 3600000); // Update every hour (instead of every second)
            updateCountdown(); // Initialize the countdown immediately
        }
    });
});
