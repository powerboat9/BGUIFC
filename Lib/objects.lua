os.loadAPI("BGUIFC/Lib/advancedTime")

function newButton(topLeftX, topLeftY, bottomRightX, bottomRightY, onColor, offColor, toggle, txt, onClick, timeToStayOn)
    local returnObj = {
        ["data"] = {
            ["state"] = false,
            ["toggle"] = toggle,
            ["topLeftX"] = topLeftX,
            ["topLeftY"] = topLeftY,
            ["bottomRightX"] = bottomRightX,
            ["bottomRightY"] = bottomRightY,
            ["onClick"] = onClick,
            ["onColor"] = onColor,
            ["offColor"] = offColor,
            ["update"] = function(self)
                if (self.data.timeLastOn +
            ["timeLastOn"] = -1
        }
    }
    returnObj.click = function(self, x, y)
        if (x >= topLeftX) and (x <= bottomRightX) and (y >= topLeftY) and (y <= bottomRightY) then
            self.data.onClick(self)
            
