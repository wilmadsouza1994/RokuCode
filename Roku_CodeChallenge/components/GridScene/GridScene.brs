
sub Init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.top.ObserveField("visible", "OnVisible")
    m.thumbnail = m.top.FindNode("thumbnail")
    m.releaseDate = m.top.FindNode("releaseDate")
    m.genre = m.top.FindNode("genre")
    m.quality = m.top.FindNode("quality")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.rowList.ObserveField("rowItemFocused", "OnItemFocus")
end sub

sub OnVisible() 
    if m.top.visible = true
        m.rowList.SetFocus(true) 
    end if
end sub

sub OnItemFocus() 
    focusedIndex = m.rowList.rowItemFocused 
    row = m.rowList.content.GetChild(focusedIndex[0]) 
    item = row.GetChild(focusedIndex[1]) 
     m.thumbnail.uri = item.hdPosterURL
    m.descriptionLabel.text = item.description
    m.titleLabel.text = item.title
    m.quality.text = item.quality
    m.genre.text = item.genre
    m.releaseDate.text = left(item.releaseDate,10)
end sub
