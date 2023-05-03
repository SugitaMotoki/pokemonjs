/* eslint no-magic-numbers: "off" */
"use strict";

// パーサの読み込み
import { SyntaxError, parse } from "./parser/pokemon";
import { generate } from "escodegen";
import fs from "node:fs";

/** 引数のミスがある場合は終了する */
if (process.argv.length !== 3) {
  console.log("引数が正しくありません");
  console.log("入力ファイルが指定されているか確認してください");
  process.exit(1);
}

// パース結果の取得・出力
try {
  const pokemonLang = String(fs.readFileSync(process.argv[2]));
  const result = parse(pokemonLang);
  const resultJson = JSON.stringify(result, null, 2);
  const resultJS = generate(result);
  fs.writeFileSync("output.txt", resultJson);
  fs.writeFileSync("output.js", resultJS);
} catch (error) {
  if (error instanceof SyntaxError) {
    console.error("PEG_ERROR");
  } else {
    console.error("another error");
  }
  console.log(error);
}
