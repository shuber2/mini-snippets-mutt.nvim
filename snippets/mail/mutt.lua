local config = require("mini-snippets-mutt").config
local snippets = {}


local process_snippet_file = function(file)
    local filename = vim.fn.fnamemodify(file, ':t:r')
    local body = vim.fn.readfile(file)
    snippets[filename] = {
        prefix = 'sig-' .. filename,
        body = config.signature_prefix .. table.concat(body, '\n')
    }
end

local process_muttrc_line = function(line)
    if not line:match('^set from') then return end

    local from = line:match('^set from%s*=%s*"(.*)"')
    if not from then return end

    local domain = from:match('@(.*)>')
    if not domain then return end

    snippets['from-' .. domain] = {
        prefix = 'from-' .. domain,
        body = from
    }
end

local process_muttrc_file = function(file)
    local lines = vim.fn.readfile(file)
    for _, line in ipairs(lines) do
        process_muttrc_line(line)
    end
end


for _, pattern in ipairs(config.signature_files) do
    for _, file in ipairs(vim.fn.glob(pattern, false, true)) do
        process_snippet_file(file)
    end
end

for _, pattern in ipairs(config.muttrc_files) do
    for _, file in ipairs(vim.fn.glob(pattern, false, true)) do
        process_muttrc_file(file)
    end
end


return snippets
