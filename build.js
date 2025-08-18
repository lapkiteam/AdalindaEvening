// @ts-check
import { get } from "https"
import { existsSync, mkdirSync, createWriteStream, unlink, rmSync } from "fs"
import { basename, join } from "path"
import AdmZip from "adm-zip"

/** @typedef {{ case: "Ok" } | { case: "Error", data: string } } DownloadResult */

/**
 * @param {string} url
 * @param {string} outputPath
 * @param {((success: DownloadResult) => void)} cb
 */
function download(url, outputPath, cb) {
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
            cb({ case: "Ok" })
          })
        }).on("error", (err) => {
          unlink(outputPath, () => {
            cb({
              case: "Error",
              data: err.message,
            })
          })
        })
      } else if (response.statusCode === 302) {
        const redirectUrl = response.headers.location
        if (!redirectUrl) { return }
        loop(redirectUrl)
      } else {
        cb({
          case: "Error",
          data: `Ошибка загрузки: ${response.statusCode}`,
        })
      }
    }).on("error", (err) => {
      cb({
        case: "Error",
        data: err.message,
      })
    })
  }
  loop(url)
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
  download(url, zipFilePath, downloadResult => {
    if (downloadResult.case === "Error") {
      console.error(`download error: ${downloadResult.data}`)
      return
    }
    console.log(`Архив ${url} скачан в ${zipFilePath}`)
    unZip(zipFilePath, outputDir)
    console.log(`Архив распакован в ${outputDir}`)
    rmSync(zipFilePath)
    console.log(`Файл ${zipFilePath} удален`)
  })
}

installIsteadCli()
