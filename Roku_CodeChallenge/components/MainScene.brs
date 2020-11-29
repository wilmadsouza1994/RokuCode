
sub Init()
    ' m.top.backgroundColor = "0x662D91"
    m.top.backgroundUri= "pkg:/images/customOverlay.jpg"
    m.loadingIndicator = m.top.FindNode("loadingIndicator") 
    InitStack()
    ShowGridScene()
    GetContentTask() 
end sub

function OnkeyPress(key as String, press as Boolean) as Boolean
    result = false
    if press
        if key = "back"
            numberOfScreens = m.screenStack.Count()
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true
            end if
        end if
    end if
    return result
end function
