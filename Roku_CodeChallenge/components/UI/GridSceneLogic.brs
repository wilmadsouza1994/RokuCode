
sub ShowGridScene()
    m.GridScene = CreateObject("roSGNode", "GridScene")
    m.GridScene.ObserveField("rowItemSelected", "GridSceneItemSelected")
    ShowScreen(m.GridScene) 
end sub

sub GridSceneItemSelected(event as Object) 
    grid = event.GetRoSGNode()    
    m.selectedIndex = event.GetData()   
    rowContent = grid.content.GetChild(m.selectedIndex[0])
    ? "content ="; rowContent
    ShowDetailsScreen(rowContent, m.selectedIndex[1])
end sub