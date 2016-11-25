--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:577f2b6f3d9b63fdb2de5c1367930f01:90a80bd5ff08274c2dd8993ae42a4927:e27610e3050fa80deb9a080b7dff897f$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 00
            x=127,
            y=1,
            width=48,
            height=107,

        },
        {
            -- 01
            x=62,
            y=1,
            width=63,
            height=108,

        },
        {
            -- 02
            x=1,
            y=1,
            width=59,
            height=116,

        },
        {
            -- 03
            x=177,
            y=1,
            width=79,
            height=88,

        },
    },
    
    sheetContentWidth = 257,
    sheetContentHeight = 118
}

SheetInfo.sequenceData = {
                name = "throw", 
                start = 1, 
                count = 4, 
                time = 1000,
                loopCount = 1
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getSequence()
    return self.sequenceData;
end

return SheetInfo
