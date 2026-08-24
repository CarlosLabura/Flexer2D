local Table = {}

Table.contains = function(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end
Table.indexOf = function(tbl, value)
    for i, v in ipairs(tbl) do
        if v == value then
            return i
        end
    end
    return nil
end

Table.print = function(tbl, indent)
  indent = indent or 0
  local formatting = string.rep("  ", indent)
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(formatting .. tostring(k) .. " = {")
            Table.print(v, indent + 1)
            print(formatting .. "}")
        else
            print(formatting .. tostring(k) .. " = " .. tostring(v))
        end
    end
end

--https://gist.github.com/Lerg/8791431
local random = math.random
Table.shuffle = function(t)
  local n = #t
  while n > 2 do
    local k = random(1, n)
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
end

Table.copy = function(t)
    if type(t) ~= 'table' then return t end
    local mt = getmetatable(t)
    local res = {}
    for k,v in pairs(t) do
        if type(v) == 'table' then
            v = Table.copy(v)
        end
        res[k] = v
    end
    setmetatable(res,mt)
    return res
end

return Table