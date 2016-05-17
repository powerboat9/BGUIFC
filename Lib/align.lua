function newAlign(myTerm)
    local objects = {list = {}, map = {}}
    return {
        addSquare = function(oX, oY, name, style)
            oX = ((type(oX) == "number") and oX) or false
            oY = ((type(oY) == "number") and oY) or false
            style = ((type(style) == "table") and style) or {}
            local id = #objects.list + 1
            objects.list[id] = {oX, oY, style}
            objects.map[name] = id
        end,
        removeSquare = function(name)
            local id = objects.map[name]
            objects.map[name] = nil
            table.remove(objects.list, id)
        end,
        changeSquare = function(name, oX, oY, style)
            oX = ((type(oX) == "number") and oX) or false
            oY = ((type(oY) == "number") and oY) or false
            style = ((type(style) == "table") and style) or {}
            objects.list[objects.map[name]] = {oX, oY, style}
        end,
        arange = function()
            local sizeX, sizeY = term.getSize()
            local allocatedLines = {}
            for _, v in ipairs(objects.list) do
                local tStyle = v[4]
                
