it("should results when searching", () => {
  cy.visit("/");
  cy.get("#wp-block-search__input-1").type("cypress");
  cy.get(".wp-block-search__button").click();

  cy.get(".entry-title").should("contain", "cypress");
  cy.get(".status-publish").first().should("be.visible");
});
