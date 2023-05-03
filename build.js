"use strict";

const { build } = require("esbuild");

/** 共通で使うオプション */
const options = {
  entryPoints: ["./src/main.ts"],
  outbase: "./src",
  outdir: "./dist",
  bundle: true,
  platform: "node",
  tsconfig: "tsconfig.json",
}

/** 環境変数でwatch modeにする */
if (process.env.WATCH === "true") {
  options.watch = {
    onRebuild(error, result) {
      if (error) {
        console.error("watch build failed:", error);
      } else {
        console.log("watch build succeeded:", result);
      }
    },
  };
}

/** 通常通りのbuild */
build(options).catch((error) => {
  console.log(error);
})
