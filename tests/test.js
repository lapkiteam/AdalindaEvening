// @ts-check
import { EOL } from "node:os"
import { diffChars } from "diff"
import { fileSync } from "tmp"
import "colors"
import { writeFileSync } from "node:fs"

import * as insteadCli from "./instead-cli.js"

/**
 * @param {string} expected
 * @param {string} actual
 * @return {{ case: "Ok" } | { case: "Error", data: string }}
 */
function equal(expected, actual) {
  if (expected !== actual) {
    const diff = diffChars(expected, actual)
    const result = diff.map((part) => {
      return part.added ? (
        part.value.green
      ) : (
        part.removed ? (
          part.value.red
        ) : (
          part.value.grey
        )
      )
    }).join("")
    return { case: "Error", data: result }
  }
  return { case: "Ok" }
}

/**
 * @param {string} gameFolder
 * @param {string[]} commands
 * @param {string} expected
 */
async function runTest(gameFolder, commands, expected) {
  const commandsFile = fileSync()
  writeFileSync(commandsFile.name, commands.join("\n"))
  let result
  try {
    result = await insteadCli.run(commandsFile.name, gameFolder)
  } catch(e) {
    throw new Error(JSON.stringify(e))
  }
  console.log(result.rawCommand)
  const equalResult = equal(expected, result.stdout)
  if (equalResult.case === "Error") {
    throw new Error(equalResult.data)
  }
  console.log("Test success!")
}

runTest(
  "src",
  [
    "/act 2",
    "/act 1",
  ],
  [
    "Включенный телевизор(1) стоит на тумбе. Любимый диванчик(2) стоит ",
    "возле стены.",
    "",
    "> /Отодвигаю диван от стены./",
    "/act 2",
    "",
    "    Включенный телевизор(1) стоит на тумбе. Любимый диванчик(2) ",
    "отодвинут от стены. Место для салата(3).",
    "",
    "> ",
    "",
  ].join(EOL)
)
