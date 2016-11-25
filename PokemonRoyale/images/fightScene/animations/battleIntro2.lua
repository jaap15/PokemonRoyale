--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:94ac9d0cf1b19513f22bfaf5457bf93f:630d380375606334b91f099d3e3c3c79:d1d3d4e50433230e00640e8008c607b4$
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
            -- areahit_0
            x=1513,
            y=338,
            width=394,
            height=369,

            sourceX = 38,
            sourceY = 76,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_1
            x=1331,
            y=709,
            width=486,
            height=503,

        },
        {
            -- areahit_2
            x=851,
            y=677,
            width=478,
            height=495,

            sourceX = 5,
            sourceY = 4,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_3
            x=397,
            y=677,
            width=452,
            height=467,

            sourceX = 16,
            sourceY = 20,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_4
            x=1,
            y=673,
            width=394,
            height=395,

            sourceX = 34,
            sourceY = 59,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_5
            x=1429,
            y=1,
            width=372,
            height=335,

            sourceX = 34,
            sourceY = 84,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_6
            x=761,
            y=338,
            width=372,
            height=337,

            sourceX = 45,
            sourceY = 82,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_7
            x=1135,
            y=338,
            width=376,
            height=337,

            sourceX = 45,
            sourceY = 82,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_8
            x=1,
            y=318,
            width=382,
            height=335,

            sourceX = 37,
            sourceY = 84,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_9
            x=385,
            y=336,
            width=374,
            height=335,

            sourceX = 36,
            sourceY = 83,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_10
            x=1039,
            y=1,
            width=388,
            height=335,

            sourceX = 29,
            sourceY = 83,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_11
            x=653,
            y=1,
            width=384,
            height=333,

            sourceX = 31,
            sourceY = 84,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_12
            x=409,
            y=1,
            width=242,
            height=327,

            sourceX = 100,
            sourceY = 87,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_13
            x=187,
            y=1,
            width=220,
            height=315,

            sourceX = 113,
            sourceY = 86,
            sourceWidth = 486,
            sourceHeight = 503
        },
        {
            -- areahit_14
            x=1,
            y=1,
            width=184,
            height=215,

            sourceX = 123,
            sourceY = 83,
            sourceWidth = 486,
            sourceHeight = 503
        },
    },
    
    sheetContentWidth = 1908,
    sheetContentHeight = 1213
}

SheetInfo.sequenceData = {
                name = "battleIntro2", 
                start = 1, 
                count = 15, 
                time = 1900,
                loopCoun = 1
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getSequence()
    return self.sequenceData;
end


return SheetInfo
