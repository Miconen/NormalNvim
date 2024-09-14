--- ### UI toggle functions.
local M = {}
local utils = require("base.utils")
local function bool2str(bool) return bool and "on" or "off" end

--- Change the number display modes
function M.change_number()
  local number = vim.wo.number                 -- local to window
  local relativenumber = vim.wo.relativenumber -- local to window
  if not number and not relativenumber then
    vim.wo.number = true
  elseif number and not relativenumber then
    vim.wo.relativenumber = true
  elseif number and relativenumber then
    vim.wo.number = false
  else -- not number and relativenumber
    vim.wo.relativenumber = false
  end
  utils.notify(string.format("number %s, relativenumber %s", bool2str(vim.wo.number), bool2str(vim.wo.relativenumber)))
end

--- Set the indent and tab related numbers
function M.set_indent()
  local input_avail, input = pcall(vim.fn.input, "Set indent value (>0 expandtab, <=0 noexpandtab): ")
  if input_avail then
    local indent = tonumber(input)
    if not indent or indent == 0 then return end
    vim.bo.expandtab = (indent > 0) -- local to buffer
    indent = math.abs(indent)
    vim.bo.tabstop = indent         -- local to buffer
    vim.bo.softtabstop = indent     -- local to buffer
    vim.bo.shiftwidth = indent      -- local to buffer
    utils.notify(string.format("indent=%d %s", indent, vim.bo.expandtab and "expandtab" or "noexpandtab"))
  end
end

--- Toggle auto format
function M.toggle_autoformat()
  vim.g.autoformat_enabled = not vim.g.autoformat_enabled
  utils.notify(string.format("Global autoformatting %s", bool2str(vim.g.autoformat_enabled)))
end

--- Toggle autopairs
function M.toggle_autopairs()
  local ok, autopairs = pcall(require, "nvim-autopairs")
  if ok then
    if autopairs.state.disabled then
      autopairs.enable()
    else
      autopairs.disable()
    end
    vim.g.autopairs_enabled = autopairs.state.disabled
    utils.notify(string.format("autopairs %s", bool2str(not autopairs.state.disabled)))
  else
    utils.notify "autopairs not available"
  end
end

--- Toggle buffer local auto format
function M.toggle_buffer_autoformat(bufnr)
  bufnr = bufnr or 0
  local old_val = vim.b[bufnr].autoformat_enabled
  if old_val == nil then old_val = vim.g.autoformat_enabled end
  vim.b[bufnr].autoformat_enabled = not old_val
  utils.notify(string.format("Buffer autoformatting %s", bool2str(vim.b[bufnr].autoformat_enabled)))
end

--- Toggle LSP inlay hints (buffer)
-- @param bufnr? number the buffer to toggle the clients on
function M.toggle_buffer_inlay_hints(bufnr)
  bufnr = bufnr or 0
  vim.b[bufnr].inlay_hints_enabled = not vim.b[bufnr].inlay_hints_enabled
  vim.lsp.inlay_hint.enable(vim.b[bufnr].inlay_hints_enabled, { bufnr = bufnr })
  utils.notify(string.format("Inlay hints %s", bool2str(vim.b[bufnr].inlay_hints_enabled)))
end
--- Toggle codelens
function M.toggle_codelens()
  vim.g.codelens_enabled = not vim.g.codelens_enabled
  if not vim.g.codelens_enabled then vim.lsp.codelens.clear() end
  utils.notify(string.format("CodeLens %s", bool2str(vim.g.codelens_enabled)))
end

--- Toggle cmp entrirely
function M.toggle_cmp()
  vim.g.cmp_enabled = not vim.g.cmp_enabled
  local ok, _ = pcall(require, "cmp")
  utils.notify(ok and string.format("completion %s", bool2str(vim.g.cmp_enabled)) or "completion not available")
end

--- Toggle LSP inlay hints (global)
-- @param bufnr? number the buffer to toggle the clients on
function M.toggle_inlay_hints(bufnr)
  bufnr = bufnr or 0
  vim.g.inlay_hints_enabled = not vim.g.inlay_hints_enabled -- flip global state
  vim.b.inlay_hints_enabled = not vim.g.inlay_hints_enabled -- sync buffer state
  vim.lsp.buf.inlay_hint.enable(vim.g.inlay_hints_enabled, { bufnr = bufnr }) -- apply state
  utils.notify(string.format("Global inlay hints %s", bool2str(vim.g.inlay_hints_enabled)))
end

--- Toggle lsp signature
function M.toggle_lsp_signature()
  local state = require('lsp_signature').toggle_float_win()
  utils.notify(string.format("lsp signature %s", bool2str(state)))
end

--- Toggle copilot
function M.toggle_copilot()
  local ok, copilot = pcall(require, "copilot")
  if ok then
    copilot.toggle()
    utils.notify(string.format("copilot %s", bool2str(copilot.is_plugin_enabled)))
  else
    utils.notify "copilot not available"
  end
end

--- Toggle spell
function M.toggle_spell()
  vim.wo.spell = not vim.wo.spell -- local to window
  utils.notify(string.format("spell %s", bool2str(vim.wo.spell)))
end

--- Toggle notifications for UI toggles
function M.toggle_ui_notifications()
  vim.g.notifications_enabled = not vim.g.notifications_enabled
  utils.notify(string.format("Notifications %s", bool2str(vim.g.notifications_enabled)))
end

--- Toggle wrap
function M.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap -- local to window
  utils.notify(string.format("wrap %s", bool2str(vim.wo.wrap)))
end

return M
