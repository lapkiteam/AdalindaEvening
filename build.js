// @ts-check
import { get } from "https"
import { existsSync, mkdirSync, createWriteStream, unlink, rmSync } from "fs"
import { basename, join } from "path"
import AdmZip from "adm-zip"

/**
 * @param {string} url
 * @param {string} outputPath
 * @return {Promise<void>}
 */
function download(url, outputPath) {
  return new Promise((resolve, reject) => {
    const outputDir = basename(outputPath)
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

function unZip(zipFilePath, outputDir) {
  const zip = new AdmZip(zipFilePath)
  zip.extractAllTo(outputDir, true)
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
    .catch(errorMessage => {
      console.error(`download error: ${errorMessage}`)
    })
}

installIsteadCli()
