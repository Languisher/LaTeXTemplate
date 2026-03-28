#import "elegantnote.typ": elegant-note, theorem, definition, example, remark, note, proof, keywords

#show: elegant-note.with(
  lang: "zh",
  mode: "hazy",
  theme: "blue",
  device: "screen",
  title: [ElegantNote：一个优雅的 Typst 笔记模板],
  author: [林楠],
  institute: [上海交通大学],
  date: [2026-03-28],
  logo: "image/sjtu-logo.png",
)

= ElegantNote 模版使用提醒

这个版本不再依赖 LaTeX 类文件，而是把样式集中在 [`elegantnote.typ`](./elegantnote.typ) 中，
正文只保留结构化内容。你可以把它理解成 Typst 里更自然的一种“类文件 + 内容文件”写法。

== 可定制项

- `theme` 控制主题色，目前内置 `blue`、`green`、`cyan`、`sakura`、`black`、`brown`。
- `mode` 控制纸张底色，目前内置 `hazy`、`geye`、`sepia`、`white`。
- `device` 可以切换成 `screen`、`pad`、`pc`、`kindle` 或普通纸张模式。
- 封面信息集中在 `title`、`author`、`institute`、`version`、`date`、`logo` 这些参数里。

== 定理类环境

这个 Typst 模版复刻了 LaTeX 版里“定理 / 定义 / 评论”这类笔记块的使用感，但实现方式更直接。

#definition[
  所有定理类环境都被写成普通函数，因此你不需要记忆环境起止标记，只要直接调用即可。
]

#theorem(title: [可复用性])[
  如果样式被封装成一个独立的模板函数，那么正文就可以专注表达内容，而不是反复处理排版细节。
]

#example[
  你可以继续补充 `lemma`、`proposition`、`conjecture`、`case` 等块，它们与这里的写法一致。
]

#remark[
  与 LaTeX 原版一样，`remark` 和 `note` 默认不编号，更适合写阅读提醒和补充说明。
]

#note[
  如果你希望继续向“讲义”或“课程笔记”方向扩展，这套 Typst 结构会比宏包式定制更容易维护。
]

#proof[
  这里保留了一个简洁的证明环境，末尾会自动放一个结束符号。
]

== 链接与图像

如何使用链接：特别感谢 https://github.com/sikouhjw 和 https://github.com/syvshc

#keywords[Typst，模板，笔记排版，中文文档]
