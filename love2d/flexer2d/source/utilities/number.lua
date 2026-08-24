local Number = {}

Number.range = function(from, to, step)
  local tbl={}
    for i=from,to,(step or 1) do
        table.insert(tbl, i)
    end 
    return tbl
end

return Number