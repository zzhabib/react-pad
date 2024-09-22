local MenuContext = require(script.Parent.MenuContext)
local React = require(script.Parent.React)

local e = React.createElement

local MenuProvider = function(props)
    local items, setItems = React.useState({})
    local selectedItem, setSelectedItem = React.useState((nil :: any) :: GuiButton)
    
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