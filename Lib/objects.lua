function newButton(topLeftX, topLeftY, bottomRightX, bottomRightY, onColor, offColor, toggle, txt, onClick)
    local returnObj = {
        ["data"] = {
            ["state"] = false,
            ["toggle"] = toggle,
            ["topLeftX"] = topLeftX,
            ["topLeftY"] = topLeftY,
            ["bottomRightX"] = bottomRightX,
            ["bottomRightY"] = bottomRightY,
            ["onClick"] = onClick,
            ["update"] = function(self)
                self
            ["timeLastOn"] = 
        }
    }
    returnObj.click = function(self, x, y)
        if (x >= topLeftX) and (x <= bottomRightX) and (y >= topLeftY) and (y <= bottomRightY) then
            self.data.onClick(self)
            
