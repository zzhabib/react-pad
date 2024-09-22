local ContextActionService = game:GetService("ContextActionService")

local MenuContext = require(script.Parent.MenuContext)
local React = require(script.Parent.React)

local e = React.createElement

local function findNeighbor(selectedButton: GuiButton?, buttons: {GuiButton}, direction: "left" | "right" | "up" | "down"): GuiButton?
    if not selectedButton then
        for button in buttons do
            return button
        end
        return nil
    end

    local selectedPos = selectedButton.AbsolutePosition
    local selectedSize = selectedButton.AbsoluteSize

    local nearestButton = nil
    local nearestDistance = math.huge

    for _, button in ipairs(buttons) do
        if button ~= selectedButton then
            local buttonPos = button.AbsolutePosition
            local buttonSize = button.AbsoluteSize
            local distance = math.huge

            if direction == "left" and buttonPos.X + buttonSize.X < selectedPos.X then
                distance = selectedPos.X - (buttonPos.X + buttonSize.X)
            elseif direction == "right" and buttonPos.X > selectedPos.X + selectedSize.X then
                distance = buttonPos.X - (selectedPos.X + selectedSize.X)
            elseif direction == "up" and buttonPos.Y + buttonSize.Y < selectedPos.Y then
                distance = selectedPos.Y - (buttonPos.Y + buttonSize.Y)
            elseif direction == "down" and buttonPos.Y > selectedPos.Y + selectedSize.Y then
                distance = buttonPos.Y - (selectedPos.Y + selectedSize.Y)
            end

            if distance < nearestDistance then
                nearestDistance = distance
                nearestButton = button
            end
        end
    end

    return nearestButton
end

local MenuProvider = function(props)
    local items, setItems = React.useState({})
    local selectedItem, setSelectedItem = React.useState((nil :: any) :: GuiButton)

    React.useEffect(function()
        local handleAction = function(actionName: "left" | "right" | "up" | "down", inputState: Enum.UserInputState, inputObject: InputObject)
            if inputState == Enum.UserInputState.Begin then
                local nextSelection = findNeighbor(selectedItem, items, actionName)
                print(nextSelection)
                if nextSelection then
                    setSelectedItem(nextSelection)
                end
            end
        end

        ContextActionService:BindAction("left", handleAction, false, Enum.KeyCode.A)
        ContextActionService:BindAction("right", handleAction, false, Enum.KeyCode.D)
        ContextActionService:BindAction("up", handleAction, false, Enum.KeyCode.W)
        ContextActionService:BindAction("down", handleAction, false, Enum.KeyCode.S)

        return function()
            ContextActionService:UnbindAction("left")
            ContextActionService:UnbindAction("right")
            ContextActionService:UnbindAction("up")
            ContextActionService:UnbindAction("down")
        end
    end, {items, selectedItem})
    
    return e(MenuContext.Provider, {
        value = {
            items = items,
            setItems = setItems,
            selectedItem = selectedItem,
            setSelectedItem = setSelectedItem,
        }
    }, props.children)
end

return MenuProvider