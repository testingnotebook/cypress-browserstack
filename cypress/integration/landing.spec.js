it("should display latest posts on root page", () => {
  cy.visit("/");
  cy.get(".status-publish").first().should("be.visible");
});
