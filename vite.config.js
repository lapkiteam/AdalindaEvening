import { viteStaticCopy } from "vite-plugin-static-copy"

/** @type {import('vite').UserConfig} */
export default {
  plugins: [
    viteStaticCopy({
      targets: [
        {
          src: "src/**/*",
          dest: "games/adalinda-evening"
        }
      ],
      watch: {
        reloadPageOnChange: true
      },
    })
  ]
}
