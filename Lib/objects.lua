os.loadAPI("BGUIFC/Lib/advancedTime")

function newButtonRaw(border, x, y, txt, onColor, offColor, toggle, textColorOn, textColorOff, onClick, timeToStayOn)
    txt = ((txt ~= "") and txt) or " "
    border = border or 1
    local topLeftX, topLeftY, bottomRightX, bottomRightY = x - border, y - border, x + (#txt - 1) + border, y + border
    local returnObj = {
        data = {
            border = border,
            disabled = false,
            x = x,
            y = y,
            state = false,
            toggle = toggle,
            txt = txt,
            txtColorOn = textColorOn,
            txtColorOff = textColorOff,
            topLeftX = topLeftX,
            topLeftY = topLeftY,
            bottomRightX = bottomRightX,
            bottomRightY = bottomRightY,
            onClick = onClick,
            onColor = onColor,
            offColor = offColor,
            timeToStayOn = timeToStayOn,
            onClick = onClick
        }
    }
    returnObj.update = function(self)
        if (not self.data.toggle) and self.data.timeLastOn and ((self.data.timeLastOn + self.data.timeToStayOn) < advancedTime.getEpochTime()) then
            self.data.state = false
            self.data.timeLastOn = nil
        end
    end
    returnObj.click = function(self, x, y)
        if (x >= topLeftX) and (x <= bottomRightX) and (y >= topLeftY) and (y <= bottomRightY) then
            if (not self.data.disabled) then
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
        if (xPos >= self.data.topLeftX) and (xPos <= self.data.bottomRightX) and (yPos >= self.data.topLeftY) and (yPos <= self.data.bottomRightY) then
            local bkColor = (self.data.state and self.data.onColor) or self.data.offColor
            local txtColor = self.data.txtColor --TODO: add support for txt color based on state
            local char = " "
            if (self.data.y == yPos) and (xPos >= self.data.x) and (xPos <= (self.data.x + (#(self.data.txt) - 1))) then
                char = (self.data.txt):sub(xPos - self.data.x + 1, xPos - self.data.x + 1)
            end
            return char, txtColor, bkColor
        end
    end
    return returnObj
end

function getMenue(x, y, title, titleColor, titleBkColor, onClickMenue, ...)
    local returnObj = {
        data = {
            title = {
                txt = title,
                txtColor = titleColor,
                bkColor = titleBkColor
            },
            state = false,
            items = {},
            x = x,
            y = y,
            onClickMenu = onClickMenue
        }
    }
    local maxSize = #title
    for k, v in ipairs(args) do
        local index = (k - (k % 3)) / 3
        if k - (index * 3) == 0 then
            if #v > maxSize then
                maxSize = #v
            end
            returnObj.data.items[index + 1].txt = v
        elseif k - (index * 3) == 1 then
            returnObj.data.items[index + 1].txtColor = v
        else
            returnObj.data.items[index + 1].bkColor = v
        end
    end
    returnObj.data.size = maxSize
    returnObj.click = function(self, xPos, yPos)
        local layers = 1 + ((self.data.state and #(self.data.items)) or 0)
        if (xPos >= self.data.x) and (xPos <= (self.data.x + self.data.size)) and (yPos >= self.data.y) and (yPos <= (self.data.y + layers - 1)) then
            local layer = yPos - self.data.y + 1
            if layer == 1 then
                self.data.state = not self.data.state
            else
                self.data.onClickMenu(self.data.items[layer - 1])
            end
        end
    end
    returnObj.getPixelAt(self, xPos, yPos)
        local length = (self.data.state and (1 + #(self.data.items))) or 1
        if (xPos >= self.data.x) and (xPos <= (self.data.x - 1 + self.data.size)) and (yPos >= self.data.y) and (yPos <= (self.data.y - 1 + length)) then
            local layer = yPos - self.data.y + 1
            local index = xPos - self.data.x + 1
            if layer == 1 then
                return (self.data.title.txt):sub(index, index), self.data.title.txtColor, self.data.title.bkColor
            else
                local pixel = self.data.items[layer - 1]
                return (pixel.txt):sub(index, index), pixel.txtColor, pixel.bkColor
            end
        end
    end
end
