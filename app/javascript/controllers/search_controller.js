import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [
    "badge",
    "ingredients",
    "ingredientInput",
    "ingredientsBadges",
  ];

  addIngredient(event) {
    event.preventDefault();
    const ingredient = this.ingredientInputTarget.value;

    if (ingredient.length == 0) {
      return;
    }

    const badgeInput = document.createElement("input");
    badgeInput.type = "text";
    badgeInput.name = "recipe[ingredients][]";
    badgeInput.className = "form-control";
    badgeInput.value = ingredient;

    this.ingredientInputTarget.value = "";
    this.ingredientsTarget.appendChild(badgeInput);

    const badge = document.createElement("link");
    badge.type = "button";
    badge.className = "badge text-bg-secondary me-2";
    badge.setAttribute("data-search-target", "badge");
    badge.setAttribute("data-action", "click->search#removeIngredient");

    badge.innerHTML = `
      ${ingredient}
      <i class="bi bi-x"></i>
    `;

    this.ingredientsBadgesTarget.appendChild(badge);
  }

  removeIngredient(event) {
    this.badgeTarget.remove();
  }
}
