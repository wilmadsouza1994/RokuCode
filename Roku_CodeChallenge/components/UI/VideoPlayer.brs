sub ShowVideo(content as Object, itemIndex as Integer)
     m.videoPlayer = CreateObject("roSGNode", "Video") 
    if itemIndex <> 0
        numOfChildren = content.GetChildCount() 
        children = content.GetChildren(numOfChildren - itemIndex, itemIndex)
        datachildren = []
       
        for each child in children
            datachildren.Push(child.Clone(false))
        end for
        
        node = CreateObject("roSGNode", "ContentNode")
        node.Update({ children: datachildren }, true)
        m.videoPlayer.content = node 
    else      
        m.videoPlayer.content = content.Clone(true)
    end if
    m.videoPlayer.contentIsPlaylist = true
    ShowScreen(m.videoPlayer)
    m.videoPlayer.control = "play"
    m.videoPlayer.ObserveField("state", "OnChangeState")
    m.videoPlayer.ObserveField("visible", "OnVideoVisiblity")
end sub

sub OnChangeState() 
    state = m.videoPlayer.state
    if state = "error" or state = "finished"
        CloseScreen(m.videoPlayer)
    end if
end sub

sub OnVideoVisiblity() 
    if m.videoPlayer.visible = false and m.top.visible = true
        currentIndex = m.videoPlayer.contentIndex
        m.videoPlayer.control = "stop" 
        m.videoPlayer.content = invalid
        m.GridScene.SetFocus(true)  
        screen=event.GetRoSGNode()
        content=screen.content
        if content <> invalid
        m.GridScene.RowItem = [content.homeRowIndex,currentIndex + content.homeItemIndex]   
    end if
end sub