M = {}

function M.setup(config)
    -- Default configuration
    config = vim.tbl_deep_extend("force", {
        signature_files = {
            os.getenv("HOME") .. "/.*mutt/signatures/*",
        },
        signature_prefix = "-- \n",
        muttrc_files = {
            os.getenv("HOME") .. "/.*muttrc",
            os.getenv("HOME") .. "/.*mutt/*muttrc",
        },
    }, config or {})
    M.config = config
end

return M
