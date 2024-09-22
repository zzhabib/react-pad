local MenuContext = require(script.Parent.MenuContext)
local React = require(script.Parent.React)

local dummyButton: GuiButton = Instance.new("TextButton")

function useButton()
    local indexRef = React.useRef(-1)
    local buttonRef = React.useRef(dummyButton)
    local context = React.useContext(MenuContext)

    local isSelected = context.selectedItem == buttonRef.current and context.selectedItem ~= nil

    React.useEffect(function()
        local button = buttonRef.current
        if button == dummyButton or button == nil then
            error("[ReactPad] Button was not found. Did you forget to use the button reference?")
        end

        context.setItems(function(items)
            indexRef.current = #items
            local itemsClone = table.clone(items)
            table.insert(itemsClone, buttonRef.current)
            return itemsClone
        end)

        local connections = {
            button.MouseEnter:Connect(function()
                context.setSelectedItem(button)
            end),
            button.MouseLeave:Connect(function()
                if context.selectedItem == button then
                    context.setSelectedItem(nil)
                end
            end)
        }

        return function()
            context.setItems(function(items)
                local itemsClone = table.clone(items)
                table.remove(itemsClone, indexRef.current)
                return itemsClone
            end)

            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
        end
    end, {context.selectedItem})

    return buttonRef, isSelected
end

return useButton