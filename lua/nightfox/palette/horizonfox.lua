local C = require("nightfox.lib.color")
local Shade = require("nightfox.lib.shade")

local meta = { name = "horizonfox", light = false }

-- Paleta fiel ao Horizon (tabela que você enviou), sem HEX solto no spec.
local palette = {
  -- ANSI / primárias (Shade: base, bright, dim)
  black = Shade.new("#1A1C23", "#232530", "#16161C"),
  red = Shade.new("#E95678", "#EC6A88", "#D55070"), -- dim casa com variable/tag
  green = Shade.new("#29D398", "#3FDAA4", "#24A075"),
  -- Amarelos/laranjas: usamos 'yellow' p/ tipos e 'orange' p/ const/regex
  yellow = Shade.new("#E4B28E", "#FAB38E", "#E4A88A"), -- base=type, bright=tertiaryAccent, dim=string
  blue = Shade.new("#26BBD9", "#3FC4DE", "#208F93"),
  magenta = Shade.new("#A86EC9", "#B877DB", "#9961BA"),
  cyan = Shade.new("#59E1E3", "#6BE4E6", "#25B0BC"),
  white = Shade.new("#BBBBBB", "#D5D8DA", "#A3A7AB"),
  orange = Shade.new("#DB887A", "#FAB38E", "#D89B7C"), -- const/regex

  -- UI e auxiliares (vindos de theme/ui)
  comment = "#4C4D53",
  delimiter = "#6C6D71",
  operator = "#BBBBBB",

  variable = "#D55070", -- variable/title/tag/field
  field = "#D55070",
  func = "#24A1AD", -- functions/titles
  type_fg = "#E4B28E", -- alias p/ yellow.base
  string = "#E4A88A", -- alias p/ yellow.dim

  diag_error = "#F43E5C",
  diag_warn = "#FAB38E",
  diag_info = "#24A1AD",
  diag_hint = "#24A075",

  -- UI backgrounds/foregrounds
  bg0 = "#1A1C23",
  bg1 = "#1C1E26",
  bg2 = "#232530",
  bg3 = "#2E303E",
  bg4 = "#343647",

  fg0 = "#D5D8DA",
  fg1 = "#BBBBBB",
  fg2 = "#797B80",
  fg3 = "#54565C",

  sel0 = "#232530", -- float/pmenu/visual
  sel1 = "#21232D", -- cursorline
}

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

  -- Sintaxe (tudo referenciando 'palette', sem HEX literal)
  spec.syntax = {
    comment = pal.comment,
    bracket = pal.delimiter,
    operator = pal.operator,

    string = pal.string, -- #E4A88A
    number = pal.orange.base, -- #DB887A
    const = pal.orange.bright, -- #FAB38E
    regex = pal.orange.base,

    keyword = pal.magenta.base, -- #A86EC9
    statement = pal.magenta.base,
    special = pal.magenta.base,

    ident = pal.white.base, -- neutro
    variable = pal.variable, -- #D55070
    field = pal.field, -- #D55070

    func = pal.func, -- #24A1AD
    type = pal.type_fg, -- #E4B28E

    builtin0 = pal.variable, -- builtin var
    builtin1 = pal.orange.base, -- builtin type
    builtin2 = pal.orange.bright, -- builtin const
    builtin3 = pal.red.bright,
    dep = spec.fg3,
    preproc = pal.pink.bright,
  }

  -- Diagnostics
  spec.diag = {
    error = pal.diag_error,
    warn = pal.diag_warn,
    info = pal.diag_info,
    hint = pal.diag_hint,
    ok = pal.diag_hint,
  }

  spec.diag_bg = {
    error = C(spec.bg1):blend(C(spec.diag.error), 0.15):to_css(),
    warn = C(spec.bg1):blend(C(spec.diag.warn), 0.15):to_css(),
    info = C(spec.bg1):blend(C(spec.diag.info), 0.15):to_css(),
    hint = C(spec.bg1):blend(C(spec.diag.hint), 0.15):to_css(),
    ok = C(spec.bg1):blend(C(spec.diag.ok), 0.15):to_css(),
  }

  -- Diff (usa os tons do theme)
  spec.diff = {
    add = "#1A3432",
    delete = "#4A2024",
    change = C(spec.bg1):blend(C(pal.blue.dim), 0.20):to_css(),
    text = C(spec.bg1):blend(C(pal.blue.dim), 0.35):to_css(),
  }

  -- Git (do theme)
  spec.git = {
    add = pal.green.dim, -- #24A075
    removed = pal.diag_error, -- #F43E5C
    changed = pal.orange.bright, -- #FAB38E
    conflict = pal.red.bright,
    ignored = spec.fg3,
  }

  return spec
end

return { meta = meta, palette = palette, generate_spec = generate_spec }
