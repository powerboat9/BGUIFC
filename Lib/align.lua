local function interpret(style)
    style = textutils.unserialize(style)
    local newStyle = {
        border =
    for k, v in pairs(style) do
        local temp = newStyle
        local kParts = {}
        for kPart in k:gfind("([^-]*)-?") do
            kParts[#kParts + 1] = kPart
        end
        if #kParts > 1 then
            for i = 1, #kParts - 1 do
                temp[kParts[i]] = (type(temp[kParts[i]]) == "table") or {}
                temp = temp[kParts[i]]
            end
        end
        temp[kParts[#kParts]] = v
    end

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
                
