class DRCElement extends HTMLElement {
  async connectedCallback() {
    const src = this.dataset.src;

    const container = document.createElement("div");
    this.appendChild(container);

    const response = await fetch(src);

    if (!response.ok) {
      throw new Error(`Failed to load ${src}: ${response.status}`);
    }

    const csv = await response.text();
    const lines = csv
      .split(/\r?\n/)
      .map(line => line.trim())
      .filter(Boolean);

    if (lines.length <= 1) {
      container.textContent = "No Issues!";
      return;
    }

    this.table = new Tabulator(container, {
      data: csv,
      importFormat: "csv",
      autoColumns: true,
      movableColumns: true,
      resizableColumns: true,
      layout: "fitColumns",

      rowFormatter: (row) => {
        const data = row.getData();
        const el = row.getElement();
        if (data.Severity === "warning") {
          el.classList.add("drc-warning")
        } else if (data.Severity === "error") {
          el.classList.add("drc-error")
        }
      },
    });
  }
}

customElements.define("drc-table", DRCElement);
