"use strict";

export const loops = (test: any, statements: any) => {
  return {
    type: "WhileStatement",
    test: test.expression,
    body: {
      type: "BlockStatement",
      body: statements,
    },
  };
};
