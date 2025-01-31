

document.addEventListener("DOMContentLoaded", function () {
    // Select all dropdowns
    const dropdowns = document.querySelectorAll(".dropdown");
  
    dropdowns.forEach((dropdown) => {
      // Show dropdown on hover
      dropdown.addEventListener("mouseover", function () {
        const menu = this.querySelector(".dropdown-menu");
        if (menu) menu.classList.add("show");
      });
  
      // Hide dropdown when mouse leaves
      dropdown.addEventListener("mouseleave", function () {
        const menu = this.querySelector(".dropdown-menu");
        if (menu) menu.classList.remove("show");
      });
    });
  });
  