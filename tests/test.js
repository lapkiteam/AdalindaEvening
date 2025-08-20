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
 * @param {string[]} commands
 */
function writeCommandsToFile(commands) {
  const fileResult = fileSync({ prefix: "instead-cli-js" })
  writeFileSync(fileResult.name, commands.join("\n"))
  return fileResult
}

/**
 * @param {string} gameFolder
 * @param {string[]} commands
 * @param {string} expected
 */
async function runTest(gameFolder, commands, expected) {
  const commandsFile = writeCommandsToFile(commands)
  let result
  try {
    result = await insteadCli.run(commandsFile.name, gameFolder)
  } catch(e) {
    throw new Error(JSON.stringify(e))
  }
  console.log(result.rawCommand)
  const actual = result.stdout
  const equalResult = equal(expected, actual)
  if (equalResult.case === "Error") {
    console.log(equalResult.data)
    throw new Error(JSON.stringify({ expected, actual }, undefined, 2))
  }
  console.log("Test success!")
}

runTest(
  "src",
  [
    "/way    ",
    "/go 3   ", // на кухню
    "/act 4  ", // открыть холодильник
    "/act 1  ", // взять палку колбасы
    "/act 1  ", // взять огурцы
    "/act 1  ", // взять яйца
    "/act 1  ", // взять майонез
    "/way    ",
    "/go 1   ", // назад
    "/inv    ",
    "/use 6 2", // колбасу — в тазик
    "/inv    ",
    "/use 6 2", // огурцы в тазик
    "/inv    ",
    "/use 6 2", // яйца в тазик
    "/inv    ",
    "/use 6 2", // майонез — в тазик
    "/act 5  ", // залезть — в шкафчик
    "/act 1  ", // взять банку с горошком
    "/act 1  ", // взять пакет с картошкой
    "/way    ",
    "/go 1   ", // назад
    "/inv    ",
    "/use 6 2", // горошек — в тазик
    "/inv    ",
    "/use 6 2", // картошку — в тазик
    "/act 2  ", // взять салатик
    "/way    ",
    "/go 5   ", // в холл
    "/act 2  ", // отодвинуть диванчик
    "/inv    ",
    "/use 4 3",
    "/act 2  ", // задвинуть диванчик
    "/act 2  ", // сесть на диванчик
  ],
  [
    "Включенный телевизор(1) стоит на тумбе. Любимый диванчик(2) стоит возле стены.",
    "",
    "> /way",
    "На кухню(3)",
    "",
    "> /go 3 -- на кухню",
    "Кухня",
    "",
    "    На столе(1) стоит тазик(2). Рецепт(3) весит на стене. Возле стенки примостился холодильник(4). Под раковиной расположен шкафчик(5).",
    "",
    "> /act 4 -- открыть холодильник",
    "/Заглядываю в холодильник./",
    "",
    "    В холодильнике",
    "",
    "    На первой полке вальяжно возлегает палка колбасы(1). На полу валяются огурцы(2). В лотке на верхней полке дверцы распиханы яйца(3). На нижней полке дверцы прижимается к стенке пачка майонеза(4).",
    "",
    "> /act 1 -- взять палку колбасы",
    "/Подбираю колбасу./",
    "",
    "    На полу валяются огурцы(1). В лотке на верхней полке дверцы распиханы яйца(2). На нижней полке дверцы прижимается к стенке пачка майонеза(3).",
    "",
    "> /act 1 -- взять огурцы",
    "/Вооружаюсь боевыми огурцами./",
    "",
    "    В лотке на верхней полке дверцы распиханы яйца(1). На нижней полке дверцы прижимается к стенке пачка майонеза(2).",
    "",
    "> /act 1 -- взять яйца",
    "/Беру яйца в руки./",
    "",
    "    На нижней полке дверцы прижимается к стенке пачка майонеза(1).",
    "",
    "> /act 1 -- взять майонез",
    "/Хватаю пачку майонеза./",
    "",
    "    Внутри повесилась мышь.",
    "",
    "> /way",
    "Назад(1)",
    "",
    "> /go 1 -- назад",
    "Кухня",
    "",
    "    На столе(1) стоит тазик(2). Рецепт(3) весит на стене. Возле стенки примостился холодильник(4). Под раковиной расположен шкафчик(5).",
    "",
    "> /inv",
    "Колбаса(6)|Огурцы(7)|Яйца(8)|Майонез(9)",
    "",
    "> -- /use 6 2 -- вкинуть колбасу в тазик",
    "",
    ">> В холл(10)",
    "** Колбаса(6)|Огурцы(7)|Яйца(8)|Майонез(9)",
    "",
    "> ",
    "",
  ].join(EOL)
)
