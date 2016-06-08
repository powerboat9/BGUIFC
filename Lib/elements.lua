local function wipe()
    term.clear()
    term.setCursorPos(1, 1)
end

wipe()

local lib = {
    size = {term.getSize()},
    pos = {term.getCursorPos()},
    objects = {},
    bk = {}
}

for i = 1, size[1] do
    lib.bk[i] = {}
    for j = 1, size[2] do
        lib.bk[i][j] = {txt = " ", txtColor = term.getTextColor(), bkColor = term.getBackgroundColor()}
    end
end

function lib:getBackground()
    return {
