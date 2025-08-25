local C = require("nightfox.lib.color")
local Shade = require("nightfox.lib.shade")

-- HorizonFox — Nightfox palette using Horizon (dark) colors

local meta = {
  name = "horizonfox",
  light = false,
}

-- Paleta Horizon (dark)
-- Tons principais: bg grafite, fg neutro suave, laranja/ciano/roxo característicos
-- Ajustei "bright" e "dim" de cada Shade para ficarem coerentes com o Horizon.
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

  comment = "#232530",

  -- UI (Horizon dark)
  bg0 = "#1A1C23", -- statusline/float mais escuro
  bg1 = "#1C1E26", -- fundo principal
  bg2 = "#232530", -- cursorline / popups
  bg3 = "#2E303E", -- bordas / thumbs
  bg4 = "#3A3D4C", -- border fg um pouco mais claro

  fg0 = "#E6E9EB", -- fg mais claro
  fg1 = "#D5D8DA", -- fg padrão
  fg2 = "#B9BEC4", -- fg um pouco mais escuro
  fg3 = "#6C6F93", -- números de linha / pontuação

  sel0 = "#232530", -- visual/popup bg
  sel1 = "#2E303E", -- seleção/pesquisa
}

local function generate_spec(pal)
  -- Mantém o mesmo mapeamento base do Nightfox (como no seu arquivo),
  -- só trocando a paleta para Horizon.
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

  spec.syntax = {
    bracket = spec.fg2, -- Brackets e pontuação
    builtin0 = pal.red.base, -- Builtin variable
    builtin1 = pal.cyan.bright, -- Builtin type
    builtin2 = pal.orange.bright, -- Builtin const
    builtin3 = pal.red.bright, -- (reserva)
    comment = pal.comment, -- Comentários
    conditional = pal.magenta.bright, -- Condicionais / loops
    const = pal.orange.bright, -- Constantes / imports / boolean
    dep = spec.fg3, -- Deprecated
    field = pal.blue.base, -- Fields
    func = pal.blue.bright, -- Funções / títulos
    ident = pal.cyan.base, -- Identifiers
    keyword = pal.magenta.base, -- Keywords
    number = pal.orange.base, -- Números
    operator = spec.fg2, -- Operadores
    preproc = pal.pink.bright, -- PreProc
    regex = pal.yellow.bright, -- Regex
    statement = pal.magenta.base, -- Statements
    string = pal.red.base, -- Strings
    type = pal.yellow.base, -- Tipos
    variable = pal.white.base, -- Variáveis
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
