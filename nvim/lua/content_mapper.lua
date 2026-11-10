-- TypeScript 7.1+ content mappers: tsconfig `contentMappers` let the
-- TypeScript language server check other languages (`.vue`, `.svelte`, ...) by
-- mapping them to TypeScript. This module finds which files they claim.
local M = {}

-- Decodes a tsconfig, which is JSONC: comments and trailing commas.
local function read_tsconfig(path)
    local ok, lines = pcall(vim.fn.readfile, path)
    if not ok then
        return
    end
    local text = table.concat(lines, "\n"):gsub(",(%s*[%]}])", "%1")
    local decoded, cfg = pcall(vim.json.decode, text, { skip_comments = true })
    if decoded and type(cfg) == "table" then
        return cfg
    end
end

-- Resolves an `extends` entry of the tsconfig at `from`: a relative or
-- absolute path, or a package path looked up in `node_modules`.
local function resolve_extends(spec, from)
    local candidates = {}
    if spec:match("^%.%.?/") or spec:match("^/") then
        local path = spec:match("^/") and spec or vim.fs.dirname(from) .. "/" .. spec
        path = vim.fs.normalize(path)
        candidates = { path, path .. ".json" }
    else
        for dir in vim.fs.parents(from) do
            local path = dir .. "/node_modules/" .. spec
            vim.list_extend(candidates, { path, path .. ".json", path .. "/tsconfig.json" })
        end
    end
    for _, path in ipairs(candidates) do
        if vim.fn.filereadable(path) == 1 then
            return path
        end
    end
end

-- `contentMappers` of the tsconfig at `path`. A tsconfig without its own
-- takes them from what it extends, the last entry first.
local function content_mappers(path, depth)
    depth = depth or 0
    local cfg = depth <= 10 and read_tsconfig(path)
    if not cfg then
        return
    end
    if type(cfg.contentMappers) == "table" then
        return cfg.contentMappers
    end
    local extends = type(cfg.extends) == "string" and { cfg.extends } or cfg.extends
    if type(extends) ~= "table" then
        return
    end
    for i = #extends, 1, -1 do
        local parent = type(extends[i]) == "string" and resolve_extends(extends[i], path)
        local mappers = parent and content_mappers(parent, depth + 1)
        if mappers then
            return mappers
        end
    end
end

-- The extension (e.g. ".vue") by which a content mapper of the nearest
-- tsconfig.json claims `fname`, or nil when none does.
function M.extension(fname)
    local tsconfig = vim.fs.find("tsconfig.json", { path = vim.fs.dirname(fname), upward = true })[1]
    for _, mapper in ipairs(tsconfig and content_mappers(tsconfig) or {}) do
        local extensions = type(mapper) == "table" and mapper.extensions
        for _, ext in ipairs(type(extensions) == "table" and extensions or {}) do
            if type(ext) == "string" and vim.endswith(fname, ext) then
                return ext
            end
        end
    end
end

return M
