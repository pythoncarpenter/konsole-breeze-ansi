return {
  {
    "pythoncarpenter/konsole-breeze-ansi",
    lazy = false,
    priority = 1000,
    config = function()
      require("konsole_breeze_ansi").setup({
        semantic = true,
        transparent = false,
      })
    end,
  },
}
