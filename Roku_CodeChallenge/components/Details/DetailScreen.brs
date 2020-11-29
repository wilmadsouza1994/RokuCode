function Init()
    m.top.ObserveField("visible", "OnVisiblity") 
    m.top.ObserveField("OnitemFocus", "OnFocus")   
    m.buttons = m.top.FindNode("buttons") 
    m.thumbnail = m.top.FindNode("thumbnail")
    m.description = m.top.FindNode("description")   
    m.title = m.top.FindNode("title") 
end function

sub onVisiblity()
    if m.top.visible = true
        m.buttons.SetFocus(true)
        m.top.OnitemFocus = m.top.jumpToItem
    end if
end sub

sub Buttons(buttonsgroup as Object)
    result = []
    for each button in buttonsgroup
        result.push({title : button})
    end for
    m.buttons.content = ContentListNode(result) ' populate buttons list
end sub

sub OnContentChange(event as Object)
    content = event.getData()
    if content <> invalid
        m.isContentList = content.GetChildCount() > 0
        if m.isContentList = false
            OnContent(content)
            m.buttons.SetFocus(true)
        end if
    end if
end sub

sub OnContent(content as Object)   
    m.description.text = content.description
    m.thumbnail.uri = content.hdPosterURL  
    m.title.text = content.title
    Buttons(["Watch Now", "Add to watchlist"]) 
end sub

sub OnItem() 
    content = m.top.content
    if content <> invalid and m.top.Item >= 0 and content.GetChildCount() > m.top.Item
        m.top.OnitemFocus = m.top.Item
    end if
end sub

sub OnFocus(event as Object)
    focusedItem = event.GetData()
    content = m.top.content.GetChild(focusedItem) 
    OnContent(content)
end sub


function OnkeyPress(key as String, press as Boolean) as Boolean
    result = false
    if press
        currentItem = m.top.OnitemFocus      
        if key = "left" and m.isContentList = true           
            m.top.changeToItem = currentItem - 1
            result = true        
        else if key = "right" and m.isContentList = true        
            m.top.changeToItem = currentItem + 1
            result = true
        end if
    end if
    return result
end function