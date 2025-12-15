import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [
    "ingredientElement",
    "ingredients",
    "ingredientInput",
    "submitButton",
  ];

  addIngredient(event) {
    event.preventDefault();
    const ingredient = this.ingredientInputTarget.value;
    const hasIngredients = this.ingredientInputTargets > 0;
    const submitButton = this.submitButtonTarget;

    this.toggleSubmitButton(submitButton, hasIngredients);

    if (hasIngredients) {
      return;
    }

    const newIngredientInput = document.createElement("input");
    newIngredientInput.type = "text";
    newIngredientInput.name = "recipe[ingredients][]";
    newIngredientInput.setAttribute("data-search-target", "ingredientElement");
    newIngredientInput.className = "form-control  d-none";
    newIngredientInput.value = ingredient;

    this.ingredientInputTarget.value = "";
    this.ingredientsTarget.appendChild(newIngredientInput);

    const badge = document.createElement("link");
    badge.type = "button";
    badge.className = "badge text-bg-secondary me-2 text-decoration-none";
    badge.setAttribute("data-search-target", "badge");
    badge.setAttribute("data-value", ingredient);
    badge.setAttribute("data-action", "click->search#removeIngredient");
    badge.innerHTML = `
      ${ingredient}
      <i class="bi bi-x"></i>
    `;
    this.ingredientsTarget.appendChild(badge);
  }

  removeIngredient(event) {
    const ingredientValue = event.currentTarget.getAttribute("data-value");
    const ingridientInput = this.ingredientElementTargets.filter(
      (input) => input.value === ingredientValue
    );
    ingridientInput[0].remove();
    event.currentTarget.remove();

    const hasIngredients = this.ingredientInputTargets.length > 0;
    const submitButton = this.submitButtonTarget;

    this.toggleSubmitButton(submitButton, hasIngredients);
  }

  toggleSubmitButton(submitButton, hasIngredients) {
    console.log(submitButton);
    console.log(submitButton.classList);
    if (hasIngredients) {
      submitButton.classList.add("d-none");
    } else {
      submitButton.classList.remove("d-none");
    }
  }
}
