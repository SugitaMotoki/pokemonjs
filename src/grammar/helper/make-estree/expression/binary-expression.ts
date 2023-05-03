"use strict";

export const binaryExpression = (left: {}, operator: string, right: {}) => {
  return {
    type: "BinaryExpression",
    operator,
    left,
    right,
  };
};
