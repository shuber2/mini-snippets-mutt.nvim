local config = require("mini-snippets-mutt").config
local snippets = {}

-- Signature snippets
for _, pattern in ipairs(config.signature_files) do
    for _, file in ipairs(vim.fn.glob(pattern, false, true)) do
        local filename = vim.fn.fnamemodify(file, ':t:r')
        local body = vim.fn.readfile(file)
        snippets[filename] = {
            prefix = 'sig-' .. filename,
            body = config.signature_prefix .. table.concat(body, '\n')
        }
    end
end

-- From address snippets
for _, pattern in ipairs(config.muttrc_files) do
    for _, file in ipairs(vim.fn.glob(pattern, false, true)) do
        local lines = vim.fn.readfile(file)
        for _, line in ipairs(lines) do
            if line:match('^set from') then
                local from = line:match('^set from%s*=%s*"(.*)"')
                if from then
                    local domain = from:match('@(.*)>')
                    if domain then
                        snippets['from-' .. domain] = {
                            prefix = 'from-' .. domain,
                            body = from
                        }
                    end
                end
            end
        end
    end
end


return snippets
