"use strict";

/** ESTreeを生成するモジュール */
export * as makeESTree from "./make-estree";

export const removeBlank = (input: string[]) => {
  const locationOfCharacter = 1;
  return input.map((value) => value[locationOfCharacter]);
};

export const unicode2string = (hex: string) => {
  const unicode = `0x${hex}`;
  return String.fromCharCode(Number(unicode));
};

export const print = (data: any) => {
  console.log(data);
};
