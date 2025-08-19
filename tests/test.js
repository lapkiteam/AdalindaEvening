// @ts-check
import { exec } from "node:child_process"
import { dirname, join, resolve } from "node:path"
import { platform, EOL } from "node:os"
import { diffChars } from "diff"
import { fileURLToPath } from "url"
import { fileSync } from "tmp"
import "colors"
import { writeFileSync } from "node:fs"

const __dirname = dirname(fileURLToPath(import.meta.url))

/**
 * @param {string} command
 * @param {string[]} args
 * @return {Promise<{ rawCommand: string, stdout: string, stderr: string }>}
 */
function runCommand(command, args = []) {
  return new Promise((resolve, reject) => {
    const rawCommand = `${command} ${args.join(" ")}`
    exec(
      rawCommand,
      (error, stdout, stderr) => {
        if (error) {
          reject({ error, rawCommand, stdout, stderr })
          return
        }
        resolve({ rawCommand, stdout, stderr })
      }
    )
  })
}

const insteadCliPath = (() => {
  const fileName = platform() === "win32" ? "instead-cli.exe" : "instead-cli"
  return resolve(
    join(__dirname, `../node_modules/instead-cli-v1.7-a0f1e04/${fileName}`)
  )
})()

/**
 * @param {string} commandsFilePath
 * @param {string} gameFolderPath
 */
function insteadCliRun(commandsFilePath, gameFolderPath) {
  return runCommand(
    insteadCliPath,
    ["-cp65001", `-i${commandsFilePath}`, "-e", "-d", gameFolderPath]
  )
}

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
    result = await insteadCliRun(commandsFile.name, gameFolder)
  } catch(e) {
    throw new Error(e)
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
