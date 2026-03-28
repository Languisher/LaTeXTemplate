#let _theme_state = state("elegantnote-theme", "blue")
#let _lang_state = state("elegantnote-lang", "zh")

#let _accent(theme) = if theme == "green" {
  rgb(12, 122, 67)
} else if theme == "cyan" {
  rgb(31, 186, 190)
} else if theme == "sakura" {
  rgb(214, 104, 142)
} else if theme == "black" {
  rgb(36, 36, 36)
} else if theme == "brown" {
  rgb(109, 62, 18)
} else {
  rgb(1, 126, 218)
}

#let _panel-fill(theme) = if theme == "green" {
  rgb(238, 247, 242)
} else if theme == "cyan" {
  rgb(235, 249, 250)
} else if theme == "sakura" {
  rgb(255, 243, 246)
} else if theme == "black" {
  rgb(245, 245, 245)
} else if theme == "brown" {
  rgb(247, 241, 235)
} else {
  rgb(240, 247, 255)
}

#let _page-fill(mode) = if mode == "geye" {
  rgb(199, 237, 204)
} else if mode == "sepia" {
  rgb(250, 237, 225)
} else if mode == "white" {
  white
} else {
  rgb(251, 250, 248)
}

#let _ink(mode) = if mode == "black" {
  white
} else {
  rgb(48, 52, 57)
}

#let _label(kind, lang) = if lang == "en" {
  if kind == "theorem" {
    [Theorem]
  } else if kind == "lemma" {
    [Lemma]
  } else if kind == "proposition" {
    [Proposition]
  } else if kind == "corollary" {
    [Corollary]
  } else if kind == "definition" {
    [Definition]
  } else if kind == "conjecture" {
    [Conjecture]
  } else if kind == "example" {
    [Example]
  } else if kind == "remark" {
    [Remark]
  } else if kind == "note" {
    [Note]
  } else if kind == "case" {
    [Case]
  } else if kind == "proof" {
    [Proof]
  } else if kind == "keywords" {
    [Keywords:]
  } else if kind == "version" {
    [Version:]
  } else {
    [Updated:]
  }
} else {
  if kind == "theorem" {
    [定理]
  } else if kind == "lemma" {
    [引理]
  } else if kind == "proposition" {
    [命题]
  } else if kind == "corollary" {
    [推论]
  } else if kind == "definition" {
    [定义]
  } else if kind == "conjecture" {
    [猜想]
  } else if kind == "example" {
    [例]
  } else if kind == "remark" {
    [评论]
  } else if kind == "note" {
    [注]
  } else if kind == "case" {
    [案例]
  } else if kind == "proof" {
    [证明]
  } else if kind == "keywords" {
    [关键词：]
  } else if kind == "version" {
    [版本：]
  } else {
    [更新：]
  }
}

#let _section-number() = {
  let current = counter(heading.where(level: 1)).get()
  if current.len() == 0 {
    0
  } else {
    current.at(0)
  }
}

#let _panel-title(kind, name, title: none) = context {
  let lang = _lang_state.get()
  let counter_key = counter("elegantnote-" + kind)
  let section = _section-number()
  let current = counter_key.get()
  let current_section = if current.len() > 0 { current.at(0) } else { -1 }
  let current_index = if current.len() > 1 { current.at(1) } else { 0 }
  let next_index = if current_section == section { current_index + 1 } else { 1 }

  [
    #counter_key.update((section, next_index))
    #name #context counter_key.display("1.1")
    #if title != none [
      #text(fill: rgb(110, 118, 129))[（#title）]
    ]
  ]
}

#let _panel(
  body,
  kind,
  title: none,
  numbered: true,
) = context {
  let theme = _theme_state.get()
  let accent = _accent(theme)
  let soft = _panel-fill(theme)
  let lang = _lang_state.get()
  let name = _label(kind, lang)

  block(
    width: 100%,
    inset: 12pt,
    outset: 0pt,
    radius: 10pt,
    fill: soft,
    stroke: (paint: accent, thickness: 0.9pt),
    above: 0.9em,
    below: 0.9em,
  )[
    #set text(fill: rgb(48, 52, 57))
    #text(size: 11.5pt, weight: "semibold", fill: accent)[
      #if numbered {
        _panel-title(kind, name, title: title)
      } else {
        [
          #name
          #if title != none [
            #h(0.35em)
            #text(fill: rgb(110, 118, 129))[（#title）]
          ]
        ]
      }
    ]
    #v(0.45em)
    #body
  ]
}

#let theorem(body, title: none) = _panel(body, "theorem", title: title)
#let lemma(body, title: none) = _panel(body, "lemma", title: title)
#let proposition(body, title: none) = _panel(body, "proposition", title: title)
#let definition(body, title: none) = _panel(body, "definition", title: title)
#let conjecture(body, title: none) = _panel(body, "conjecture", title: title)
#let example(body, title: none) = _panel(body, "example", title: title)
#let case(body, title: none) = _panel(body, "case", title: title)
#let corollary(body, title: none) = _panel(body, "corollary", title: title, numbered: false)
#let remark(body, title: none) = _panel(body, "remark", title: title, numbered: false)
#let note(body, title: none) = _panel(body, "note", title: title, numbered: false)

#let proof(body, title: none) = context {
  let theme = _theme_state.get()
  let accent = _accent(theme)
  let lang = _lang_state.get()

  block(above: 0.9em, below: 0.9em)[
    #text(weight: "semibold", fill: accent)[
      #_label("proof", lang)
      #if title != none [
        #h(0.35em)
        #text(fill: rgb(110, 118, 129))[（#title）]
      ]
    ]
    #v(0.35em)
    #body
    #v(0.35em)
    #align(right)[#square(size: 8pt, fill: accent)]
  ]
}

#let keywords(body) = context {
  let theme = _theme_state.get()
  let accent = _accent(theme)
  let lang = _lang_state.get()

  pad(top: 0.8em)[
    #text(weight: "semibold", fill: accent)[#_label("keywords", lang)]
    #h(0.35em)
    #body
  ]
}

#let _title-row(label, value) = if value == none {
  []
} else {
  [
    #value
  ]
}

#let elegant-note(
  body,
  title: none,
  author: none,
  institute: none,
  version: none,
  date: none,
  theme: "blue",
  mode: "hazy",
  lang: "zh",
  device: "screen",
  logo: none,
  paper: "a4",
  text-size: 11pt,
) = {
  let accent = _accent(theme)
  let page_fill = _page-fill(mode)
  let ink = _ink(mode)

  _theme_state.update(theme)
  _lang_state.update(lang)

  if device == "screen" {
    set page(
      width: 25.4cm,
      height: 19.05cm,
      margin: (x: 1.6cm, y: 1.6cm),
      fill: page_fill,
      numbering: "1",
      number-align: center + bottom,
    )
  } else if device == "pad" {
    set page(
      width: 6in,
      height: 8in,
      margin: 8mm,
      fill: page_fill,
      numbering: "1",
      number-align: center + bottom,
    )
  } else if device == "pc" {
    set page(
      width: 6.2in,
      height: 6in,
      margin: 8mm,
      fill: page_fill,
      numbering: "1",
      number-align: center + bottom,
    )
  } else if device == "kindle" {
    set page(
      width: 3.68in,
      height: 4.92in,
      margin: 8mm,
      fill: page_fill,
      numbering: "1",
      number-align: center + bottom,
    )
  } else {
    set page(
      paper: paper,
      margin: (x: 2.2cm, y: 2.4cm),
      fill: page_fill,
      numbering: "1",
      number-align: center + bottom,
    )
  }

  set text(
    font: (
      "Libertinus Serif",
      "New Computer Modern",
      "Songti SC"
    ),
    size: text-size,
    fill: ink,
  )
  set par(justify: true, leading: 0.72em)
  set heading(numbering: "1.1")
  set heading(outlined: true)
  show heading.where(level: 1): set text(size: 1.55em, weight: "bold", fill: accent)
  show heading.where(level: 2): set text(size: 1.22em, weight: "semibold", fill: accent)
  show heading.where(level: 3): set text(size: 1.05em, weight: "semibold", fill: accent)
  show link: set text(fill: accent)
  show raw.where(block: true): it => block(
    fill: white,
    radius: 8pt,
    inset: 12pt,
    stroke: (paint: rgb(220, 226, 232), thickness: 0.8pt),
    above: 0.9em,
    below: 0.9em,
  )[#it]

  [
    #align(center)[
      #v(2.2cm)
      #if title != none [
        #text(size: 24pt, weight: "bold", fill: accent)[#title]
      ]
      #v(1.3cm)
      #if author != none [
        #text(size: 13pt, weight: "medium")[#author]
      ]
      #if institute != none [
        #v(0.25cm)
        #text(size: 12pt, fill: rgb(110, 118, 129))[#institute]
      ]
      #if version != none [
        #v(0.55cm)
        #text(size: 10.5pt, fill: rgb(110, 118, 129))[
          #_label("version", lang) #h(0.25em) #version
        ]
      ]
      #if date != none [
        #v(0.18cm)
        #text(size: 10.5pt, fill: rgb(110, 118, 129))[
          #_label("update", lang) #h(0.25em) #date
        ]
      ]
      #if logo != none [
        #v(1.4cm)
        #image(logo, width: 40%)
      ]
    ]

    #pagebreak()
    #body
  ]
}
