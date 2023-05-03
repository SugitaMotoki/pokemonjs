"use strict";

export const useStrict = () => {
  const value = "use strict";
  /* eslint-disable-next-line no-useless-escape */
  const raw = `\"${value}\"`;

  return {
    type: "ExpressionStatement",
    expression: {
      type: "Literal",
      value: value,
      raw: raw,
    },
    directive: value,
  };
};
