# 《刘文俊 · 个人简历》部署项目

基于 Claude Design 风格重构的 HTML 简历，数据与展示分离，纯静态站点，**完全离线可用**（字体、数据全部本地化，无需外网、无需构建步骤）。

## 目录结构说明

* `index.html` —— 简历主页面（即站点首页），JSON 数据驱动渲染，内置打印/导出 PDF 样式。
* `data/resume.json` —— **⭐ 核心配置文件**。所有简历文字、工作经历、技能、项目内容皆在此处，修改后刷新页面即可生效。
* `css/tokens.css` —— 排版/设计系统的底层 CSS 变量（配色、字号、间距、动效 token）。
* `fonts/` —— 拉丁字体离线 woff2/ttf 文件（`Newsreader`、`Inter`、`IBM Plex Mono`、`Source Serif 4` 等）+ 字体声明 `fonts.css`。
* `assets/` —— Ensō 圆环 SVG（logo/favicon/og:image 共用）。
* `design-system/` —— **设计系统参考文档**（配色、字体选型、组件原型、字体实验室），作为后续迭代的规范依据。**不对外发布**，仅供自己查阅，`index.html` 未链接到这里。
* `archive/` —— `resume.json.bak`：简历文字的另一份历史草稿，留作对照，不参与部署。
* `start.bat` —— Windows 一键启动本地预览服务脚本（`python` 优先，缺失时自动回退到 `py -3`）。

## 快速启动（本地预览）
1. 双击运行 `start.bat`。
2. 脚本会：
   - 优先用 `python -m http.server 3000` 启动本地服务；
   - 找不到 `python` 时自动尝试 `py -3`；
   - 两者都缺时会提示你去 [python.org](https://www.python.org/downloads/) 安装。
3. 用默认浏览器打开 [http://localhost:3000](http://localhost:3000)。

> ⚠️ 不要直接双击 `index.html`——`file://` 协议下浏览器会拒绝 `fetch('data/resume.json')`，页面会显示占位文本。必须通过 HTTP 服务器访问。

## 如何修改简历内容
用任意文本编辑器（VS Code、Sublime Text、记事本均可）打开 `data/resume.json`，按对应字段修改文字，保存后刷新浏览器页面即可生效。无需重新构建。

## 如何调整视觉样式
所有颜色、字号、间距、动效变量集中在 `css/tokens.css`；页面专属样式在 `index.html` 内的 `<style>` 块中。改样式前建议先看一眼 `design-system/design-system.html`，里面记录了色板、字号阶梯、组件规范，避免改出不一致的视觉语言。

## 打印 / 导出 PDF
`index.html` 已内置 `@media print` 与 `@page A4` 规则：
- 隐藏顶部导航与水印名。
- 保留斜体强调色（赭石红），避免打印后失去视觉重点。
- 防止项目卡与经历段落跨页。
- 直接 `Ctrl + P` → 保存为 PDF 即可得到干净的 A4 简历。

## 依赖概览

| 类别 | 内容 | 是否需外网 |
|---|---|---|
| 字体（拉丁） | `fonts/*.woff2` 已内置 | ❌ 不需要 |
| 字体（中文） | Noto Serif SC / PingFang / 系统回退 | ❌ 不需要 |
| 数据 | `data/resume.json` | ❌ 不需要 |
| Google Fonts CDN | `tokens.css` 保留作为兜底 `@import` | ⚠️ 可选（用于变体字重更全时） |

站点是纯 HTML/CSS/JS，没有 React、没有构建步骤，也没有 npm 依赖。

## 部署
项目根目录里除 `design-system/` 和 `archive/` 之外的所有内容都可以直接发布：`index.html`、`css/`、`fonts/`、`assets/`、`data/`。

- **`design-system/` 与 `archive/` 不要打包上线**——它们是给你自己看的规范文档和历史草稿，不是面向访客的内容。
- **静态托管**：整个目录可直接扔到 Vercel / Netlify / GitHub Pages / Nginx，无需构建步骤，`index.html` 作为首页入口即可。
