--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:5a145ee3d0230d69d6e5773f58ca84d0:991a47bafc1dbd8beeb2953e44b041ff:1b77c032a98ad8366fbf6ce230f745d4$
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
            -- 48_0
            x=647,
            y=1,
            width=128,
            height=155,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 140,
            sourceHeight = 159
        },
        {
            -- 48_1
            x=777,
            y=1,
            width=124,
            height=159,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 140,
            sourceHeight = 159
        },
        {
            -- 48_2
            x=515,
            y=1,
            width=130,
            height=151,

            sourceX = 5,
            sourceY = 7,
            sourceWidth = 140,
            sourceHeight = 159
        },
        {
            -- 48_3
            x=235,
            y=1,
            width=136,
            height=137,

            sourceX = 2,
            sourceY = 8,
            sourceWidth = 140,
            sourceHeight = 159
        },
        {
            -- 48_4
            x=373,
            y=1,
            width=140,
            height=143,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 140,
            sourceHeight = 159
        },
        {
            -- 48_5
            x=1,
            y=1,
            width=118,
            height=115,

            sourceX = 16,
            sourceY = 23,
            sourceWidth = 140,
            sourceHeight = 159
        },
        {
            -- 48_6
            x=121,
            y=1,
            width=112,
            height=121,

            sourceX = 15,
            sourceY = 14,
            sourceWidth = 140,
            sourceHeight = 159
        },
    },
    
    sheetContentWidth = 902,
    sheetContentHeight = 161
}

SheetInfo.sequenceData = {
                name = "pkmnSummon", 
                start = 1, 
                count = 7, 
                time = 500,
                loopCount = 1
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getSequence()
    return self.sequenceData;
end

return SheetInfo
