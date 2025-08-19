// @ts-check
import { spawn } from "node:child_process"
import { dirname, join, resolve } from "node:path"
import { platform, EOL } from "node:os"
import { diffChars } from "diff"
import { fileURLToPath } from "url"
import "colors"

const __dirname = dirname(fileURLToPath(import.meta.url))

/**
 * @param {string} command
 * @param {string[]} args
 * @return {Promise<{ code: number, signal: NodeJS.Signals | null, output: string }>}
 */
function runCommand(command, args = []) {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, { stdio: "pipe", shell: true })

    let output = ""
    child.stdout.on("data", (chunk) => {
      output += chunk
    })

    child.stderr.on("data", (chunk) => {
      output += chunk
    })

    child.on("error", (err) => {
      reject(err)
    })

    child.on("close", (code, signal) => {
      if (code === 0) {
        resolve({ code, signal, output })
      } else {
        const err = new Error(
          `Process ${command} exited with code ${code}${signal ? `, signal ${signal}` : ""}`
        )
        // @ts-expect-error 123
        err.code = code
        // @ts-expect-error 123
        err.signal = signal
        reject({err, output})
      }
    })
  })
}

const insteadCliPath = (() => {
  const fileName = platform() === "win32" ? "instead-cli.exe" : "instead-cli"
  return resolve(
    join(__dirname, `../node_modules/instead-cli-v1.7-a0f1e04/${fileName}`)
  )
})()

/**
 * @param {string} gameFolder
 * @param {string} commandsPath
 * @param {string} expected
 */
async function runTest(gameFolder, commandsPath, expected) {
  let result
  try {
    result = await runCommand(
      insteadCliPath,
      ["-cp65001", `-i${commandsPath}`, "-e", "-d", gameFolder]
    )
  } catch(e) {
    throw new Error(e.output)
  }

  if (expected !== result.output) {
    const diff = diffChars(expected, result.output)
    diff.forEach((part) => {
      // green for additions, red for deletions
      let text = part.added ? part.value.green :
                 part.removed ? part.value.red :
                                part.value.grey
      process.stderr.write(text)
    })
    throw new Error("Not equal")
  }
  console.log("Test success!")
}

runTest(
  "src",
  "J:\\AdalindaEvening\\tests\\instead-cli-script",
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
