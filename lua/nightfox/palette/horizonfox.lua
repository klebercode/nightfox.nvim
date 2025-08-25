local C = require("nightfox.lib.color")
local Shade = require("nightfox.lib.shade")

local meta = { name = "horizonfox", light = false }

-- Paleta Horizon (dark)
local palette = {
  black = Shade.new("#1A1C23", "#232530", "#151720"),
  red = Shade.new("#E95678", "#EC6A88", "#C7445F"),
  green = Shade.new("#09F7A0", "#3FDAA4", "#07C985"),
  yellow = Shade.new("#FAC29A", "#FFD2B9", "#DDAF8A"),
  blue = Shade.new("#26BBD9", "#3FC6DE", "#1E9AB4"),
  magenta = Shade.new("#B877DB", "#C691E9", "#9961BA"),
  cyan = Shade.new("#21BFC2", "#6BE6E6", "#1AA6A9"),
  white = Shade.new("#D5D8DA", "#FDF0ED", "#B7BBBE"),
  orange = Shade.new("#FAB795", "#FBC3A7", "#D89B7C"),
  pink = Shade.new("#EE64AE", "#F075B7", "#C85494"),

  comment = "#4A4F66", -- mais discreto que #6C6F93

  -- UI
  bg0 = "#1A1C23",
  bg1 = "#1C1E26",
  bg2 = "#232530",
  bg3 = "#2E303E",
  bg4 = "#3A3D4C",

  fg0 = "#E6E9EB",
  fg1 = "#D5D8DA",
  fg2 = "#B9BEC4",
  fg3 = "#6C6F93",

  sel0 = "#232530",
  sel1 = "#2E303E",
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

  -- >>> MAPEAMENTO FIEL AO HORIZON <<<
  spec.syntax = {
    bracket = spec.fg3, -- pontuação/brackets mais “apagado”
    comment = pal.comment, -- comentários discretos
    string = pal.yellow.bright, -- Horizon usa pêssego/amarelo para strings
    number = pal.orange.base,
    const = pal.orange.bright, -- constantes / imports / enum
    keyword = pal.red.base,
    statement = pal.red.base,
    operator = pal.pink.base, -- salmão
    ident = spec.fg1, -- **neutro** (não ciano)
    variable = spec.fg1, -- idem
    field = pal.cyan.base, -- fields/propriedades/atributos
    func = pal.magenta.base, -- funções/títulos em **roxo**
    type = pal.magenta.base, -- tipos/classes/constructors roxo
    builtin0 = pal.cyan.base, -- builtin var (ex.: builtins/attrs) ciano
    builtin1 = pal.magenta.bright, -- builtin type em roxo vivo
    builtin2 = pal.orange.bright, -- builtin const em laranja
    builtin3 = pal.red.bright, -- reserva
    preproc = pal.pink.bright,
    regex = pal.yellow.bright,
    dep = spec.fg3,
  }

  spec.diag = {
    error = pal.red.base,
    warn = pal.yellow.base,
    info = pal.blue.base,
    hint = pal.green.base,
    ok = pal.green.base,
  }

  spec.diag_bg = {
    error = C(spec.bg1):blend(C(spec.diag.error), 0.15):to_css(),
    warn = C(spec.bg1):blend(C(spec.diag.warn), 0.15):to_css(),
    info = C(spec.bg1):blend(C(spec.diag.info), 0.15):to_css(),
    hint = C(spec.bg1):blend(C(spec.diag.hint), 0.15):to_css(),
    ok = C(spec.bg1):blend(C(spec.diag.ok), 0.15):to_css(),
  }

  spec.diff = {
    add = C(spec.bg1):blend(C(pal.green.base), 0.20):to_css(),
    delete = C(spec.bg1):blend(C(pal.red.base), 0.25):to_css(),
    change = C(spec.bg1):blend(C(pal.cyan.base), 0.20):to_css(),
    text = C(spec.bg1):blend(C(pal.cyan.base), 0.35):to_css(),
  }

  spec.git = {
    add = pal.green.base,
    removed = pal.red.base,
    changed = pal.yellow.base,
    conflict = pal.orange.base,
    ignored = pal.comment,
  }

  return spec
end

return { meta = meta, palette = palette, generate_spec = generate_spec }
