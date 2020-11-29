function MediaTypes() as Object 
    return {       
        "movie": "movies"
        "shortFormVideo": "shortFormVideos"
    }
end function

sub OnDeepLinking(event as Object)  
    
    args = event.getData()
    ? "OnDeepLinking"; args
    if args <> invalid and OnDeepLinkValidation(args) 
        DeepLink(m.GridScene.content, args.mediaType, args.contentId) 
    end if
end sub

' check if deep link arguments are valid
function OnDeepLinkValidation(args as Object) as Boolean
   mediaType = args.mediaType
   contentId = args.contentId
   types = MediaTypes()
   return mediaType <> invalid and contentId <> invalid and types[mediaType] <> invalid
end function

' Perform deep linking
sub DeepLink(content as Object, mediaType as String, contentId as String)
    ? "DeepLink"; content
    playableItem = FindNodeById(content, contentId) 
    types = MediaTypes()  
    if playableItem <> invalid
        ? "playableItem"; playableItem
        OnClearScreen() 
        if  mediaType = "shortFormVideo" or mediaType = "movie"
            PlayableMediaTypes(playableItem)      
        end if
    end if
end sub


sub PlayableMediaTypes(content as Object)
    ? "PlayableMediaTypes"; content
    OnDetailsScreen(content)   
end sub



sub OnDetailsScreen(content as Object)   
    m.deepLinkDetailsScreen = CreateObject("roSGNode", "DetailScreen")
    m.deepLinkDetailsScreen.content = content
    m.deepLinkDetailsScreen.ObserveField("visible", "OnDetailsScreenVisibility")
    m.deepLinkDetailsScreen.ObserveField("buttonSelected", "OnDetailsScreenButton")
    ShowScreen(m.deepLinkDetailsScreen) ' 
end sub

sub OnDetailsScreenVisibility(event as Object) ' invoked when DetailsScreen or EpisodesScreen "visible" field is changed
    visible = event.GetData()
    screen = event.GetRoSGNode()
    if visible = false and IsScreenInStack(screen) = false
        content = screen.content
        if content <> invalid
            ' jump to appropriate tile on GridScreen
            m.GridScene.RowItem = [content.homeRowIndex, content.homeItemIndex]
            ' Invalidate deepLinkDetailsScreen if user press "Back" button on DetailsScreen
            if m.deepLinkDetailsScreen <> invalid
                m.deepLinkDetailsScreen = invalid
            end if
        end if
    end if
end sub
sub buttonSelectedOnDeeplink(event as object)
    selectedIndex = event.GetData()
    details = event.GetRoSGNode()
    content = m.deepLinkDetailsScreen.content
    if selectedIndex[1] = 0  
        content.bookmarkPosition = 0
        ShowVideo(content, 0) 
    end if
end sub

' sub OnDetailsScreenButton(event as Object) 
'     buttonIndex = event.getData() 
'     details = event.GetRoSGNode()
'     button = details.buttons.getChild(buttonIndex)
'     content = m.deepLinkDetailsScreen.content.clone(true)
   
'     if button.id = "Watch Now"
'         content.bookmarkPosition = 0
'         ShowVideo(content, 0) 
'     end if
  
' end sub
sub OnDetailsScreenButton(event) 
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