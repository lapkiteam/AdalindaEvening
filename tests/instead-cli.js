// @ts-check
import { exec } from "node:child_process"
import { dirname, join, resolve } from "node:path"
import { platform } from "node:os"
import { fileURLToPath } from "url"

export const __dirname = dirname(fileURLToPath(import.meta.url))

/**
 * @param {string} command
 * @param {string[]} args
 * @return {Promise<{ rawCommand: string, stdout: string, stderr: string }>}
 */
export function runCommand(command, args = []) {
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

export const path = (() => {
  const fileName = platform() === "win32" ? "instead-cli.exe" : "instead-cli"
  return resolve(
    join(__dirname, `../node_modules/instead-cli-v1.7-a0f1e04/${fileName}`)
  )
})()

/**
 * @param {string} commandsFilePath
 * @param {string} gameFolderPath
 */
export function run(commandsFilePath, gameFolderPath) {
  return runCommand(
    path,
    [
      platform() === "win32" ? "-cp65001" : "",
      `-i${commandsFilePath}`,
      "-e",
      "-d",
      gameFolderPath,
    ]
  )
}
