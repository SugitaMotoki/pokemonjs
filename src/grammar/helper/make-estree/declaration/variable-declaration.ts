"use strict";

export const variableDeclaration = (
  isConst: boolean,
  identifier: {},
  expression: any,
) => {
  return {
    type: "VariableDeclaration",
    declarations: [
      {
        type: "VariableDeclarator",
        id: identifier,
        init: expression.expression,
      },
    ],
    kind: isConst ? "const" : "let",
  };
};
