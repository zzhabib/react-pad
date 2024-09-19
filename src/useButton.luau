local MenuContext = require(script.Parent.MenuContext)
local React = require(script.Parent.React)

function useButton()
    local buttonRef = React.useRef(nil :: any)
    local context = React.useContext(MenuContext)

    -- print(context)

    React.useEffect(function()
        context.setItems(function(items)
            local itemsClone = table.clone(items)
            table.insert(itemsClone, buttonRef)
            return itemsClone
        end)
    end, {})

    return buttonRef
end

return useButton