const multiply = require("./multiply");

describe("multiply function", () => {
  it("multiply two numbers correctly", () => {
    expect(multiply(2, 3)).toBe(6);
  });

  it("multiply positive and negative numbers correctly", () => {
    expect(multiply(-2, 3)).toBe(-6);
  });
});
