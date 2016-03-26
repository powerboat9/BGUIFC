os.loadAPI("BGUIFC/Lib/advancedTime")

function newButton(border, x, y, txt, onColor, offColor, toggle, textColor, onClick, timeToStayOn)
    txt = ((txt ~= "") and txt) or " "
    border = border or 1
    local topLeftX, topLeftY, bottomRightX, bottomRightY = x - border, y - border, x + (#txt - 1) + border, y + border
    local returnObj = {
        ["data"] = {
            ["disabled"] = false,
            ["x"] = x,
            ["y"] = y,
            ["state"] = false,
            ["toggle"] = toggle,
            ["txt"] = txt,
            ["txtColor"] = textColor,
            ["topLeftX"] = topLeftX,
            ["topLeftY"] = topLeftY,
            ["bottomRightX"] = bottomRightX,
            ["bottomRightY"] = bottomRightY,
            ["onClick"] = onClick,
            ["onColor"] = onColor,
            ["offColor"] = offColor,
            ["update"] = function(self)
                if (not self.data.toggle) and ((self.data.timeLastOn + self.data.timeToStayOn) < advancedTime.getEpochTime()) then
                    self.data.state = false
                end
            end,
            ["timeLastOn"] = 0
        }
    }
    returnObj.click = function(self, x, y)
        if (x >= topLeftX) and (x <= bottomRightX) and (y >= topLeftY) and (y <= bottomRightY) then
            if not self.data.disabled then
                if self.data.toggle then
                    self.data.state = not self.data.state
                elseif not self.data.state then
                    self.data.state = true
                    self.data.timeLastOn = advancedTime.getEpochTime()
                    self.data.onClick(self)
                end
            end
        end
    end
    returnObj.getPixelAt = function(self, xPos, yPos)
        if (xPos >= topLeftX) and (xPos <= bottomRightX) and (yPos >= topLeftY) and (yPos <= bottomRightY) then
            local bkColor = (self.data.state and self.data.onColor) or self.data.offColor
            local txtColor = self.data.txtColor --TODO: add support for txt color based on state
            local char = " "
            if (y == yPos) and (xPos >= x) and (xPos <= (x + (#(self.data.txt) - 1))) then
                char = (self.data.txt):sub(xPos - self.data.x + 1, xPos - self.data + 1)
            end
            return char, txtColor, bkColor
        end
    end
            
