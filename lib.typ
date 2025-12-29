// IT Operational Procedure Package
// A comprehensive package for creating professional IT documentation

// TLP (Traffic Light Protocol) colors and configuration
#let tlp-colors = (
  red: (bg: rgb("#FF0033"), fg: white, label: "TLP:RED"),
  amber: (bg: rgb("#FFC000"), fg: black, label: "TLP:AMBER"),
  green: (bg: rgb("#33FF00"), fg: black, label: "TLP:GREEN"),
  white: (bg: white, fg: black, label: "TLP:WHITE"),
  clear: (bg: rgb("#FFFFFF"), fg: black, label: "TLP:CLEAR"),
)

// TLP Indicator function
#let tlp-indicator(level: "clear") = {
  // Validate and default to "clear" if invalid level provided
  let valid-levels = ("red", "amber", "green", "white", "clear")
  let safe-level = if level in valid-levels { level } else { "clear" }
  let tlp = tlp-colors.at(safe-level)
  box(
    fill: tlp.bg,
    outset: 5pt,
    radius: 3pt,
    text(fill: tlp.fg, weight: "bold", tlp.label)
  )
}

// Style for terminal commands (green text on black background)
#let terminal(body) = {
  block(
    fill: rgb("#000000"),
    inset: 10pt,
    radius: 5pt,
    width: 100%,
    text(
      fill: rgb("#00FF00"),
      font: ("DejaVu Sans Mono", "Consolas", "Monaco", "Courier New", "monospace"),
      size: 10pt,
      body
    )
  )
}

// Style for file content editing
#let file-edit(path, body) = {
  block(
    fill: rgb("#FFF8DC"),
    stroke: (left: 4pt + rgb("#FF8C00")),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    [
      #text(fill: rgb("#FF8C00"), weight: "bold", size: 9pt)[📝 Édition du fichier: #path]
      #v(5pt)
      #text(font: ("DejaVu Sans Mono", "Consolas", "Monaco", "Courier New", "monospace"), size: 9pt, body)
    ]
  )
}

// Warning box
#let warning(body) = {
  block(
    fill: rgb("#FFF3CD"),
    stroke: (left: 4pt + rgb("#FF9800")),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    [
      #text(fill: rgb("#FF9800"), weight: "bold")[⚠️ Attention]
      #v(5pt)
      #body
    ]
  )
}

// Info box
#let info(body) = {
  block(
    fill: rgb("#D1ECF1"),
    stroke: (left: 4pt + rgb("#0C5460")),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    [
      #text(fill: rgb("#0C5460"), weight: "bold")[ℹ️ Information]
      #v(5pt)
      #body
    ]
  )
}

// Success box
#let success(body) = {
  block(
    fill: rgb("#D4EDDA"),
    stroke: (left: 4pt + rgb("#155724")),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    [
      #text(fill: rgb("#155724"), weight: "bold")[✓ Succès]
      #v(5pt)
      #body
    ]
  )
}

// Danger/Error box
#let danger(body) = {
  block(
    fill: rgb("#F8D7DA"),
    stroke: (left: 4pt + rgb("#721C24")),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    [
      #text(fill: rgb("#721C24"), weight: "bold")[❌ Erreur]
      #v(5pt)
      #body
    ]
  )
}

// Code block (generic)
#let code-block(body, lang: none) = {
  block(
    fill: rgb("#F5F5F5"),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    text(
      font: ("DejaVu Sans Mono", "Consolas", "Monaco", "Courier New", "monospace"),
      size: 9pt,
      body
    )
  )
}

// Revision history entry
#let revision-entry(version, date, author, description) = {
  grid(
    columns: (auto, 1fr, auto, 2fr),
    gutter: 10pt,
    text(weight: "bold", version),
    date,
    text(style: "italic", author),
    description
  )
}

// Revision history table
#let revision-history(entries) = {
  block(
    width: 100%,
    [
      #text(size: 12pt, weight: "bold")[Historique des révisions]
      #v(10pt)
      #table(
        columns: (auto, auto, 1fr, 2fr),
        stroke: 0.5pt,
        align: (left, left, left, left),
        table.header(
          [*Version*], [*Date*], [*Auteur*], [*Description*]
        ),
        ..entries.map(e => (e.version, e.date, e.author, e.description)).flatten()
      )
    ]
  )
}

// Approval section
#let approval-section(approvers) = {
  block(
    width: 100%,
    [
      #text(size: 12pt, weight: "bold")[Approbations]
      #v(10pt)
      #table(
        columns: (1fr, 1fr, 1fr),
        stroke: 0.5pt,
        align: (left, left, left),
        table.header(
          [*Rôle*], [*Nom*], [*Signature / Date*]
        ),
        ..approvers.map(a => (a.role, a.name, a.at("signature", default: ""))).flatten()
      )
    ]
  )
}

// Main document template
#let procedure(
  title: "Procédure Informatique",
  doc-number: "PROC-001",
  version: "1.0.0",
  date: datetime.today().display("[day]/[month]/[year]"),
  author: "",
  tlp-level: "clear",
  revisions: (),
  approvers: (),
  body
) = {
  // Set document metadata
  set document(title: title, author: author)
  
  // Set page layout
  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm, top: 3cm, bottom: 3cm),
    header: context {
      if counter(page).get().first() > 1 [
        #grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right),
          [#text(size: 9pt, fill: gray)[#title]],
          [#text(size: 9pt, fill: gray)[#doc-number]],
          [#text(size: 9pt, fill: gray)[Version #version]]
        )
        #line(length: 100%, stroke: 0.5pt + gray)
      ]
    },
    footer: context [
      #line(length: 100%, stroke: 0.5pt + gray)
      #grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        [#text(size: 9pt, fill: gray)[#date]],
        [#text(size: 9pt, fill: gray)[Page #counter(page).display("1 / 1", both: true)]],
        [#text(size: 9pt, fill: gray)[#tlp-indicator(level: tlp-level)]]
      )
    ]
  )
  
  // Set text defaults
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: "fr"
  )
  
  // Set heading styles
  show heading.where(level: 1): it => block(
    width: 100%,
    text(size: 18pt, weight: "bold", fill: rgb("#1a5490"), it.body),
    above: 20pt,
    below: 15pt
  )
  
  show heading.where(level: 2): it => block(
    width: 100%,
    text(size: 14pt, weight: "bold", fill: rgb("#2874a6"), it.body),
    above: 15pt,
    below: 12pt
  )
  
  show heading.where(level: 3): it => block(
    width: 100%,
    text(size: 12pt, weight: "bold", fill: rgb("#5499c7"), it.body),
    above: 12pt,
    below: 10pt
  )
  
  // Set paragraph spacing
  set par(
    justify: true,
    leading: 0.65em
  )
  
  // Title page
  align(center)[
    #v(1fr)
    
    #tlp-indicator(level: tlp-level)
    
    #v(30pt)
    
    #text(size: 24pt, weight: "bold", fill: rgb("#1a5490"))[#title]
    
    #v(10pt)
    
    #text(size: 14pt, fill: gray)[Document #doc-number]
    
    #v(30pt)
    
    #grid(
      columns: (auto, 1fr),
      gutter: 15pt,
      align: (right, left),
      [*Version:*], [#version],
      [*Date:*], [#date],
      [*Auteur:*], [#author],
    )
    
    #v(1fr)
  ]
  
  pagebreak()
  
  // Revision history (if provided)
  if revisions.len() > 0 {
    revision-history(revisions)
    v(20pt)
  }
  
  // Approval section (if provided)
  if approvers.len() > 0 {
    approval-section(approvers)
    v(20pt)
  }
  
  // Table of contents
  outline(
    title: [Table des matières],
    indent: auto
  )
  
  pagebreak()
  
  // Main content
  body
}
