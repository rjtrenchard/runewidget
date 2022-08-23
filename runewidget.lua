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
require('tables')

defaults = {
    orient = 'v',

    pos_x = 100,
    pos_y = 100,

    size = 32, -- pixel size
    spacing = 3, -- spacing between icons in px

    textmode = false,
    resist_colour = true
}
settings = config.load(defaults)

rune_enchantment = T {
    ignis = { element = 'fire', resist = 'ice' },
    gelus = { element = 'ice', resist = 'wind' },
    flabra = { element = 'wind', resist = 'earth' },
    tellus = { element = 'earth', resist = 'lightning' },
    sulpor = { element = 'lightning', resist = 'water' },
    unda = { element = 'water', resist = 'fire' },
    lux = { element = 'light', resist = 'dark' },
    tenebrae = { element = 'dark', resist = 'light' }
}

orientation = {}
if settings.orient == 'v' then
    orientation.x = 0
    orientation.y = 1
else
    orientation.x = 1
    orientation.y = 0
end

-- element_colour = T {
--     fire = { r = 245, g = 66, b = 66 },
--     ice = { r = 66, g = 209, b = 245 },
--     wind = { r = 34, g = 201, b = 40 },
--     earth = { r = 196, g = 201, b = 34 },
--     lightning = { r = 201, g = 34, b = 179 },
--     water = { r = 43, g = 34, b = 201 },
--     light = { r = 223, g = 230, b = 229 },
--     dark = { r = 41, g = 41, b = 41 }
-- }

element_image = T {}
element_image.fire = windower.addon_path .. '/img/Fire-Icon.png'
element_image.ice = windower.addon_path .. '/img/Ice-Icon.png'
element_image.wind = windower.addon_path .. '/img/Wind-Icon.png'
element_image.earth = windower.addon_path .. '/img/Earth-Icon.png'
element_image.lightning = windower.addon_path .. '/img/Lightning-Icon.png'
element_image.water = windower.addon_path .. '/img/Water-Icon.png'
element_image.light = windower.addon_path .. '/img/Light-Icon.png'
element_image.dark = windower.addon_path .. '/img/Dark-Icon.png'

rune_colour = T {}
if settings.resist_colour then
    for i, rune in ipairs(rune_enchantment) do
        windower.add_to_chat(144, rune)
        rune_colour[rune] = element_colour[rune_enchantment.resist]
    end
else
    for i, rune in ipairs(rune_enchantment) do
        rune_colour[rune] = element_colour[rune_enchantment.element]
    end
end

rune_image = T {}

do
    local rune_base = {
        color = { alpha = 255 },
        texture = { fit = false },
        draggable = false,
    }

    local drag_image = {
        color = { red = 100, blue = 100, green = 100, alpha = 50 },
        texture = { fit = true },
        draggable = true,

    }

    -- maybe use an array?
    local rune_names = { 'ignis', 'gelus', 'flabra', 'tellus', 'sulpor', 'unda', 'lux', 'tenebrae' }
    for i, rune in ipairs(rune_names) do
        rune_image:append(rune)

        rune_image[rune] = images.new(rune_base)

        rune_image[rune]:path(element_image[rune_enchantment[rune].element])
        -- rune_image[rune]:color(rune_colour[rune].r, rune_colour[rune].g, rune_colour[rune].b)
        rune_image[rune]:transparency(0)
        rune_image[rune]:size(settings.size, settings.size)
        rune_image[rune]:pos_x(settings.pos_x + orientation.x * i * (settings.size + settings.spacing))
        rune_image[rune]:pos_y(settings.pos_y + orientation.y * i * (settings.size + settings.spacing))
        rune_image[rune]:show()

    end
end
windower.register_event('mouse', function(type, x, y, delta, blocked)
    if blocked then return end

    if type == 1 then
        if check_hover(x, y) ~= 'none' then
            return true
        end
    elseif type == 2 then


        if check_hover(x, y) ~= 'none' then
            return true
        end
    end
    return false
end)

-- check if hovering over a rune
function check_hover(x, y)

    for k, v in ipairs(rune_image) do
        local begin_x = settings.pos_x + orientation.x * k * (settings.size + settings.spacing)
        local end_x = settings.pos_x + orientation.x * k * (settings.size + settings.spacing) + settings.size
        local begin_y = settings.pos_y + orientation.y * k * (settings.size + settings.spacing)
        local end_y = settings.pos_y + orientation.y * k * (settings.size + settings.spacing) + settings.size
        -- windower.add_to_chat(144, '(' .. begin_x .. ',' .. end_x .. '),(' .. begin_y .. ',' .. end_y .. ')')
        if x >= begin_x and x <= end_x and y >= begin_y and y <= end_y then
            return v
        end
    end
    return 'none'

end
