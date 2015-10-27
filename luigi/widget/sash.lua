local Widget = require((...):gsub('%.[^.]*$', ''))

local Sash = Widget:extend()

Sash:onPressDrag(function (event)
    local self = event.target
    local axis = self.parent.flow
    if axis == 'x' then
        dimension = 'width'
    else
        axis = 'y'
        dimension = 'height'
    end
    local prevSibling = self:getPrevious()
    local nextSibling = self:getNext()
    local prevSize = prevSibling and prevSibling[dimension]
    local nextSize = nextSibling and nextSibling[dimension]
    if prevSize then
        prevSibling:setDimension(dimension,
                event[axis] - prevSibling:calculatePosition(axis))
    end
    if nextSize then
        nextSibling:setDimension(dimension,
                nextSibling:calculatePosition(axis) +
                nextSibling[dimension] - event[axis])
    end

    prevSibling:reflow()
    nextSibling:reflow()
    self:reflow()
end)

return Sash
