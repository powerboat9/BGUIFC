function getScreen(terminal, layers)
    local returnScreen = {}
    layers = layers or 16
    terminal = terminal or term.current()
    local sizeX, sizeY = terminal.getSize()
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
        returnScreen.writeChar = function(self, x, y, layer, char, tcolor, bkcolor)
            if (#char == 1) and (color > 0) and (color <= 16) then
                self[layer][x][y].txt = char
                self[layer][x][y].color = tcolor
                self[layer][x][y].bkcolor = bkcolor
            else
                error(2, "Invalid color or character")
            end
        end
     end
