sub Init()
    m.top.functionName = "GetContentObject"
end sub

sub GetContentObject()
    Value = CreateObject("roURLTransfer")
    Value.SetCertificatesFile("common:/certs/ca-bundle.crt")
    Value.SetURL("https://hosttec.online/rokuxml/achei/achei.json")
    data = Value.GetToString()
    dataChildren = []
    rows = {}

    m.json = ParseJson(data)
    if m.json <> invalid
        homeRowIndex = 0
        for each category in m.json.categories
                    row = {}
                    row.title = category.name
                    row.children = []
                  
            videos = OnVideos(category.playlistName)

                    for each item in videos 
                        itemVal = GetItem(item)
                        row.children.Push(itemVal)
                    end for
                    dataChildren.Push(row)
        end for
       
        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: dataChildren
        }, true)
        m.top.content = contentNode
    end if
end sub

function GetItem(video as Object) as Object
    item = {}    
    item.description = video.shortDescription    
    item.hdPosterURL = video.thumbnail
    item.title = video.title
    item.genre = video.genres[0]
    item.releaseDate = video.releaseDate
    item.id = video.id
    if video.content <> invalid
        item.quality = video.content.videos[0].quality
        item.length = video.content.duration
        item.url = video.content.videos[0].url
        item.streamFormat = video.content.videos[0].videoType
    end if
    return item
end function


' function to get all the videos in the category
function OnVideos(name as Object) as object
	videos = []
    itemIds=[]
    for each playlistObject in m.json.playlists
        if playlistObject.name = name
            itemIds.Push(playlistObject.itemIds)
		end if	
    end for 
	
    for each id in itemIds[0]
		for each tvSpecialObject in m.json.tvSpecials
            if tvSpecialObject.id = id
                videos.Push(tvSpecialObject)
            end if	
        end for 
		
	end for	
	return videos
end function