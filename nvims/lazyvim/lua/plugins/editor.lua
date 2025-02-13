return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {

      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.95,
          width = 0.95,
          prompt_position = "bottom",
          preview_width = 0.6,
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        width = 0.95,
        preview = {
          horizontal = "right:60%",
        },
      },
    },
  },
}
