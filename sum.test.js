const sum = require("./sum");

describe("sum function", () => {
  it("adds two numbers correctly", () => {
    expect(sum(2, 3)).toBe(5);
  });

  it("adds positive and negative numbers correctly", () => {
    expect(sum(-2, 3)).toBe(1);
  });

  it("returns 0 when adding 0 to any number", () => {
    expect(sum(0, 7)).toBe(7);
    expect(sum(0, -4)).toBe(-4);
    expect(sum(0, 0)).toBe(0);
  });
});
