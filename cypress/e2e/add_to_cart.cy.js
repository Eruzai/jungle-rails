describe("Add to Cart", () => {
  beforeEach(() => {
    cy.visit("/");
    cy.contains("Welcome to The Jungle");
  })

  it("adds an item to the cart", () => {
    cy.contains("My Cart (0)")
    
    cy.contains("Add")
      .first()
      .click();

    cy.contains("My Cart (1)")
  });
})
