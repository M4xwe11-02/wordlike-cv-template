# Word-Like Resume Template

A bilingual XeLaTeX resume template designed around a Word-like editing model:
write your resume by semantic blocks, then tune typography and spacing from one
central style file.

Traditional LaTeX resume templates often mix content with layout details:
section-specific `itemize` options, local font commands, and scattered
`\vspace` tweaks. This project keeps the content files clean and makes the
layout system explicit.

## Highlights

- **Word-like hierarchy**: level 1 sections, level 2 headings, level 3 headings,
  body paragraphs, and bullet lists.
- **Centralized style control**: fonts, font sizes, section spacing, body
  spacing, and bullet spacing live in `style/resume-style.tex`.
- **Bilingual examples**: Chinese and English examples share the same style
  system.
- **Modular content**: add, remove, or reorder resume modules with `\input`.
- **No personal assets**: no real photos, logos, schools, companies, or links
  are included.
- **No bundled fonts**: defaults use TeX Live font files to keep the repository
  lightweight.

## Preview

Build the examples locally:

```bash
make zh
make en
```

The generated files are:

```text
resume-zh.pdf
resume-en.pdf
```

PDF files are intentionally ignored by Git so the repository stays source-only.

## Requirements

- TeX Live or MacTeX
- XeLaTeX
- GNU Make

The default fonts are loaded from a standard TeX Live installation:

- Latin: `lmroman10-regular.otf`
- Chinese: `FandolSong-Regular.otf`

## Quick Start

Clone the project and build both examples:

```bash
make
```

Build only the Chinese example:

```bash
make zh
```

Build only the English example:

```bash
make en
```

Remove generated files:

```bash
make clean
```

## Project Structure

```text
wordlike-resume-template/
  resume-zh.tex              # Chinese entrypoint
  resume-en.tex              # English entrypoint
  style/
    resume-style.tex         # Central style system and semantic commands
  content/
    zh/                      # Chinese example modules
    en/                      # English example modules
  assets/
    .gitkeep                 # Put logo.png and avatar.jpg here if needed
  Makefile
  README.md
  LICENSE
```

## Editing Model

The main entry files only decide module order:

```tex
\input{content/zh/heading}
\input{content/zh/education}
\input{content/zh/experience}
\input{content/zh/projects}
\input{content/zh/skills}
```

Content modules should describe structure, not layout. For example:

```tex
\resumeSpacedSection{Projects}

\resumeHeadingThree{\textbf{Example Collaboration Platform} \resumeSep \href{https://example.com}{\uline{Demo}}}{}
\resumeInlineLabel{Overview}{A web application for team collaboration, task tracking, and role-based access control.}
\begin{resumeBulletList}
  \resumeBullet{Separated user, task, notification, and audit modules with a layered architecture.}
  \resumeBullet{Used caching and asynchronous messaging to optimize high-frequency paths.}
\end{resumeBulletList}
```

Avoid local layout commands in content files:

- Avoid scattered `\vspace`.
- Avoid one-off `itemize` options.
- Avoid local font-size fixes unless the content itself needs emphasis.

If a layout decision should affect the whole resume, change
`style/resume-style.tex`.

## Semantic API

Use these commands in content files:

| Command | Purpose |
| --- | --- |
| `\resumeSection{title}` | Level 1 section title with rule |
| `\resumeSpacedSection{title}` | Level 1 section title with extra top spacing |
| `\resumeHeadingTwo{left}{right}` | Level 2 heading, typically school/company |
| `\resumeHeadingThree{left}{right}` | Level 3 heading, typically project/role |
| `\resumeBodyText{text}` | Body paragraph |
| `\resumeInlineLabel{label}{text}` | English label + body paragraph |
| `\resumeInlineLabelZh{标签}{正文}` | Chinese label + body paragraph |
| `resumeBulletList` | Standard bullet list environment |
| `\resumeBullet{text}` | Bullet item |

Recommended hierarchy:

```text
Level 1  Section       Education / Experience / Projects / Skills
Level 2  Heading       University / Company / Major experience group
Level 3  Heading       Project / Paper / Award / Role detail
Body     Paragraph     Overview, context, summary
Body     Bullet list   Contributions, results, responsibilities
```

## Add Your Own Modules

You can freely add, remove, or reorder modules.

Create a new Chinese module:

```text
content/zh/publications.tex
```

Add it to `resume-zh.tex`:

```tex
\input{content/zh/publications}
```

Example Chinese module:

```tex
\resumeSpacedSection{论文与开源}

\resumeHeadingThree{\textbf{Example Paper Title} \resumeSep \href{https://example.com}{\uline{Link}}}{}
\resumeInlineLabelZh{简介}{这里写正文。自动换行使用正文行距，模块间距由样式层控制。}
\begin{resumeBulletList}
  \resumeBullet{这里写第一条贡献。}
  \resumeBullet{这里写第二条贡献。}
\end{resumeBulletList}
```

Create a new English module:

```text
content/en/publications.tex
```

Add it to `resume-en.tex`:

```tex
\input{content/en/publications}
```

Example English module:

```tex
\resumeSpacedSection{Publications}

\resumeHeadingThree{\textbf{Example Paper Title} \resumeSep \href{https://example.com}{\uline{Link}}}{}
\resumeInlineLabel{Summary}{Write a short body paragraph here. Automatic wrapping uses body line spacing.}
\begin{resumeBulletList}
  \resumeBullet{Describe the first contribution.}
  \resumeBullet{Describe the second contribution.}
\end{resumeBulletList}
```

Useful optional modules:

- Publications
- Awards
- Open Source
- Certifications
- Research
- Teaching
- Leadership
- Volunteer Experience

To remove a module, delete or comment out its `\input{...}` line.

## Style Customization

Edit `style/resume-style.tex` to tune the whole resume:

```tex
\setlength{\resumeSectionAfter}{2.5pt}
\setlength{\resumeSectionBefore}{4pt}
\setlength{\resumeHeadingTwoAfter}{1.5pt}
\setlength{\resumeHeadingThreeAfter}{1.5pt}
\setlength{\resumeBodyAfter}{1.5pt}
\setlength{\resumeBulletAfter}{1.2pt}

\newcommand{\resumeSectionFont}{\large}
\newcommand{\resumeHeadingTwoFont}{\fontsize{11.5pt}{13.5pt}\selectfont}
\newcommand{\resumeHeadingThreeFont}{\normalsize}
\newcommand{\resumeBodyFont}{\small}
```

Spacing model:

- Automatic line wrapping uses the font's line height.
- Manual paragraph/module separation is controlled by the relevant `After`
  length.
- Bullet spacing is controlled by `\resumeBulletAfter`.

This mirrors a Word-style workflow: change the style once, and all matching
content updates together.

## Header Images

The template does not include personal images.

By default, the header renders gray placeholders. To use real images, add:

```text
assets/logo.png
assets/avatar.jpg
```

Then rebuild the PDF:

```bash
make zh
```

If the image files are missing, placeholders remain visible.

## Fonts

No font files are bundled.

Default font configuration:

```tex
\setmainfont[
  BoldFont = lmroman10-bold.otf,
  ItalicFont = lmroman10-italic.otf,
  BoldItalicFont = lmroman10-bolditalic.otf
]{lmroman10-regular.otf}

\setCJKmainfont[
  BoldFont = FandolSong-Bold.otf,
  ItalicFont = FandolKai-Regular.otf
]{FandolSong-Regular.otf}
```

To use system fonts, edit the font block in `style/resume-style.tex`:

```tex
\setmainfont{Times New Roman}
\setCJKmainfont[
  BoldFont = Source Han Serif SC Bold
]{Source Han Serif SC}
```

## 中文说明

这是一个中英双语 XeLaTeX 简历模板，核心是把 LaTeX 简历写成类似 Word
样式系统：

- 内容文件只写一级标题、二级标题、三级标题、正文和列表。
- 字号、字体、段后距、列表间距集中在 `style/resume-style.tex`。
- 新增模块只需要新建 `content/zh/*.tex` 或 `content/en/*.tex`，再在入口文件
  中添加 `\input{...}`。
- 默认不包含个人照片、校徽、真实学校、真实公司或真实项目。

构建中文示例：

```bash
make zh
```

构建英文示例：

```bash
make en
```

## Privacy and Open Source Safety

Before publishing your own fork, check:

- No real phone number, email, address, school ID, or personal identifier.
- No real photo or logo unless you have the right to publish it.
- No private project links, internal company names, or confidential metrics.
- Generated PDFs are not committed unless you intentionally want to publish
  them.

## Contributing

Contributions are welcome.

Please keep the project focused on a clean, Word-like semantic resume editing model.

Guidelines:

- Keep examples generic and reusable.
- Do not add personal resumes, real photos, or real organization logos.
- Put layout, typography, and spacing changes in `style/resume-style.tex`.
- Keep content modules semantic and easy to edit.
- Run `make zh` and `make en` before opening a pull request.

## License

MIT. See [LICENSE](LICENSE).
