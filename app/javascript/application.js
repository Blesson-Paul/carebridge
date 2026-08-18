import "@hotwired/turbo-rails"
import "bootstrap"

const setupAgePreview = () => {
  const dateInput = document.querySelector("#date_of_birth");
  const agePreview = document.querySelector("#age_preview");

  if (!dateInput || !agePreview) return;

  dateInput.addEventListener("change", () => {
    if (!dateInput.value) {
      agePreview.textContent = "Choose date of birth to see age.";
      return;
    }

    const today = new Date();
    const birthday = new Date(dateInput.value);
    let age = today.getFullYear() - birthday.getFullYear();
    const monthDifference = today.getMonth() - birthday.getMonth();
    const dayDifference = today.getDate() - birthday.getDate();

    if (monthDifference < 0 || (monthDifference === 0 && dayDifference < 0)) {
      age -= 1;
    }

    agePreview.textContent = `Age: ${age} years old`;
  });
};

document.addEventListener("turbo:load", setupAgePreview);
