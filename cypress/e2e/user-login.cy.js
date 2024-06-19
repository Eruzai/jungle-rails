describe("User Login", () => {
  beforeEach(() => {
    cy.visit("/");
    cy.contains("Welcome to The Jungle");
  })

  it("creates a new user", () => {
    cy.contains("Signup")
      .click();

    cy.get("[id=user_first_name]")
      .type("Tee");

    cy.get("[id=user_last_name]")
      .type("Ester");

    cy.get("[id=user_email]")
      .type("tester@email.com");

    cy.get("[id=user_password]")
      .type("tester123");

    cy.get("[id=user_password_confirmation]")
      .type("tester123");

    cy.contains("Submit")
      .click();

    cy.contains("Signed in as: Tee")
      .should("exist");
  });

  it("signs into an existing user", () => {
    cy.contains("Login")
      .click();

    cy.get("[id=email]")
      .type("ayooser@email.com")
    
    cy.get("[id=password]")
      .type("test1234");

    cy.contains("Submit")
      .click();

    cy.contains("Signed in as: Anew")
      .should("exist");
  })
})
