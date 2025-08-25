local C = require("nightfox.lib.color")
local Shade = require("nightfox.lib.shade")

-- HorizonFox — Nightfox palette reproduzindo a tabela do Horizon original
local meta = { name = "horizonfox", light = false }

-- === Paleta (copiada/derivada da tabela original) ==========================
-- ANSI normal/bright seguem a sua tabela. Para "dim" escolhi vizinhos coerentes.
local palette = {
  black = Shade.new("#1A1C23", "#232530", "#16161C"),
  red = Shade.new("#E95678", "#EC6A88", "#D55070"), -- bright/alt e variável/tag do theme
  green = Shade.new("#29D398", "#3FDAA4", "#24A075"),
  yellow = Shade.new("#FAB795", "#FBC3A7", "#E4B28E"),
  blue = Shade.new("#26BBD9", "#3FC4DE", "#208F93"), -- dim puxa pro azul-esverdeado do theme
  magenta = Shade.new("#A86EC9", "#B877DB", "#9961BA"), -- keywords/special/storage = lavender
  cyan = Shade.new("#59E1E3", "#6BE4E6", "#25B0BC"), -- func/type no theme é turquesa
  white = Shade.new("#BBBBBB", "#D5D8DA", "#A3A7AB"),
  orange = Shade.new("#DB887A", "#FAB38E", "#D89B7C"), -- const/regex/structure da tabela
  pink = Shade.new("#EE64AC", "#F075B5", "#E95378"), -- cursor/pmenu_sel e operadores salmão

  -- UI & auxiliares (da tabela "ui" e "theme")
  comment = "#4C4D53", -- theme.comment.fg (italics é setado no syntax)
  bg0 = "#1A1C23", -- border / fundo muito escuro
  bg1 = "#1C1E26", -- theme.bg / sidebar_bg
  bg2 = "#232530", -- backgroundAlt / float_bg / pmenu_bg
  bg3 = "#2E303E", -- ui.accent / indent_guide_active_fg
  bg4 = "#343647", -- color_column / visual

  fg0 = "#D5D8DA", -- ui.lightText
  fg1 = "#BBBBBB", -- theme.fg
  fg2 = "#797B80", -- statusline_fg / active_line_number_fg
  fg3 = "#54565C", -- git_ignored_fg (mais apagado)

  sel0 = "#232530", -- visual/popup
  sel1 = "#21232D", -- cursorline (theme.cursorline_bg)
}

-- === Spec Nightfox =========================================================
local function generate_spec(pal)
  local spec = {
    bg0 = pal.bg0,
    bg1 = pal.bg1,
    bg2 = pal.bg2,
    bg3 = pal.bg3,
    bg4 = pal.bg4,
    fg0 = pal.fg0,
    fg1 = pal.fg1,
    fg2 = pal.fg2,
    fg3 = pal.fg3,
    sel0 = pal.sel0,
    sel1 = pal.sel1,
  }

  -- Mapeamento de sintaxe espelhando o "theme" que você mandou
  spec.syntax = {
    comment = pal.comment, -- #4C4D53
    bracket = "#6C6D71", -- theme.delimiter.fg
    operator = pal.white.base, -- theme.operator.fg = #BBBBBB
    string = "#E4A88A", -- theme.string.fg
    number = pal.orange.base, -- theme.constant/regex = #DB887A
    const = pal.orange.bright, -- "#FAB38E" (tertiaryAccent)
    regex = pal.orange.base,

    keyword = pal.magenta.base, -- theme.keyword/storage/template_delimiter (#A86EC9)
    statement = pal.magenta.base,
    special = pal.magenta.base,

    -- Identificadores/variáveis/campos/tags = vermelho "D55070"
    ident = "#D55070", -- aproxima Ident/Variable do theme.variable/title/tag/field
    variable = "#D55070",
    field = "#D55070",

    -- Funções/títulos = turquesa (func = #24A1AD)
    func = "#24A1AD",

    -- Tipos/estruturas = tons quentes claros (type/structure)
    type = "#E4B28E",

    -- Builtins alinhados ao Horizon:
    builtin0 = "#D55070", -- builtin var => vermelho (coincide com variable/tag)
    builtin1 = "#24A1AD", -- builtin type => turquesa
    builtin2 = pal.orange.bright, -- builtin const => #FAB38E
    builtin3 = pal.red.bright, -- reserva
    dep = spec.fg3,
    preproc = pal.pink.bright,
  }

  -- Diagnostics (theme.error/warning/ok/info)
  spec.diag = {
    error = "#F43E5C", -- ui.negative
    warn = "#FAB38E", -- ui.tertiaryAccent
    info = "#24A1AD", -- theme.func.fg (info fria)
    hint = "#24A075", -- ui.positive/ git_added_fg
    ok = "#24A075",
  }

  spec.diag_bg = {
    error = C(spec.bg1):blend(C(spec.diag.error), 0.15):to_css(),
    warn = C(spec.bg1):blend(C(spec.diag.warn), 0.15):to_css(),
    info = C(spec.bg1):blend(C(spec.diag.info), 0.15):to_css(),
    hint = C(spec.bg1):blend(C(spec.diag.hint), 0.15):to_css(),
    ok = C(spec.bg1):blend(C(spec.diag.ok), 0.15):to_css(),
  }

  -- Diff (da tabela theme.*_bg)
  spec.diff = {
    add = "#1A3432", -- diff_added_bg
    delete = "#4A2024", -- diff_deleted_bg
    change = C(spec.bg1):blend(C("#208F93"), 0.20):to_css(), -- coerente com sign_modified_bg
    text = C(spec.bg1):blend(C("#208F93"), 0.35):to_css(),
  }

  -- Git (da tabela theme/git_*_fg)
  spec.git = {
    add = "#24A075",
    removed = "#F43E5C",
    changed = "#FAB38E",
    conflict = pal.red.bright,
    ignored = spec.fg3,
  }

  return spec
end

return { meta = meta, palette = palette, generate_spec = generate_spec }
