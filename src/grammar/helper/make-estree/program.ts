"use strict";

import { useStrict } from "./use-strict";

export const program = (body: object[]) => {
  return {
    type: "Program",
    body: [useStrict(), ...body],
    sourceType: "script",
  };
};
