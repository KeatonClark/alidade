class BomElement extends HTMLElement {
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

      autoColumnsDefinitions: {
        "LCSC Part #": {
          formatter: "link",
          formatterParams: {
            url: function(cell) {
              return "https://lcsc.com/product-detail/" +
                encodeURIComponent(cell.getValue()) + ".html";
            },
            target: "_blank",
          },
        },
      },
    });
  }
}

customElements.define("bom-table", BomElement);
