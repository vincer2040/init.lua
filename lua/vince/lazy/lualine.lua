return {
    "nvim-lualine/lualine.nvim",
    depedencies = {
        'nvim-tree/nvim-web-devicons',
    },

    config = function()
        require('lualine').setup({})
    end
}
