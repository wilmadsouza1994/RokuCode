
sub GetContentTask()
    m.contentTask = CreateObject("roSGNode", "LoaderTask") 
    m.contentTask.ObserveField("content", "OnLoad")
    m.contentTask.control = "run" 
    m.loadingIndicator.visible = true
    m.GridScene.visible = false
end sub

sub OnLoad() 
    m.GridScene.SetFocus(true)
    m.GridScene.visible = true
    m.loadingIndicator.visible = false 
    m.GridScene.content = m.contentTask.content 
    args = m.top.launchArgs
    if args <> invalid and OnDeepLinkValidation(args)
        DeepLink(m.contentTask.content, args.mediaType, args.contentId)
    end if
end sub