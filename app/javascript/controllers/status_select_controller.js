import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="status-select"
export default class extends Controller {
  connect() {
    console.log('Cargamos');
  }

  submitOnChange() {
    const form = this.element.closest("form")
    if (form) {
      form.requestSubmit()
    }
  }
}
