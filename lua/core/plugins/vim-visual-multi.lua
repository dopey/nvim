return {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
        vim.g.VM_leader = ','
        vim.g.VM_maps = {
            ['Motion ,'] = ',,',
            ["Undo"] = 'u',
            ["Redo"] = '<C-r>',
            ['Find Under'] = ',n',
            ['Find Subword Under'] = ',n',
        }
    end,
}
