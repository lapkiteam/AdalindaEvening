// @ts-check
import { get } from "https"
import { existsSync, mkdirSync, createWriteStream, unlink, rmSync, writeFileSync, chmodSync } from "fs"
import { dirname, join, resolve } from "path"
import AdmZip from "adm-zip"

/**
 * @param {string} url
 * @param {string} outputPath
 * @return {Promise<void>}
 */
function download(url, outputPath) {
  return new Promise((resolve, reject) => {
    const outputDir = dirname(outputPath)
    if (!existsSync(outputDir)) {
      mkdirSync(outputDir, { recursive: true })
    }
    function loop(/** @type {string} url */ url) {
      get(url, (response) => {
        if (response.statusCode === 200) {
          const file = createWriteStream(outputPath)
          response.pipe(file)

          file.on("finish", () => {
            file.close(() => {
              resolve()
            })
          }).on("error", (err) => {
            unlink(outputPath, () => {
              reject(err.message)
            })
          })
        } else if (response.statusCode === 302) {
          const redirectUrl = response.headers.location
          if (!redirectUrl) { return }
          loop(redirectUrl)
        } else {
          reject(`Ошибка загрузки: ${response.statusCode}`)
        }
      }).on("error", (err) => {
        reject(err.message)
      })
    }
    loop(url)
  })
}

/**
 * @param {string | Buffer} zipFilePath
 * @param {string} outputDir
 */
function unZip(zipFilePath, outputDir) {
  const zip = new AdmZip(zipFilePath)
  zip.extractAllTo(outputDir, true)
}

function addStartupScripts() {
  const binPath = "node_modules/.bin"
  const bashScript = `#!/bin/sh
basedir=$(dirname "$(echo "$0" | sed -e 's,\\,/,g')")

case \`uname\` in
    *CYGWIN*|*MINGW*|*MSYS*)
        if command -v cygpath > /dev/null 2>&1; then
            basedir=\`cygpath -w "$basedir"\`
        fi
    ;;
esac

exec "$basedir/../instead-cli-v1.7-a0f1e04/instead-cli" "$@"
`
  writeFileSync(join(binPath, "instead-cli"), bashScript)

  const cmdScript = `@ECHO off
GOTO start
:find_dp0
SET dp0=%~dp0
EXIT /b
:start
SETLOCAL
CALL :find_dp0

endLocal & "%dp0%\\..\\instead-cli-v1.7-a0f1e04\\instead-cli.exe" %*
`
  writeFileSync(join(binPath, "instead-cli.cmd"), cmdScript)
}

function installIsteadCli() {
  const url = "https://github.com/gretmn102/instead-cli/releases/download/v1.7-a0f1e04/instead-cli-v1.7-a0f1e04.zip"
  const outputDir = "node_modules"
  const zipFileName = "release.zip"
  const zipFilePath = join(outputDir, zipFileName)
  download(url, zipFilePath)
    .then(() => {
      console.log(`Архив ${url} скачан в ${zipFilePath}`)
      unZip(zipFilePath, outputDir)
      console.log(`Архив распакован в ${outputDir}`)
      rmSync(zipFilePath)
      console.log(`Файл ${zipFilePath} удален`)
    })
    .then(() => {
      addStartupScripts()
      console.log("Startup scripts are written in the `node_modules/.bin` folder.")
    })
    .catch(errorMessage => {
      console.error(`download error: ${errorMessage}`)
    })
}

installIsteadCli()

chmodSync("node_modules/instead-cli-v1.7-a0f1e04/instead-cli", "001")
