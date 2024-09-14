vim.loader.enable()

for _, source in ipairs {
  "base.1-options",
  "base.2-lazy",
  "base.3-autocmds",
  "base.4-mappings",
} do
  local status_ok, error = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. error) end
end

if base.default_colorscheme then
  local status_ok = pcall(vim.cmd.colorscheme, base.default_colorscheme)
  if not status_ok then
    require("base.utils").notify(
      "Error setting up colorscheme: " .. base.default_colorscheme,
      vim.log.levels.ERROR
    )
  end
end
