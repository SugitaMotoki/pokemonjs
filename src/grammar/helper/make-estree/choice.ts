"use strict";

type Statement = {};

type Condition = {
  test: any;
  statements: Statement[];
};

export const choice = (
  conditions: Condition[],
  alternate: any,
  _index: number,
): {} => {
  let index = _index;
  const condition: Condition = conditions[index];
  index++;

  const tree: {
    type: "IfStatement";
    test: {};
    consequent: {};
    alternate: {} | null;
  } = {
    type: "IfStatement",
    test: condition.test.expression,
    consequent: {
      type: "BlockStatement",
      body: condition.statements,
    },
    alternate: null,
  };

  if (conditions.length !== index) {
    tree.alternate = choice(conditions, alternate, index);
  } else if (alternate !== null) {
    tree.alternate = {
      type: "BlockStatement",
      body: alternate,
    };
  }
  return tree;
};
