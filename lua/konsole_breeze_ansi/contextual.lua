local M = {}

local NS = vim.api.nvim_create_namespace("KonsoleBreezeAnsiContextual")

local BRACKET_OPEN = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
}

local BRACKET_CLOSE = {
  [")"] = "(",
  ["]"] = "[",
  ["}"] = "{",
}

local CAST_NODE_TYPES = {
  as_expression = true,
  type_assertion = true,
  conversion_expression = true,
  cast_expression = true,
  dynamic_cast_expression = true,
  static_cast_expression = true,
  reinterpret_cast_expression = true,
  const_cast_expression = true,
}

local TYPE_LIKE_NODE_TYPES = {
  type = true,
  type_identifier = true,
  type_name = true,
  qualified_type = true,
  primitive_type = true,
  predefined_type = true,
  builtin_type = true,
  generic_type = true,
  scoped_type_identifier = true,
  template_type = true,
  array_type = true,
  pointer_type = true,
  reference_type = true,
}

local PRIMITIVE_CAST_NAMES = {
  int = true,
  float = true,
  str = true,
  bool = true,
  bytes = true,
  bytearray = true,
  tuple = true,
  list = true,
  dict = true,
  set = true,
  frozenset = true,
  complex = true,
  char = true,
  short = true,
  long = true,
  double = true,
  number = true,
  string = true,
  bigint = true,
  integer = true,
  decimal = true,
}

local function is_bracket_char(ch)
  return BRACKET_OPEN[ch] ~= nil or BRACKET_CLOSE[ch] ~= nil
end

local function group_for_depth(depth)
  if depth >= 3 then
    return "KonsoleBreezeTertiaryBracket"
  end
  if depth >= 2 then
    return "KonsoleBreezeNestedBracket"
  end
  return nil
end

local function mark(bufnr, row, col, group)
  vim.api.nvim_buf_set_extmark(bufnr, NS, row - 1, col - 1, {
    end_row = row - 1,
    end_col = col,
    hl_group = group,
    priority = 4096,
  })
end

local function is_descendant(node, ancestor)
  local nsr, nsc, ner, nec = node:range()
  local asr, asc, aer, aec = ancestor:range()

  if nsr < asr or ner > aer then
    return false
  end
  if nsr == asr and nsc < asc then
    return false
  end
  if ner == aer and nec > aec then
    return false
  end
  return true
end

local function in_field_subtree(node, ancestor, field_names)
  for _, field_name in ipairs(field_names) do
    for _, field_node in ipairs(ancestor:field(field_name)) do
      if is_descendant(node, field_node) then
        return true
      end
    end
  end
  return false
end

local function node_type_has_any(node_type, needles)
  for _, needle in ipairs(needles) do
    if node_type:find(needle, 1, true) then
      return true
    end
  end
  return false
end

local function is_identifier_node(node)
  local t = node:type()
  return node_type_has_any(t, { "identifier", "name" })
end

local IMPORT_LIKE_TYPES = {
  import_statement = true,
  import_from_statement = true,
  import_clause = true,
  import_declaration = true,
  import_specifier = true,
  import_alias = true,
  include_directive = true,
  require_call = true,
  using_declaration = true,
  using_directive = true,
}

local function is_import_like_context(node)
  local current = node:parent()
  while current do
    local t = current:type()
    if IMPORT_LIKE_TYPES[t] or node_type_has_any(t, { "import", "include", "require", "using" }) then
      return true
    end
    current = current:parent()
  end
  return false
end

local function is_definition_target(node)
  local current = node:parent()
  while current do
    local t = current:type()
    local declaration_like = node_type_has_any(t, {
      "assignment",
      "declaration",
      "definition",
      "declarator",
      "function",
      "method",
      "class",
      "struct",
      "enum",
      "interface",
      "type_alias",
      "typedef",
      "module",
      "namespace",
      "for_statement",
      "for_in_clause",
      "catch_clause",
      "parameter",
      "lambda",
    })
    if declaration_like then
      if in_field_subtree(node, current, { "left", "name", "pattern", "target", "id", "parameter", "variable" }) then
        return true
      end
    end
    current = current:parent()
  end
  return false
end

local function is_function_symbol(node)
  local parent = node:parent()
  if not parent then
    return false
  end

  local pt = parent:type()
  if node_type_has_any(pt, { "call", "invocation" }) then
    for _, field_name in ipairs({ "function", "callee", "name" }) do
      for _, field_node in ipairs(parent:field(field_name)) do
        if field_node:id() == node:id() then
          return true
        end
      end
    end
  end

  if node_type_has_any(pt, { "member", "attribute", "field_expression" }) then
    if in_field_subtree(node, parent, { "attribute", "property", "field", "name" }) then
      return true
    end
  end

  if node_type_has_any(pt, { "keyword_argument", "named_argument" }) then
    if in_field_subtree(node, parent, { "name", "label" }) then
      return true
    end
  end

  return false
end

local function is_string_context(node)
  local current = node:parent()
  while current do
    local t = current:type()
    if node_type_has_any(t, { "string", "interpolation", "template", "quoted", "heredoc" }) then
      return true
    end
    current = current:parent()
  end
  return false
end

local CONDITIONAL_NODE_HINTS = { "if", "while", "for", "conditional", "match", "case", "switch", "guard", "assert", "when" }
local CONDITIONAL_FIELD_NAMES = { "condition", "test", "predicate", "guard", "expression", "value" }
local CONDITIONAL_CHILD_HINTS = { "condition", "test", "predicate", "guard" }
local ARGUMENT_NODE_HINTS = { "argument", "arguments", "arglist", "argument_list", "call_arguments" }

local function is_conditional_context(node)
  local current = node:parent()
  while current do
    local t = current:type()
    if node_type_has_any(t, CONDITIONAL_NODE_HINTS) then
      if in_field_subtree(node, current, CONDITIONAL_FIELD_NAMES) then
        return true
      end
      for child in current:iter_children() do
        if node_type_has_any(child:type(), CONDITIONAL_CHILD_HINTS) and is_descendant(node, child) then
          return true
        end
      end
    end
    current = current:parent()
  end
  return false
end

local function is_call_argument_context(node)
  local current = node:parent()
  while current do
    local t = current:type()
    if node_type_has_any(t, { "call", "invocation" }) then
      if in_field_subtree(node, current, { "arguments", "argument", "args", "parameters", "value" }) then
        return true
      end
      for child in current:iter_children() do
        if node_type_has_any(child:type(), ARGUMENT_NODE_HINTS) and is_descendant(node, child) then
          return true
        end
      end
      return false
    end
    current = current:parent()
  end
  return false
end

local function apply_identifier_read_overrides(bufnr)
  local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok_parser or not parser then
    return
  end

  local trees = parser:parse()
  if not trees then
    return
  end

  local function walk(node)
    if is_identifier_node(node) and not is_definition_target(node) and not is_function_symbol(node) then
      local sr, sc, er, ec = node:range()
      if not (sr == er and sc == ec) then
        local group = "KonsoleBreezeReadUse"
        if is_conditional_context(node) or is_call_argument_context(node) then
          group = "KonsoleBreezeDynamicRead"
        end
        if is_string_context(node) then
          group = "KonsoleBreezeStringVariable"
        end
        vim.api.nvim_buf_set_extmark(bufnr, NS, sr, sc, {
          end_row = er,
          end_col = ec,
          hl_group = group,
          priority = 4050,
        })
      end
    end

    for child in node:iter_children() do
      walk(child)
    end
  end

  for _, tree in ipairs(trees) do
    walk(tree:root())
  end
end

local function apply_import_target_overrides(bufnr)
  local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok_parser or not parser then
    return
  end

  local trees = parser:parse()
  if not trees then
    return
  end

  local function walk(node)
    if is_identifier_node(node) and is_import_like_context(node) then
      local sr, sc, er, ec = node:range()
      if not (sr == er and sc == ec) then
        vim.api.nvim_buf_set_extmark(bufnr, NS, sr, sc, {
          end_row = er,
          end_col = ec,
          hl_group = "KonsoleBreezeImportTarget",
          priority = 4200,
        })
      end
    end

    for child in node:iter_children() do
      walk(child)
    end
  end

  for _, tree in ipairs(trees) do
    walk(tree:root())
  end
end

local function mark_node(bufnr, node, group)
  local sr, sc, er, ec = node:range()
  if sr == er and sc == ec then
    return
  end
  vim.api.nvim_buf_set_extmark(bufnr, NS, sr, sc, {
    end_row = er,
    end_col = ec,
    hl_group = group,
    priority = 4096,
  })
end

local function is_cast_node_type(node_type)
  return CAST_NODE_TYPES[node_type] or node_type:find("cast", 1, true) ~= nil
end

local function normalized_symbol_name(raw)
  if not raw or raw == "" then
    return nil
  end
  local last = raw:match("([%w_]+)$")
  if not last then
    return nil
  end
  return last:lower()
end

local function node_text(bufnr, node)
  local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
  if not ok then
    return nil
  end
  if type(text) == "table" then
    return table.concat(text, "\n")
  end
  return text
end

local function mark_callee_symbol(bufnr, callee_node)
  local marked = false
  for _, field_name in ipairs({ "attribute", "property", "field", "name" }) do
    for _, field_node in ipairs(callee_node:field(field_name)) do
      mark_node(bufnr, field_node, "KonsoleBreezeTypeCast")
      marked = true
    end
  end
  if not marked then
    mark_node(bufnr, callee_node, "KonsoleBreezeTypeCast")
  end
end

local function is_primitive_cast_call(bufnr, node)
  local t = node:type()
  if not node_type_has_any(t, { "call", "invocation" }) then
    return false
  end

  for _, field_name in ipairs({ "function", "callee", "name" }) do
    for _, callee_node in ipairs(node:field(field_name)) do
      local text = node_text(bufnr, callee_node)
      local symbol = normalized_symbol_name(text)
      if symbol and PRIMITIVE_CAST_NAMES[symbol] then
        mark_callee_symbol(bufnr, callee_node)
        return true
      end
    end
  end
  return false
end

local function mark_type_like_subtree(bufnr, node, allow_identifier)
  local node_type = node:type()
  local looks_like_type = TYPE_LIKE_NODE_TYPES[node_type] or node_type:find("type", 1, true) ~= nil
  local mark_identifier = allow_identifier and node_type == "identifier"

  if looks_like_type or mark_identifier then
    mark_node(bufnr, node, "KonsoleBreezeTypeCast")
  end

  local child_allow_identifier = allow_identifier or looks_like_type
  for child in node:iter_children() do
    mark_type_like_subtree(bufnr, child, child_allow_identifier)
  end
end

local function apply_type_cast_overrides(bufnr)
  local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok_parser or not parser then
    return
  end

  local trees = parser:parse()
  if not trees then
    return
  end

  local cast_fields = { "type", "target_type", "annotation", "cast_type", "right" }

  local function walk(node)
    is_primitive_cast_call(bufnr, node)

    if is_cast_node_type(node:type()) then
      local had_specific_field = false
      for _, field in ipairs(cast_fields) do
        for _, field_node in ipairs(node:field(field)) do
          had_specific_field = true
          mark_type_like_subtree(bufnr, field_node, true)
        end
      end
      if not had_specific_field then
        mark_type_like_subtree(bufnr, node, false)
      end
    end

    for child in node:iter_children() do
      walk(child)
    end
  end

  for _, tree in ipairs(trees) do
    walk(tree:root())
  end
end

local function apply_bracket_overrides(bufnr)
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, line_count, false)
  local stack = {}

  local in_string = false
  local string_quote = nil
  local string_triple = false

  for row, line in ipairs(lines) do
    local col = 1
    while col <= #line do
      local ch = line:sub(col, col)
      local next2 = line:sub(col, col + 2)
      local prev = col > 1 and line:sub(col - 1, col - 1) or ""

      if in_string then
        if is_bracket_char(ch) then
          mark(bufnr, row, col, "KonsoleBreezeStringBracket")
        end

        if string_triple then
          if next2 == string_quote .. string_quote .. string_quote then
            in_string = false
            string_quote = nil
            string_triple = false
            col = col + 3
            goto continue
          end
        elseif ch == string_quote and prev ~= "\\" then
          in_string = false
          string_quote = nil
          col = col + 1
          goto continue
        end

        col = col + 1
        goto continue
      end

      if next2 == "'''" or next2 == '"""' then
        in_string = true
        string_quote = line:sub(col, col)
        string_triple = true
        col = col + 3
        goto continue
      end

      if (ch == "'" or ch == '"') and prev ~= "\\" then
        in_string = true
        string_quote = ch
        string_triple = false
        col = col + 1
        goto continue
      end

      local close_for_open = BRACKET_OPEN[ch]
      if close_for_open then
        local depth_after = #stack + 1
        local group = group_for_depth(depth_after)
        if group then
          mark(bufnr, row, col, group)
        end
        stack[#stack + 1] = ch
      else
        local open_for_close = BRACKET_CLOSE[ch]
        if open_for_close then
          local depth_before = #stack
          local group = group_for_depth(depth_before)
          if group then
            mark(bufnr, row, col, group)
          end

          if #stack > 0 and stack[#stack] == open_for_close then
            stack[#stack] = nil
          elseif #stack > 0 then
            -- Reset on mismatched delimiters to avoid color drift.
            stack = {}
          end
        end
      end

      col = col + 1
      ::continue::
    end
  end
end

function M.refresh(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  vim.api.nvim_set_hl(0, "KonsoleBreezeNestedBracket", { fg = "#A6E3A1" })
  vim.api.nvim_set_hl(0, "KonsoleBreezeTertiaryBracket", { fg = "#3DAEE9", bold = true })
  vim.api.nvim_set_hl(0, "KonsoleBreezeStringBracket", { fg = "#CDD6F4" })
  vim.api.nvim_set_hl(0, "KonsoleBreezeTypeCast", { fg = "#6B3FA0", bold = true })
  vim.api.nvim_set_hl(0, "KonsoleBreezeReadUse", { fg = "#A6E3A1" })
  vim.api.nvim_set_hl(0, "KonsoleBreezeDynamicRead", { fg = "#D2B48C" })
  vim.api.nvim_set_hl(0, "KonsoleBreezeStringVariable", { fg = "#A6E3A1" })
  vim.api.nvim_set_hl(0, "KonsoleBreezeImportTarget", { fg = "#A6E3A1" })

  vim.api.nvim_buf_clear_namespace(bufnr, NS, 0, -1)
  apply_bracket_overrides(bufnr)
  apply_type_cast_overrides(bufnr)
  apply_import_target_overrides(bufnr)
  apply_identifier_read_overrides(bufnr)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("KonsoleBreezeAnsiContextual", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
    group = group,
    callback = function(args)
      M.refresh(args.buf)
    end,
  })
end

return M
