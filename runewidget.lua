-- Copyright (c) 2022, rjt
-- All rights reserved.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:

--     * Redistributions of source code must retain the above copyright
--     notice, this list of conditions and the following disclaimer.
--     * Redistributions in binary form must reproduce the above copyright
--     notice, this list of conditions and the following disclaimer in the
--     documentation and/or other materials provided with the distribution.
--     * Neither the name of Rune Widget nor the
--     names of its contributors may be used to endorse or promote products
--     derived from this software without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--[[
    Rune Widget

    on-screen clickable rune enchantments.
]]

_addon.name = "Rune Widget"
_addon.author = "rjt"
_addon.version = "1.0"
_addon.commands = { "rune", "rh" }

config = require('config')
images = require('images')
require('table')

defaults = {
    orient = 'v',

    pos_x = -100,
    pos_y = -100,

    textmode = false,
    resist_colour = true
}
settings = config.load(defaults)

rune_enchantment = T {
    ignis = { element = 'fire', resist = 'ice' },
    gelus = { element = 'ice', resist = 'wind' },
    flabra = { element = 'wind', resist = 'stone' },
    tellus = { element = 'stone', resist = 'thunder' },
    sulpor = { element = 'thunder', resist = 'water' },
    unda = { element = 'water', resist = 'fire' },
    lux = { element = 'light', resist = 'dark' },
    tenebrae = { element = 'dark', resist = 'light' }
}

element_colour = {
    fire = 'f54242',
    ice = '42d1f5',
    wind = '22c928',
    stone = 'c4c922',
    thunder = 'c922b3',
    water = '2b22c9',
    light = 'dfe6e5',
    dark = '292929'
}

do
    local rune_base = {
        color = { alpha = 255 },
        texture = { fit = false },
        draggable = false
    }
    local drag_base = {
        color = { alpha = 255 },
        texture = { fit = false },
        draggable = false
    }
    rune_image = T { ignis, gelus, flabra, tellus, sulpor, unda, lux, tenebrae }
    rune_image.ignis = images.new(rune_base)
    rune_image.gelus = images.new(rune_base)
    rune_image.flabra = images.new(rune_base)
    rune_image.tellus = images.new(rune_base)
    rune_image.sulpor = images.new(rune_base)
    rune_image.unda = images.new(rune_base)
    rune_image.lux = images.new(rune_base)
    rune_image.tenebrae = images.new(rune_base)
    drag_image = images.new(drag_base)
end
