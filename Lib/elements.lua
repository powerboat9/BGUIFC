local function wipe()
    term.clear()
    term.setCursorPos(1, 1)
end

wipe()

local lib = {
    size = {term.getSize()},
    pos = {term.getCursorPos()},
    objects = {},
    bk = {},
    txtColor = term.getTextColor(),
    bkColor = term.getBackgroundColor()
}

for i = 1, size[1] do
    lib.bk[i] = {}
    for j = 1, size[2] do
        lib.bk[i][j] = {txt = " ", txtColor = lib.txtColor, bkColor = lib.bkColor}
    end
end

function lib:getBackground()
    local t
    t = {
        clearLine = function()
            local row = self.pos[2]
            for i = 1, self.size[1] do
                self.bk[i][row] = {txt = " ", txtColor = self.txtColor, bkColor = self.bkColor}
            end
            self:redraw()
        end,
        clear = function()
            for i = 1, self.size[1] do
                for j = 1, self.size[2] do
                    self.bk[i][j] = {txt = " ", txtColor = self.txtColor, bkColor = self.bkColor}
                end
            end
            self:redraw()
        end,
        
