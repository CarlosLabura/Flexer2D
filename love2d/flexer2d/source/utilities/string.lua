local String = {}

String.split = function(str, sep)
  sep = sep or "%s"
  local t = {}
    for s in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, s)
    end
    return t
end

String.trim = function(str, replace)
    local replace = replace or ''
    return string.gsub(str, "%s+", replace)
end

String.range = function(from, to, step)
    local t = {}
    for i = from, to, step or 1 do
        t[#t+1] = i
    end
    return table.concat(t, ',')
end

String.getLetterByPosition = function(str,pos)
  return string.sub(str, pos, pos)
end

return String