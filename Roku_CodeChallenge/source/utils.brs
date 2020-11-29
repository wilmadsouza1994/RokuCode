function ContentListNode(contentList as Object, nodeType = "ContentNode" as String) as Object
    result = CreateObject("roSGNode", nodeType) 
    if result <> invalid       
        for each itemAA in contentList
            item = CreateObject("roSGNode", nodeType)
            item.SetFields(itemAA)
            result.AppendChild(item) 
        end for
    end if
    return result
end function

function FindNodeById(content as Object, contentId as String) as Object
    for each element in content.GetChildren(-1, 0)
        if element.id = contentId
            return element
        else if element.getChildCount() > 0
            result = FindNodeById(element, contentId)
            if result <> invalid
                return result
            end if
        end if
    end for
    return invalid
end function

' function CloneChildren(node as Object, startItem = 0 as Integer)
'     numOfChildren = node.GetChildCount() 
'     children = node.GetChildren(numOfChildren - startItem, startItem)
'     childrenClone = [] 
'     for each child in children  
'         childrenClone.Push(child.Clone(false))
'     end for
'     return childrenClone
' end function