document.addEventListener("DOMContentLoaded", function() {
  const recurrencePatternSelect = document.getElementById('activity_recurrence_pattern');
  const recurrenceDaysField = document.getElementById('recurrence_days_field');

  console.log('Initial Recurrence Pattern:', recurrencePatternSelect.value);  // Debugging line

  // Initially hide or show the recurrence days based on the selected pattern
  toggleRecurrenceDays(recurrencePatternSelect.value);

  // Listen for changes in the recurrence pattern dropdown
  recurrencePatternSelect.addEventListener('change', function() {
    console.log('Recurrence Pattern Changed:', recurrencePatternSelect.value);  // Debugging line
    toggleRecurrenceDays(recurrencePatternSelect.value);
  });

  // Function to toggle the visibility of the recurrence days checkboxes
  function toggleRecurrenceDays(value) {
    console.log('Toggling Days for:', value);  // Debugging line
    if (value === 'weekly') {
      recurrenceDaysField.style.display = 'block';  // Show the checkboxes
    } else {
      recurrenceDaysField.style.display = 'none';  // Hide the checkboxes
    }
  }
});
