local MenuContext = require(script.Parent.MenuContext)
local React = require(script.Parent.React)

local e = React.createElement

local MenuProvider = function(props)
    local items, setItems = React.useState({})

    print(`There are {#items} buttons rendered`)
    
    return e(MenuContext.Provider, {
        value = {
            items = items,
            setItems = setItems,
        }
    }, props.children)
end

return MenuProvider