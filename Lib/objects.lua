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
    return returnObj
end

function getMenue(x, y, title, titleColor, titleBkColor, ...)
    local returnObj = {
        ["data"] = {
            ["title"] = {
                ["txt"] = title,
                ["txtColor"] = titleColor,
                ["bkColor"] = titleBkColor,
                ["state"] = false
            },
            ["items"] = {},
            ["x"] = x,
            ["y"] = y
        }
    }
    local maxSize = #title
    for _, v in ipairs(args) do
        if #v > maxSize then
            maxSize = #v
        end
    end
    returnObj.data.size = maxSize
    returnObj.click = function(self)
        self.data.state = not self.data.state
    end
    returnObj.getPixelAt(self, xPos, yPos)
        local length = (self.data.state and (1 + #(self.data.items))) or 1
        if (xPos >= self.data.x) and (xPos <= (self.data.x - 1 + self.data.size)) and (yPos >= self.data.y) and (yPos <= (self.data.y - 1 + length)) then
            local layer = yPos - y + 1
            
    
