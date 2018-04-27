var x=document.getElementByTagName("Title");
var format=x.toUpperCase()
var size=1
for (i=0;i<x.length;i++){ //go through the message, letter by letter
    document.write(format.charAt(i).fontsize(size).bold())
    if (size<3)
        size++
    else
        size=1
}
