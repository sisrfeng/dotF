-- print('wf redefining paste')


-- todo

-- vim.paste = (function(lines, phase)
--         vim.api.nvim_put(lines,   'c',    true,    true)
-- end)

            -- nvim_put({lines}, {type}, {after}, {follow})
            --                     • "c" |charwise| mode
            --                     • "l" |linewise| mode
            --                             {after}   If true insert after cursor (like |p|),
            --                                     {follow}  If true place cursor at end of inserted text.
