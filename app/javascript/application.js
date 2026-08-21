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
const setupConditionSearch = () => {
  const searchInput = document.getElementById("conditionSearchInput");
  const clearBtn = document.getElementById("clearSearchBtn");
  const cards = document.querySelectorAll(".condition-card");
  const noResults = document.getElementById("noSearchResults");

  if (!searchInput) return;

  searchInput.addEventListener("input", () => {
    const query = searchInput.value.toLowerCase().trim();
    let visibleCount = 0;

    // Show or hide clear button (X)
    if (clearBtn) {
      clearBtn.classList.toggle("d-none", query.length === 0);
    }

    // Filter cards in real time
    cards.forEach((card) => {
      const cardText = card.textContent.toLowerCase();
      if (cardText.includes(query)) {
        card.style.display = "";
        visibleCount++;
      } else {
        card.style.display = "none";
      }
    });

    // Show "No Results" message if nothing matches
    if (noResults) {
      noResults.classList.toggle("d-none", visibleCount > 0 || query.length === 0);
    }
  });

  // Clear search on X click
  if (clearBtn) {
    clearBtn.addEventListener("click", () => {
      searchInput.value = "";
      searchInput.dispatchEvent(new Event("input"));
      searchInput.focus();
    });
  }
};

document.addEventListener("turbo:load", setupConditionSearch);
document.addEventListener("turbo:render", setupConditionSearch);
const scrollMessagesToBottom = () => {
    const messages = document.getElementById("messages");
    if (!messages) return;

    messages.scrollTo({
      top: messages.scrollHeight,
      behavior: "smooth"
    });
  };

  document.addEventListener("turbo:load", scrollMessagesToBottom);

  document.addEventListener("turbo:before-stream-render", (event) => {
    if (event.target.getAttribute("target") !== "messages") return;

    const render = event.detail.render;

    event.detail.render = (streamElement) => {
      render(streamElement);
      requestAnimationFrame(scrollMessagesToBottom);
    };
  });
