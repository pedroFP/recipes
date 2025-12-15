import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "field"];

  add() {
    const field = document.createElement("div");
    field.className = "input-group mb-2";
    field.dataset.ingredientsTarget = "field";
    field.innerHTML = `
      <input type="text" name="recipe[ingredients][]" class="form-control" placeholder="Ingredient">
      <button type="button" class="btn btn-danger" data-action="ingredients#remove">Remove</button>
    `;
    this.containerTarget.appendChild(field);
  }

  remove(event) {
    event.currentTarget.closest("[data-ingredients-target='field']").remove();
  }
}
