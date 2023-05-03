"use strict";

export const literal = (value: number | string | boolean) => {
  const raw =
    /* eslint-disable-next-line no-useless-escape */
    typeof value === "string" ? `\"${value}\"` : String(value);
  return {
    type: "Literal",
    value: value,
    raw: raw,
  };
};
