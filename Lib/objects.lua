os.loadAPI("BGUIFC/Lib/advancedTime")

function newButton(topLeftX, topLeftY, bottomRightX, bottomRightY, onColor, offColor, toggle, txt, textColor, onClick, timeToStayOn)
    local returnObj = {
        ["data"] = {
            ["state"] = false,
            ["toggle"] = toggle,
            ["txt"] = txt,
            ["txtColor"] = textColor,
            ["topLeftX"] = topLeftX,
            ["topLeftY"] = topLeftY,
            ["bottomRightX"] = bottomRightX,
            ["bottomRightY"] = bottomRightY,
            ["onClick"] = function(self)
                if self.data.toggle or (not self.data.state) then
                    if onClick(self) then
                        if toggle then
                            self.data.state = (not self.data.state)
                        else
                            self.data.state = true
                            self.data.timeLastOn = advancedTime.getEpochTime()
                        end
                    end
                end
            end,
            ["onColor"] = onColor,
            ["offColor"] = offColor,
            ["update"] = function(self)
                if (not toggle) and (((self.data.timeLastOn + timeToStayOn) < advancedTime.getEpochTime()) or (self.data.timeLastOn == -1) then
                    self.data.state = false
                end
            end,
            ["timeLastOn"] = -1
        }
    }
    returnObj.click = function(self, x, y)
        if (x >= topLeftX) and (x <= bottomRightX) and (y >= topLeftY) and (y <= bottomRightY) then
            self.data.onClick(self)
        end
    end
    returnObj.getPixelAt = function(self, x, y)
        local char = {}
        if (x >= topLeftX) and (x <= bottomRightX) and (y >= topLeftY) and (y <= bottomRightY) then
            local bkColor = (self.state and self. onColor) or self.offColor
            
