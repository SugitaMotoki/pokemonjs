"use strict";

export const assignment = (identifier: {}, expression: any) => {
  return {
    type: "ExpressionStatement",
    expression: {
      type: "AssignmentExpression",
      operator: "=",
      left: identifier,
      right: expression.expression,
    },
  };
};
