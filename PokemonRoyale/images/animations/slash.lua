--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c4141cf53f5e0f688870fce569c19d53:ae09019d354b601a85e356934bb0951c:5d4f3090b27dc47ca75af72ea1a41fe3$
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
            -- 0_0
            x=365,
            y=136,
            width=62,
            height=39,

            sourceX = 291,
            sourceY = 37,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_1
            x=365,
            y=1,
            width=102,
            height=133,

            sourceX = 247,
            sourceY = 3,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_2
            x=1,
            y=427,
            width=190,
            height=149,

            sourceX = 169,
            sourceY = 0,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_3
            x=241,
            y=234,
            width=200,
            height=129,

            sourceX = 166,
            sourceY = 7,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_4
            x=241,
            y=365,
            width=208,
            height=117,

            sourceX = 162,
            sourceY = 6,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_5
            x=193,
            y=484,
            width=212,
            height=117,

            sourceX = 162,
            sourceY = 7,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_6
            x=1,
            y=1,
            width=362,
            height=231,

            sourceX = 0,
            sourceY = 28,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_7
            x=1,
            y=234,
            width=238,
            height=191,

            sourceX = 10,
            sourceY = 67,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_8
            x=1,
            y=578,
            width=170,
            height=161,

            sourceX = 33,
            sourceY = 86,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_9
            x=173,
            y=603,
            width=122,
            height=129,

            sourceX = 76,
            sourceY = 90,
            sourceWidth = 374,
            sourceHeight = 259
        },
        {
            -- 0_10
            x=297,
            y=603,
            width=112,
            height=121,

            sourceX = 77,
            sourceY = 93,
            sourceWidth = 374,
            sourceHeight = 259
        },
    },
    
    sheetContentWidth = 468,
    sheetContentHeight = 740
}

SheetInfo.sequenceData = {
                name = "slash", 
                start = 1, 
                count = 10, 
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
