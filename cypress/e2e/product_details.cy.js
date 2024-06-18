describe("Product Details", () => {
  beforeEach(() => {
    cy.visit("/");
    cy.contains("Welcome to The Jungle");
  })

  it("navigates to the product details page", () => {
    cy.get("[alt='Scented Blade']")
      .click();

    cy.get("article.product-detail")
      .should("exist");
  });
})
