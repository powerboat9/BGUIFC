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
    end
    returnScreen --Add term functions
