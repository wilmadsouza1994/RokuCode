sub OnContent() 
    content = m.top.itemContent
    if content <> invalid 
        m.top.FindNode("poster").uri = content.hdPosterURL
        m.top.FindNode("title").text = content.title

    end if
end sub
