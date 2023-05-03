"use strict";

export const identifier = (identifierPokemon: string) => {
  return {
    type: "Identifier",
    name: identifierPokemon,
  };
};
