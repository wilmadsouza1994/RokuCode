
sub Main(args as Object)
    ShowChannel(args)
end sub

sub ShowChannel(args as Object)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.Show() 
    scene.launchArgs = args
    inputObject=createobject("roInput")
    inputObject.setmessageport(m.port)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        ?"msgTyp="msgType
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return
        else if msgType = "roInputEvent"
            inputData = msg.getInfo()
            ? "input"
            ' pass the deeplink to UI
            if inputData.DoesExist("mediaType") and inputData.DoesExist("contentId")
                deeplink = {
                    contentId: inputData.contentID
                    mediaType: inputData.mediaType
                }             
                scene.inputArgs = deeplink
            end if
        end if
    end while
end sub
