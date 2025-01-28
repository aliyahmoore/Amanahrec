document.addEventListener('DOMContentLoaded', () => {
  const editButtons = document.querySelectorAll('.edit-button');

  editButtons.forEach(button => {
    button.addEventListener('click', (event) => {
      event.preventDefault(); // Prevent the default link behavior
      const mediaMentionId = event.target.dataset.mediaMentionId; // Get the media mention ID from the data attribute
      const formContainer = document.getElementById(`edit-form-${mediaMentionId}`); // Get the form container by ID

      // Toggle the form visibility
      if (formContainer.style.display === 'none' || formContainer.style.display === '') {
        formContainer.style.display = 'block';
      } else {
        formContainer.style.display = 'none';
      }
    });
  });
});
