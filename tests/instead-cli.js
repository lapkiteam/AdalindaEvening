// @ts-check
import { exec, spawn } from "node:child_process"
import { dirname, join, resolve } from "node:path"
import { platform } from "node:os"
import { fileURLToPath } from "url"
import internal from "node:stream"
import { MutableMail } from "./mail"
import { UnionCase } from "@fering-org/functional-helper"

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

/**
 * @param {string} command
 * @param {string[]} args
 * @param {internal.Writable} stdin
 * @param {(src: internal.Readable) => void} stdout
 * @param {(src: internal.Readable) => void} stderr
 * @return {Promise<{ rawCommand: string, stdout: string, stderr: string }>}
 */
export function runCommandPipe(command, args = [], stdin, stdout, stderr) {
  return new Promise((resolve, reject) => {
    // const rawCommand = `${command} ${args.join(" ")}`
    const process = spawn(command, args, { stdio: "pipe" })
    stdin = process.stdin
    process.stdout.on("pipe", stdout)
    process.stderr.on("pipe", stderr)
    process.once("error", x => {})
    process.once("close", x => {})
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
      "-w2048",
      gameFolderPath,
    ]
  )
}


/**
 * @typedef {UnionCase<"stdout", internal.Readable>} PipeData
 */

/**
 * @param {string} gameFolderPath
 */
export function runPipe(gameFolderPath) {
  const command = path
  const args = [
    platform() === "win32" ? "-cp65001" : "",
    "-e",
    "-d",
    "-w2048",
    gameFolderPath,
  ]


  // /** @type {internal.Writable} */
  // let stdin
  // /** @type {(src: internal.Readable) => void} */
  // let stdoutHandler
  // /** @type {(src: internal.Readable) => void} */
  // let stderrHandler
  // let errorHandler
  // let closeHandler

  /** @type {MutableMail<PipeData>} */
  const mail = MutableMail()

  const process = spawn(command, args, { stdio: "pipe" })
  stdin = process.stdin
  process.stdout.on("pipe", out => {
    mail.push({ case: "stdout", fields: out })
  })
  process.stderr.on("pipe", out => {
    mail.push({ case: "stderr", fields: out })
  })
  process.once("error", err => {
    mail.push({ case: "error", fields: err })
  })
  process.once("close", (code, signal) => {
    mail.push({ case: "close", fields: { code, signal } })
  })

  return {
    subscribeOnce(callback) {
      mail.subscribeOnce(callback)
    }
  }
}
