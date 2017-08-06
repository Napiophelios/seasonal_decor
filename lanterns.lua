
------------
-- Nodes
------------

--hanging lanterns
minetest.register_node("seasonal_decor:lantern_hanging", {
	description = "Lantern",
	inventory_image = "seasonal_decor_lantern_inv.png",
	tiles = {
        "seasonal_decor_lantern_mat.png^[colorize:#1f1f1f:50",
        "seasonal_decor_lantern_mat.png^[colorize:#1f1f1f:70",
        "seasonal_decor_lantern_mat.png^seasonal_decor_lantern_glow.png"
        },
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    is_ground_content = false,
    buildable_to = false,
    groups = {dig_immediate = 1, oddly_breakable_by_hand = 2, crumbly = 3},
    on_rotate = screwdriver.rotate_simple,
    sounds = default.node_sound_wood_defaults({
        dug = {name = "default_break_glass", gain = 0.5},
    }),
    node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.3125, -0.0625, 0.0625, 0.25, 0.0625},
			{-0.125, -0.25, -0.125, 0.125, 0.1875, 0.125},
			{-0.1875, -0.1875, -0.1875, 0.1875, -0.125, 0.1875},
			{-0.1875, 0.0625, -0.1875, 0.1875, 0.125, 0.1875},
			{-0.015625, 0.25, -0.015625, 0.015625, 0.5, 0.015625}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.3125, -0.1875, 0.1875, 0.5, 0.1875},
		},
	},
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1875, -0.3125, -0.1875, 0.1875, 0.5, 0.1875},
        },
    },
    	on_construct = function(pos)
		local timer = minetest.env:get_node_timer(pos)
			timer:start(1)
		end,
	on_timer = function(pos, elapsed)
		if minetest.env:get_timeofday() >= 0.75 or minetest.env:get_timeofday() < 0.25 then
			minetest.set_node(pos, {name="seasonal_decor:lantern_hanging_on"}) else
			local timer = minetest.env:get_node_timer(pos)
			timer:start(30)
			return true
		end
	end,
})

minetest.register_node("seasonal_decor:lantern_hanging_on", {
	tiles = {
        "seasonal_decor_lantern_mat.png^[colorize:#1f1f1f:50",
        "seasonal_decor_lantern_mat.png^[colorize:#1f1f1f:70",
    		{
			image = "seasonal_decor_lantern_glow_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.5
			},
		}
	},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    light_source = 10,
    is_ground_content = false,
    walkable = true,
    buildable_to = false,
    groups = {dig_immediate = 1, oddly_breakable_by_hand = 2, crumbly = 3, not_in_creative_inventory = 1},
    drop = "seasonal_decor:lantern_hanging",
    on_rotate = screwdriver.rotate_simple,
    sounds = default.node_sound_wood_defaults({
        dug = {name = "default_break_glass", gain = 0.5},
    }),
    node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.3125, -0.0625, 0.0625, 0.25, 0.0625},
			{-0.125, -0.25, -0.125, 0.125, 0.1875, 0.125},
			{-0.1875, -0.1875, -0.1875, 0.1875, -0.125, 0.1875},
			{-0.1875, 0.0625, -0.1875, 0.1875, 0.125, 0.1875},
			{-0.015625, 0.25, -0.015625, 0.015625, 0.5, 0.015625}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.3125, -0.1875, 0.1875, 0.5, 0.1875},
		},
	},
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1875, -0.3125, -0.1875, 0.1875, 0.5, 0.1875},
        },
    },
    on_construct = function(pos)
		local timer = minetest.env:get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos, elapsed)
			if minetest.env:get_timeofday() >= 0.25 and minetest.env:get_timeofday() < 0.75 then
				minetest.set_node(pos, {name="seasonal_decor:lantern_hanging"}) else
				local timer = minetest.env:get_node_timer(pos)
				timer:start(30)
			end
		return true
	end,
})

--tiny lanterns
minetest.register_node("seasonal_decor:lantern_tiny", {
 description = "Faery Lights",
 inventory_image = "seasonal_decor_tiny_lights_inv.png",
 wield_image = "seasonal_decor_tiny_lights_inv.png",
 wield_scale = {x=0.5,y=0.5,z=0.5},
	tiles = {"seasonal_decor_tiny_lights.png","seasonal_decor_tiny_lights.png","seasonal_decor_tiny_lights_sides.png"
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	paramtype = "light",
	light_source = 8,
	walkable = true,
	buildable_to = true,
	is_ground_content = false,
	sunlight_propagates = true,
	groups = {dig_immediate = 1, oddly_breakable_by_hand = 2, crumbly = 3},
	on_rotate = screwdriver.rotate_simple,
	default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{0.25, 0.3125, -0.03125, 0.3125, 0.375, 0.03125},
			{-0.3125, 0.3125, -0.03125, -0.25, 0.375, 0.03125},
			{-0.03125, 0.3125, -0.03125, 0.03125, 0.375, 0.03125},
			{-0.0078125, 0.375, -0.0078125, 0.0078125, 0.5, 0.0078125},
			{0.274247, 0.375, -0.007813, 0.288574, 0.5, 0.007813},
			{-0.288574, 0.375, -0.007813, -0.274247, 0.5, 0.007813},
		}
	},
		selection_box = {
		type = "fixed",
		fixed = {-0.5, 0.25, -0.0625, 0.5, 0.5, 0.0625},
	}
})

--suspension wiring for lanterns
	minetest.register_node("seasonal_decor:lantern_wiring", {
		description = "Suspension Wire",
		drawtype = "nodebox",
		inventory_image = "seasonal_decor_wiring.png",
		wield_image = "seasonal_decor_wiring.png",
		node_box = {
			type = "connected",
			fixed = {{-0.015625, -0.5, -0.015625, 0.015625, -0.46875, 0.015625}},
connect_left = {{-0.5, -0.5, -0.015625, 0.015625, -0.46875, 0.015625}},
connect_right = {{-0.015625, -0.5, -0.015625, 0.5, -0.46875, 0.015625}},
connect_back = {{-0.015625, -0.5, -0.015625, 0.015625, -0.46875, 0.5}},
connect_front = {{-0.015625, -0.5, -0.5, 0.015625, -0.46875, 0.015625}},
		},
			selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
		},
	},
		connects_to = { "group:anchored_node", "group:stone", "group:cobble", "group:wood", "group:tree", "group:fence" },
		paramtype = "light",
		is_ground_content = false,
		tiles = { "seasonal_decor_lantern_mat.png^[colorize:#1f1f1f:225", },
		walkable = false,
		groups = { dig_immediate = 1, oddly_breakable_by_hand = 2, crumbly = 3, anchored_node = 1},
		sounds = default.node_sound_leaves_defaults(),
	})
