function hexToNumber(hex)
    if type(hex) ~= "string" then
        error("Parameter hex should be a string", 2)
    end
    --Assumes big edien, first characters are most significant
    local number = 0
    placeValue = 1
    for i = #hex, 1, -1 do
        local hexChar = hex:sub(i, i)
        number = number + placeValue * ({string.find("0123456789ABCDEF", hexChar)}[1] - 1)
        placeValue = placeValue * 16
    end
    return number
end

function getScreen(terminal, layers)
    local returnScreen = {}
    layers = layers or 256
    terminal = terminal or term.current()
    local sizeX, sizeY = terminal.getSize()
    returnScreen.bkcolor = term.getBackgroundColor()
    returnScreen.sizeX, returnScreen.sizeY, returnScreen.sizeLayer = sizeX, sizeY, layers
    for i = 1, layers do
        for x = 1, sizeX do
            for y = 1, sizeY do
                returnScreen[i][x][y] = {
                    txt = " ",
                    color = colors.white,
                    bkground = colors.black
                }
            end
        end
    end
    returnScreen.posX, returnScreen.posY = 1, 1
    returnScreen.writeChar = function(self, layer, char, tcolor, bkcolor)
        local x, y = self.posX, self.posY
        if (#char == 1) and (color > 0) and (color <= 16) then
            self[layer][x][y].txt = char
            self[layer][x][y].color = tcolor
            self[layer][x][y].bkcolor = bkcolor
        else
            error("Invalid color or character", 2)
        end
    end
    returnScreen.clearLine = function(self, layer, line)
        for i = 1, self.sizeX do
            local segment = self[layer][i][line]
            segment.txt = " "
            segment.bkcolor = self.bkcolor
        end
    end
    returnScreen.clear = function(self, layer)
        for j = 1, self.sizeY do
            self:clearLine(layer, j)
        end
    end
    returnScreen.clearLayerRange = function(self, minLayer, maxLayer)
        if (minLayer < 1) or (minLayer > self.sizeLayer) then
            error("Invalid minLayer", 2)
        elseif (maxLayer < 1) or (maxLayer > self.sizeLayer) then
            error("Invalid maxLayer", 2)
        end
        for i = minLayer, maxLayer do
            self:clear(i)
        end
    end
    returnScreen.scroll = function(self, layer)
        for i = 1, self.sizeY do
            self:clearLine(i)
            if (i + 1) <= self.sizeY then
                for j = 1, self.sizeX do
                    self[layer][i][j] = self[layer][i + 1][j]
                end
            end
        end
    end
    returnScreen.blit = function(self, layer, txt, tcolor, bkcolor)
        for k, char in string.match(txt, ".") do
            local charColor, charBkcolor = tcolor:sub(k, k), bkcolor:sub(k, k)
            self:writeChar(layer, char, hexToNumber(charColor), hexToNumber(charBkcolor))
            if self.posX > self.sizeX then
                self.posX = 1
                self.posY = self.posY + 1
            end
            if self.posY > self.sizeY then
                self:scroll()
            end
        end
    end
end
