local React = require(script.Parent.React)

type SetState<T> = (T) -> () | ((T) -> T) -> T

type MenuContextValue = {
    items: {},
    setItems: SetState<{}>,
    selectedItem: GuiButton?,
    setSelectedItem: SetState<GuiButton>
}

local MenuContext = React.createContext({} :: MenuContextValue)

return MenuContext