sub ShowDetailsScreen(content as object, selectedItem as integer)
    detailsScreen = CreateObject("roSGNode", "DetailScreen")
    ? "detailScreen ="; detailsScreen
    detailsScreen.content = content
    detailsScreen.Item = selectedItem
    detailsScreen.ObserveField("visible", "OnDetailsScreenVisibilityChanged")
    detailsScreen.ObserveField("buttonSelected", "OnDetailScreenButtonSelected")
    ShowScreen(detailsScreen)
end sub

sub OnDetailsScreenVisibilityChanged(event as Object) 
    visible = event.GetData()
    detailsScreen = event.GetRoSGNode()
    currentScreen = GetCurrentPage()
    screenType = currentScreen.SubType()
    if visible = false
        if screenType = "GridScene"         
            currentScreen.RowItem = [m.selectedIndex[0], detailsScreen.OnitemFocus]   
        end if   
    end if
end sub

sub OnDetailScreenButtonSelected(event) 
    details = event.GetRoSGNode()
    content = details.content
    buttonIndex = event.getData() 
    button = details.buttons.getChild(buttonIndex)
    selectedItem = details.OnitemFocus
    ? "button selected"; selectedItem;
    if buttonIndex = 0 
        ShowVideo(content, selectedItem)
    end if
end sub
