"use strict";

export const consoleLog = (expression: any) => {
  return {
    type: "ExpressionStatement",
    expression: {
      type: "CallExpression",
      callee: {
        type: "MemberExpression",
        computed: false,
        object: {
          type: "Identifier",
          name: "console",
        },
        property: {
          type: "Identifier",
          name: "log",
        },
      },
      arguments: [expression.expression],
    },
  };
};
