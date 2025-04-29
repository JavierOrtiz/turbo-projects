import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-field"
export default class extends Controller {
  connect() {
    console.log('Cargamos')
  }

  submit(event) {
    if (event.type === "keydown" && event.key !== "Enter") return

    const form = this.element.closest("form")
    if (form) {
      form.requestSubmit()
    }
  }
}
