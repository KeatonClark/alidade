class ERCElement extends HTMLElement {
  async connectedCallback() {
    const src = this.dataset.src;

    const container = document.createElement("div");
    this.appendChild(container);

    const response = await fetch(src);

    if (!response.ok) {
      throw new Error(`Failed to load ${src}: ${response.status}`);
    }

    const csv = await response.text();

    this.table = new Tabulator(container, {
      data: csv,
      importFormat: "csv",
      autoColumns: true,
      movableColumns: true,
      resizableColumns: true,
      layout: "fitColumns",
      autoColumns: true,

      rowFormatter: (row) => {
        const data = row.getData();
        const el = row.getElement();
        if (data.Severity === "warning") {
          el.classList.add("erc-warning")
        } else if (data.Severity === "error") {
          el.classList.add("erc-error")
        }
      },
    });
  }
}

customElements.define("erc-table", ERCElement);
