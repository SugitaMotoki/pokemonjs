"use strict";

export const expression = (content: {}) => {
  return {
    type: "ExpressionStatement",
    expression: content,
  };
};
