
--[[
--New CampFire mod by Pavel Litvinoff
-- Copyright (C) 2017 Pavel Litvinoff <googolgl@gmail.com>
-- Forum Topic: New Campfire mod
-- <https://forum.minetest.net/viewtopic.php?f=9&t=16611>
--License of code : GPLv2.1

--[modified by Napiophelios]

----------------------
License of source code
----------------------
GNU Lesser General Public License, version 2.1
Copyright (C) 2011-2016 googol, Pavel Litvinoff <googolgl@gmail.com>

This program is free software; you can redistribute it and/or modify it under the terms
of the GNU Lesser General Public License as published by the Free Software Foundation;
either version 2.1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details:
https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
----------------------
--]]

-------------
--Variables
-------------
fireplace_cooking = 1;       -- nil - not cooked, 1 - cooked
fireplace_limit = 1;         -- nil - unlimited fireplace, 1 - limited
fireplace_ttl = 60;          -- Time in sec
fireplace_stick_time = fireplace_ttl/2;   -- How long does the stick increase. In sec.

fireplace = {}

-------------
--Functions
-------------
local function fire_particles_on(pos) -- 3 layers of fire
    local meta = minetest.get_meta(pos)
    local id = minetest.add_particlespawner({ -- 1 layer big particles fire
        amount = 9,
        time = 3,
        minpos = {x = pos.x - 0.125, y = pos.y-0.5, z = pos.z - 0.125},
        maxpos = {x = pos.x + 0.125, y = pos.y-0.1, z = pos.z + 0.125},
        minvel = {x= 0, y= 0, z= 0},
        maxvel = {x= 0, y= 0, z= 0},
        minacc = {x= 0, y= 0, z= 0},
        maxacc = {x= 0, y= 0, z= 0},
        minexptime = 0.75,
        maxexptime = 1.25,
        minsize = 5,
        maxsize = 7,
        collisiondetection = false,
        vertical = true,
        texture = "fire_basic_flame_animated.png",
        animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length = 1.15,},
         glow = 5,
    })
    meta:set_int("layer_1", id)

    local id = minetest.add_particlespawner({ -- 2 layer smol particles fire
        amount = 9,
        time = 1,
        minpos = {x = pos.x - 0.15, y = pos.y-0.5, z = pos.z - 0.15},
        maxpos = {x = pos.x + 0.15, y = pos.y-0.1, z = pos.z + 0.15},
        minvel = {x= 0, y= 0, z= 0},
        maxvel = {x= 0, y= 0, z= 0},
        minacc = {x= 0, y= 0, z= 0},
        maxacc = {x= 0, y= 0, z= 0},
        minexptime = 0.4,
        maxexptime = 1.1,
        minsize = 4,
        maxsize = 6,
        collisiondetection = false,
        vertical = true,
        texture = "fire_basic_flame_animated.png",
        animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length = 1.25,},
         glow = 5,
    })
    meta:set_int("layer_2", id)

     local image_number = math.random(4)
    local id = minetest.add_particlespawner({ --3 layer embers
        amount = 1,
        time = 0.5,
        minpos = {x = pos.x - 0.1, y = pos.y - 0.05, z = pos.z - 0.1},
        maxpos = {x = pos.x + 0.2, y = pos.y + 0.2, z = pos.z + 0.2},
        minvel = {x= 0, y= 0.25, z= 0},
        maxvel = {x= 0, y= 0.75, z= 0},
        minacc = {x= 0, y= 0, z= 0},
        maxacc = {x= 0, y= 0.025, z= 0},
        minexptime = 0.25,
        maxexptime = 0.5,
        minsize = 0.05,
        maxsize = 0.25,
        collisiondetection = true,
        glow = 3,
        texture = "seasonal_decor_fireplace_particle_"..image_number..".png",
    })
    meta:set_int("layer_3", id)
end

local function fire_particles_off(pos)
    local meta = minetest.get_meta(pos)
    local id_1 = meta:get_int("layer_1");
    local id_2 = meta:get_int("layer_2");
    local id_3 = meta:get_int("layer_3");
    minetest.delete_particlespawner(id_1)
    minetest.delete_particlespawner(id_2)
    minetest.delete_particlespawner(id_3)
end

local function indicator(maxVal, curVal)
    local percent_val = math.floor(curVal / maxVal * 100)
    local progress = ""
    local v = percent_val / 10
    for k=1,10 do
        if v > 0 then
            progress = progress.."¦"
        else
            progress = progress.."¦"
        end
        v = v - 1
    end
    return "\n"..progress.." "..percent_val.."%"
end

local function effect(pos, texture, vlc, acc, time, size)
    local id = minetest.add_particle({
        pos = pos,
        velocity = vlc,
        acceleration = acc,
        expirationtime = time,
        size = size,
        collisiondetection = true,
        vertical = true,
        texture = texture,
    })
end

local function infotext_edit(meta)
    local infotext = "Active fireplace"

    if fireplace_limit and fireplace_ttl > 0 then
        local it_val = meta:get_int("it_val");
        infotext = infotext..indicator(fireplace_ttl, it_val)
    end

    local cooked_time = meta:get_int('cooked_time');
    if fireplace_cooking and cooked_time ~= 0 then
        local cooked_cur_time = meta:get_int('cooked_cur_time');
        infotext = infotext.."\n".."Cooking"..indicator(cooked_time, cooked_cur_time)
    end

    meta:set_string('infotext', infotext)
end

local function cooking(pos, itemstack)
    local meta = minetest.get_meta(pos)
    local cooked, _ = minetest.get_craft_result({method = "cooking", width = 1, items = {itemstack}})
    local cookable = cooked.time ~= 0

    if cookable and fireplace_cooking then
        local eat_y = ItemStack(cooked.item:to_table().name):get_definition().on_use
        if string.find(minetest.serialize(eat_y), "do_item_eat") and meta:get_int("cooked_time") == 0 then
            meta:set_int('cooked_time', cooked.time);
            meta:set_int('cooked_cur_time', 0);
            local name = itemstack:to_table().name
            local texture = itemstack:get_definition().inventory_image

            infotext_edit(meta)

            effect(
                {x = pos.x, y = pos.y+0.4, z = pos.z},
                texture,
                {x=0, y=-1/cooked.time, z=0},
                {x=0, y=0, z=0},
                cooked.time/2,
                4
            )

            minetest.after(cooked.time/2, function()
                if meta:get_int("it_val") > 0 then
                    effect(
                        {x = pos.x, y = pos.y-0.1, z = pos.z},
                        texture,
                        {x=0, y=1/cooked.time, z=0},
                        {x=0, y=0, z=0},
                        cooked.time/2,
                        4
                    )

                    local item = cooked.item:to_table().name
                    minetest.after(cooked.time/2, function(item)
                        if meta:get_int("it_val") > 0 then
                            minetest.add_item({x=pos.x, y=pos.y+0.5, z=pos.z}, item)
                            meta:set_int('cooked_time', 0);
                            meta:set_int('cooked_cur_time', 0);
                        else
                            minetest.add_item({x=pos.x, y=pos.y+0.5, z=pos.z}, name)
                        end
                    end, item)
                else
                    minetest.add_item({x=pos.x, y=pos.y+0.5, z=pos.z}, name)
                end
            end)

            if not minetest.setting_getbool("creative_mode") then
                itemstack:take_item()
                return itemstack
            end
        end
    end
end

-----------
-- NODES
-----------
minetest.register_node('seasonal_decor:fireplace', {
    description = "Fireplace",
    drawtype = "nodebox",
    tiles = {
    'default_stone.png^seasonal_decor_fireplace_sides-overlay2.png',
    'default_stone.png^seasonal_decor_fireplace_sides-overlay2.png',
    'default_stone.png^seasonal_decor_fireplace_sides-overlay2.png',
    'default_stone.png^seasonal_decor_fireplace_sides-overlay2.png',
    'default_stone.png^seasonal_decor_fireplace_sides-overlay2.png',
    'default_stone.png^seasonal_decor_fireplace_front-overlay2.png'
    },
    inventory_image = '(default_stone.png^fire_basic_flame.png)^seasonal_decor_fireplace_front-overlay2.png',
--    wield_image = "",
    walkable = false,
    buildable_to = false,
    sunlight_propagates = true,
    groups = {dig_immediate=3},
    paramtype = "light",
    paramtype2 = "facedir",
    legacy_facedir_simple = true,
    is_ground_content = false,
    on_rotate = screwdriver.rotate_simple,
    node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, -0.3125, 0.3125, 0.375},
			{0.3125, -0.375, -0.375, 0.4375, 0.3125, 0.375},
			{-0.25, -0.375, -0.375, -0.1875, -0.0625, -0.3125},
			{-0.125, -0.375, -0.375, -0.0625, 0, -0.3125},
			{0.1875, -0.375, -0.375, 0.25, -0.0625, -0.3125},
			{0.0625, -0.375, -0.375, 0.125, 0, -0.3125},
			{-0.25, -0.375, 0.3125, -0.1875, -0.0625, 0.375},
			{-0.125, -0.375, 0.3125, -0.0625, 0, 0.375},
			{0.1875, -0.375, 0.3125, 0.25, -0.0625, 0.375},
			{0.0625, -0.375, 0.3125, 0.125, 0, 0.375},
			{-0.3125, -0.1875, -0.375, 0.3125, -0.125, -0.3125},
			{-0.3125, -0.1875, 0.3125, 0.3125, -0.125, 0.375},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
			{0.4375, -0.375, -0.5, 0.5, 0.4375, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, 0.4375, 0.5},
			{-0.4375, 0.3125, -0.375, 0.4375, 0.4375, 0.375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	selection_box = {
type = "fixed",
fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
},
    sounds = default.node_sound_stone_defaults(),

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string('infotext', "Fireplace");
    end,

    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        if itemstack:get_name() == "fire:flint_and_steel" then
            minetest.sound_play("seasonal_decor_fireplace_ignite",{pos = pos, gain = 0.5, max_hear_distance = 8})
            minetest.set_node(pos, {name="seasonal_decor:fireplace_active", param2 = node.param2})
--            local id = minetest.add_particle({
--                pos = {x = pos.x, y = pos.y, z = pos.z},
--                velocity = {x=0, y=0.1, z=0},
--                acceleration = {x=0, y=0, z=0},
--                expirationtime = 1,
--                size = 3,
--                collisiondetection = true,
--                vertical = true,
--                texture = "tnt_smoke.png",
--            })
        end
    end,
})

minetest.register_node('seasonal_decor:fireplace_active', {
    description = "Active Fireplace",
    drawtype = "nodebox",
    tiles = {
    'default_stone.png^seasonal_decor_fireplace_sides.png',
    'default_stone.png^seasonal_decor_fireplace_sides.png',
    'default_stone.png^seasonal_decor_fireplace_sides.png',
    'default_stone.png^seasonal_decor_fireplace_sides.png',
    'default_stone.png^seasonal_decor_fireplace_sides.png',
    'default_stone.png^seasonal_decor_fireplace_front.png'
    },
    walkable = false,
    buildable_to = true,
    sunlight_propagates = true,
    groups = {oddly_breakable_by_hand=3, flammable=0, not_in_creative_inventory=1, igniter=1},
    paramtype = "light",
    paramtype2 = "facedir",
    legacy_facedir_simple = true,
    is_ground_content = false,
    on_rotate = screwdriver.rotate_simple,
    light_source = 8,
    damage_per_second = 1,
    drop = 'seasonal_decor:fireplace',
    sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, -0.3125, 0.3125, 0.375},
			{0.3125, -0.375, -0.375, 0.4375, 0.3125, 0.375},
			{-0.25, -0.375, -0.375, -0.1875, -0.0625, -0.3125},
			{-0.125, -0.375, -0.375, -0.0625, 0, -0.3125},
			{0.1875, -0.375, -0.375, 0.25, -0.0625, -0.3125},
			{0.0625, -0.375, -0.375, 0.125, 0, -0.3125},
			{-0.25, -0.375, 0.3125, -0.1875, -0.0625, 0.375},
			{-0.125, -0.375, 0.3125, -0.0625, 0, 0.375},
			{0.1875, -0.375, 0.3125, 0.25, -0.0625, 0.375},
			{0.0625, -0.375, 0.3125, 0.125, 0, 0.375},
			{-0.3125, -0.1875, -0.375, 0.3125, -0.125, -0.3125},
			{-0.3125, -0.1875, 0.3125, 0.3125, -0.125, 0.375},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
			{0.4375, -0.375, -0.5, 0.5, 0.4375, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, 0.4375, 0.5},
			{-0.4375, 0.3125, -0.375, 0.4375, 0.4375, 0.375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
selection_box = {
type = "fixed",
fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
},

    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        local meta = minetest.get_meta(pos)
        cooking(pos, itemstack)
--         if itemstack:get_definition().groups.flammable == 1 then
         if itemstack:get_definition().groups.flammable then
            local it_val = meta:get_int("it_val") + (fireplace_ttl);
            meta:set_int('it_val', it_val);
            effect(
                {x = pos.x, y = pos.y+0.3, z = pos.z},
                "default_stick.png",
                {x=0, y=-1, z=0},
                {x=0, y=0, z=0},
                1,
                6
            )
            infotext_edit(meta)
          --  if not minetest.setting_getbool("creative_mode") then
                itemstack:take_item()
                return itemstack
       --     end
        end
    end,

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_int('it_val', fireplace_ttl);
        infotext_edit(meta)
        minetest.get_node_timer(pos):start(2)
    end,

    on_destruct = function(pos, oldnode, oldmetadata, digger)
        fire_particles_off(pos)
        local meta = minetest.get_meta(pos)
        local handle = meta:get_int("handle")
        minetest.sound_stop(handle)
    end,

    on_timer = function(pos) -- Every 6 seconds play sound fire_small
        local meta = minetest.get_meta(pos)
        local handle = minetest.sound_play("fire_small",{pos=pos, max_hear_distance = 18, loop=false, gain=0.1})
        meta:set_int("handle", handle)
        minetest.get_node_timer(pos):start(6)
    end,
})

--------
--ABM
--------
minetest.register_abm({
    nodenames = {"seasonal_decor:fireplace_active"},
--    neighbors = {"group:puts_out_fire"},
    interval = 1.0, -- Run every 3 seconds
    chance = 1, -- Select every 1 in 1 nodes
    catch_up = false,

    action = function(pos, node, active_object_count, active_object_count_wider)
        local fpos, num = minetest.find_nodes_in_area(
            {x=pos.x-1, y=pos.y, z=pos.z-1},
            {x=pos.x+1, y=pos.y+1, z=pos.z+1},
            {"group:water"}
        )
        if #fpos > 0 then
            minetest.swap_node(pos, {name="seasonal_decor:fireplace", param2 = node.param2})
            minetest.sound_play("fire_extinguish_flame",{pos = pos, max_hear_distance = 16, gain = 0.15})
        else
            local meta = minetest.get_meta(pos)
            local it_val = meta:get_int("it_val") - 1;

            if fireplace_limit and fireplace_ttl > 0 then
                if it_val <= 0 then
                     --minetest.remove_node(pos)
                    minetest.swap_node(pos, {name="seasonal_decor:fireplace", param2 = node.param2})
                    return
                end
                meta:set_int('it_val', it_val);
            end

            if fireplace_cooking then
                if meta:get_int('cooked_cur_time') <= meta:get_int('cooked_time') then
                    meta:set_int('cooked_cur_time', meta:get_int('cooked_cur_time') + 1);
                else
                    meta:set_int('cooked_time', 0);
                    meta:set_int('cooked_cur_time', 0);
                end
            end

            infotext_edit(meta)
            fire_particles_on(pos)
        end
    end
})

-----------
--Crafting
-----------
minetest.register_craft({
    output = "seasonal_decor:fireplace",
recipe = {
{'group:stone', 'group:stone', 'group:stone'},
{'group:stone', 'group:leaves', 'group:stone'},
{'group:stone', 'default:stick', 'group:stone'},
}
})