
--string of christmas lights
minetest.register_node("seasonal_decor:xmas_lites", {
	description = "X-Mas Lights",
	inventory_image = "seasonal_decor_xmas_lites_inv.png",
	wield_image = "seasonal_decor_xmas_lites_inv.png^[transformR90",
	wield_scale = {x=0.5,y=0.5,z=0.5},
	tiles = {
		{
			name = "seasonal_decor_xmas_lites_anim.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 10
			},
		},
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	paramtype = "light",
	light_source = 5,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {dig_immediate = 1, oddly_breakable_by_hand = 2, snappy = 3},
	on_rotate = screwdriver.rotate_simple,
	sounds = default.node_sound_glass_defaults({
		dug = {name = "default_break_glass", gain = 0.025},
		dig = {name = "default_glass_footstep", gain = 0.175},
		footstep = {name = "default_glass_footstep", gain = 0.175},
		place = {name = "default_glass_footstep", gain = 0.15},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, 0.4375, 0.4375, -0.375, 0.5, 0.5},
			{-0.3125, 0.375, 0.4375, -0.25, 0.4375, 0.5},
			{-0.1875, 0.3125, 0.4375, -0.125, 0.375, 0.5},
			{0.375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{0.25, 0.375, 0.4375, 0.3125, 0.4375, 0.5},
			{0.125, 0.3125, 0.4375, 0.1875, 0.375, 0.5},
			{-0.030596, 0.25, 0.4375, 0.031852, 0.3125, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, 0.1875, 0.375, 0.5, 0.5, 0.5},
	}
})


--xmas_baubles
for _, c in pairs({"blue", "green", "orange", "red", "violet", "yellow", "white"}) do
minetest.register_node("seasonal_decor:xmas_baubles_" ..c.. "_001", {
	description = "X-Mas Bauble",
	inventory_image = "(seasonal_decor_bauble_001_inv_overlay.png^[colorize:"..c..":200)^seasonal_decor_bauble_inv_overlay.png",
	wield_image = "(seasonal_decor_bauble_001_inv_overlay.png^[colorize:"..c..":200)^seasonal_decor_bauble_inv_overlay.png",
	tiles = {
	"(seasonal_decor_tiny_lights.png^[colorize:"..c..":200)^seasonal_decor_bauble_topoverlay.png",
	"(seasonal_decor_tiny_lights.png^[colorize:"..c..":200)^seasonal_decor_bauble_topoverlay.png",
	"(seasonal_decor_tiny_lights.png^[colorize:"..c..":200)^seasonal_decor_bauble_overlay.png"},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 1,
	walkable = true,
	buildable_to = true,
	is_ground_content = false,
	sunlight_propagates = true,
	groups = {dig_immediate = 2, oddly_breakable_by_hand = 3},
	default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0078125, 0.4375, -0.0078125, 0.0078125, 0.5, 0.0078125}, --hook
			{-0.0625, 0.125, -0.0625, 0.0625, 0.4375, 0.0625},
			{-0.0625, 0.1875, -0.125, 0.0625, 0.375, -0.0625},
			{-0.0625, 0.1875, 0.0625, 0.0625, 0.375, 0.125},
			{-0.125, 0.1875, -0.0625, -0.0625, 0.375, 0.0625},
			{0.0625, 0.1875, -0.0625, 0.125, 0.375, 0.0625},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.125, 0.125, -0.125, 0.125, 0.5, 0.125},
	}
})

minetest.register_node("seasonal_decor:xmas_baubles_" ..c.. "_002", {
	description = "X-Mas Bauble",
	inventory_image = "(seasonal_decor_bauble_002_inv_overlay.png^[colorize:"..c..":180)^seasonal_decor_bauble_inv_overlay.png",
	wield_image = "(seasonal_decor_bauble_002_inv_overlay.png^[colorize:"..c..":180)^seasonal_decor_bauble_inv_overlay.png",
	tiles = {
		"(seasonal_decor_tiny_lights.png^[colorize:"..c..":180)^seasonal_decor_bauble_topoverlay.png",
		"(seasonal_decor_tiny_lights.png^[colorize:"..c..":180)^seasonal_decor_bauble_topoverlay.png",
		"(seasonal_decor_tiny_lights.png^[colorize:"..c..":180)^seasonal_decor_bauble_overlay.png"},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 1,
	walkable = true,
	buildable_to = true,
	is_ground_content = false,
	sunlight_propagates = true,
	groups = {dig_immediate = 2, oddly_breakable_by_hand = 3},
	default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0078125, 0.4375, -0.0078125, 0.0078125, 0.5, 0.0078125}, --hook
			{-0.0625, 0.125, -0.0625, 0.0625, 0.4375, 0.0625},
			{-0.125, 0.1875, -0.125, 0.125, 0.375, 0.125},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.125, 0.125, -0.125, 0.125, 0.5, 0.125},
	}
})

--strings of colored lights
minetest.register_node("seasonal_decor:string_lites_"..c, {
	description = c:gsub("^%l", string.upper).." String of Lights",
	inventory_image = "(seasonal_decor_string_lites_inv.png^[colorize:"..c..":160)^seasonal_decor_string_lites_overlay.png",
	wield_image = "(seasonal_decor_string_lites_inv.png^[colorize:"..c..":160)^seasonal_decor_string_lites_overlay.png^[transformR90",
	wield_scale = {x=0.5,y=0.5,z=0.5},
	tiles = {
		{
			name = "seasonal_decor_string_lites_anim.png^[colorize:"..c..":160",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 10
			},
		},
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	paramtype = "light",
	light_source = 5,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {dig_immediate = 1, oddly_breakable_by_hand = 2, snappy = 3},
	on_rotate = screwdriver.rotate_simple,
	sounds = default.node_sound_glass_defaults({
		dug = {name = "default_break_glass", gain = 0.025},
		dig = {name = "default_glass_footstep", gain = 0.175},
		footstep = {name = "default_glass_footstep", gain = 0.175},
		place = {name = "default_glass_footstep", gain = 0.15},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, 0.4375, 0.4375, -0.375, 0.5, 0.5},
			{-0.3125, 0.375, 0.4375, -0.25, 0.4375, 0.5},
			{-0.1875, 0.3125, 0.4375, -0.125, 0.375, 0.5},
			{0.375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{0.25, 0.375, 0.4375, 0.3125, 0.4375, 0.5},
			{0.125, 0.3125, 0.4375, 0.1875, 0.375, 0.5},
			{-0.030596, 0.25, 0.4375, 0.031852, 0.3125, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, 0.1875, 0.375, 0.5, 0.5, 0.5},
	}
})
end

--wreath with snow
minetest.register_node("seasonal_decor:wreath_with_snow", {
	description = "Wreath with Snow",
	tiles = {
	"default_snow.png", "seasonal_decor_snowey_pine_bottom.png",
	"seasonal_decor_snowey_pine.png", "seasonal_decor_snowey_pine.png",
	"seasonal_decor_snowey_pine_bottom.png",
	"seasonal_decor_wreath_with_snow.png"
	},
	inventory_image = "seasonal_decor_wreath_with_snow.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_rotate = screwdriver.rotate_simple,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {dig_immediate = 1, oddly_breakable_by_hand = 2, snappy = 3, flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, 0.25, 0.375, 0.1875, 0.5, 0.5},
			{-0.1875, -0.5, 0.375, 0.1875, -0.25, 0.5},
			{-0.5, -0.1875, 0.375, -0.25, 0.1875, 0.5},
			{0.25, -0.1875, 0.375, 0.5, 0.1875, 0.5},
			{-0.4375, 0.125, 0.4375, -0.1875, 0.3125, 0.5},
			{0.1875, 0.125, 0.4375, 0.4375, 0.3125, 0.5},
			{-0.4375, -0.3125, 0.4375, -0.1875, -0.125, 0.5},
			{0.1875, -0.3125, 0.4375, 0.4375, -0.125, 0.5},
			{-0.375, 0.1875, 0.375, -0.125, 0.375, 0.5},
			{0.125, 0.1875, 0.375, 0.375, 0.375, 0.5},
			{-0.375, -0.375, 0.375, -0.125, -0.1875, 0.5},
			{0.125, -0.375, 0.375, 0.375, -0.1875, 0.5},
			{-0.3125, 0.375, 0.4375, -0.1875, 0.4375, 0.5},
			{0.1875, 0.375, 0.4375, 0.3125, 0.4375, 0.5},
			{-0.3125, -0.4375, 0.4375, -0.1875, -0.375, 0.5},
			{0.1875, -0.4375, 0.4375, 0.3125, -0.375, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.25, 0.5, 0.5, 0.5},
	}
})

--holiday wreath
minetest.register_node("seasonal_decor:wreath", {
	description = "Holiday Wreath",
	tiles = {
	"seasonal_decor_snowey_pine_bottom.png", "seasonal_decor_snowey_pine_bottom.png",
	"seasonal_decor_snowey_pine_bottom.png", "seasonal_decor_snowey_pine_bottom.png",
	"seasonal_decor_snowey_pine_bottom.png",
	"seasonal_decor_wreath_inv.png"
	},
	inventory_image =  "seasonal_decor_wreath_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_rotate = screwdriver.rotate_simple,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {dig_immediate = 1, oddly_breakable_by_hand = 2, snappy = 3, flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
	type = "fixed",
		fixed = {
			{-0.1875, 0.25, 0.375, 0.1875, 0.5, 0.5},
			{-0.1875, -0.5, 0.375, 0.1875, -0.25, 0.5},
			{-0.5, -0.1875, 0.375, -0.25, 0.1875, 0.5},
			{0.25, -0.1875, 0.375, 0.5, 0.1875, 0.5},
			{-0.4375, 0.125, 0.4375, -0.1875, 0.3125, 0.5},
			{0.1875, 0.125, 0.4375, 0.4375, 0.3125, 0.5},
			{-0.4375, -0.3125, 0.4375, -0.1875, -0.125, 0.5},
			{0.1875, -0.3125, 0.4375, 0.4375, -0.125, 0.5},
			{-0.375, 0.1875, 0.375, -0.125, 0.375, 0.5},
			{0.125, 0.1875, 0.375, 0.375, 0.375, 0.5},
			{-0.375, -0.375, 0.375, -0.125, -0.1875, 0.5},
			{0.125, -0.375, 0.375, 0.375, -0.1875, 0.5},
			{-0.3125, 0.375, 0.4375, -0.1875, 0.4375, 0.5},
			{0.1875, 0.375, 0.4375, 0.3125, 0.4375, 0.5},
			{-0.3125, -0.4375, 0.4375, -0.1875, -0.375, 0.5},
			{0.1875, -0.4375, 0.4375, 0.3125, -0.375, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.25, 0.5, 0.5, 0.5},
	}
})

--christmas tree leaves

--christmas tree leaves (snowey pine)


--snowman
minetest.register_node("seasonal_decor:snowman", {
	description = "Snowman (body)",
	--	inventory_image =  "seasonal_decor_snowman.png",
	--	wield_image = "seasonal_decor_snowman.png",
	tiles = {"default_snow.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_rotate = screwdriver.rotate_simple,
	is_ground_content = false,
	sunlight_propagates = true,
	groups = {crumbly = 3},
	sounds = default.node_sound_sand_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.4375, 0.3125, 0.5},
			{-0.5, -0.5, -0.4375, 0.5, 0.3125, 0.4375},
			{-0.4375, 0.3125, -0.4375, 0.4375, 0.375, 0.4375},
			{-0.375, 0.375, -0.3125, 0.375, 0.4375, 0.3125},
			{-0.375, 0.375, -0.375, 0.375, 0.4375, 0.375},
			{-0.25, 0.4375, -0.25, 0.25, 0.5, 0.25},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	}
})

minetest.register_node("seasonal_decor:snowman_head", {
	description = "Snowman (head)",
	--	inventory_image =  "seasonal_decor_snowman.png",
	--	wield_image = "seasonal_decor_snowman.png",
	tiles = {
	"default_snow.png", 
	"default_snow.png", 
	"default_snow.png", 
	"default_snow.png", 
	"default_snow.png", 
	"default_snow.png^seasonal_decor_snowman.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_rotate = screwdriver.rotate_simple,
	is_ground_content = false,
	sunlight_propagates = true,
	groups = {crumbly = 3},
	sounds = default.node_sound_sand_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.125, 0.1875},
			{-0.25, -0.4375, -0.25, 0.25, 0.0625, 0.25},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.5, -0.3125, 0.3125, 0.1875, 0.3125},
	}
})

minetest.register_node("seasonal_decor:xmas_stocking", {
	description = "X-Mas Stocking",
	inventory_image =  "seasonal_decor_stocking_inv.png",
	--wield_image = "seasonal_decor_snowman.png",
	tiles = {"wool_red.png", 
	"[combine:16x16:0,0=wool_white.png:0,4=wool_red.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	on_rotate = screwdriver.rotate_simple,
	is_ground_content = false,
	groups = {dig_immediate = 3, oddly_breakable_by_hand = 3, flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.25, 0.4375, 0.25, 0.4375, 0.5}, 
			{-0.1875, -0.125, 0.4375, 0.1875, 0.5, 0.5}, 
			{-0.125, -0.1875, 0.4375, 0.25, 0.0625, 0.5}, 
			{-0.0625, -0.1875, 0.4375, 0.3125, 0, 0.5}, 
			{-0.0625, -0.25, 0.4375, 0.25, -0.1875, 0.5}, 
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.3125, 0.375, 0.375, 0.5, 0.5}, 
		},
	},
})

--original jack 'o lantern by TenPlus1 from Farming_Redo mod
minetest.register_node("seasonal_decor:punkin_head", {
	description = "Jack 'O Lantern",
	tiles = {
	"seasonal_decor_pumpkin_top.png",
	"seasonal_decor_pumpkin_bottom.png",
	"seasonal_decor_pumpkin_side.png",
	"seasonal_decor_pumpkin_side.png",
	"seasonal_decor_pumpkin_side.png",
	"seasonal_decor_pumpkin_face_off.png"},
	drawtype = "nodebox",
	light_source = 2,
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	on_rotate = screwdriver.rotate_simple,
	is_ground_content = false,
	groups = {dig_immediate = 1, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0.3125, -0.1875, 0.125, 0.375, 0.1875},
			{-0.5, -0.375, -0.375, 0.5, 0.1875, 0.375},
			{-0.375, -0.375, -0.5, 0.375, 0.1875, 0.5},
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.25, 0.4375},
			{-0.0625, 0.375, -0.0625, 0.0625, 0.4375, 0.0625},
			{-0.375, -0.5, -0.375, 0.375, 0.3125, 0.375},
			{-0.1875, 0.3125, -0.125, 0.1875, 0.375, 0.125},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0.125, 0.3125}, -- sbox
		},
	},
	on_punch = function(pos, node, puncher)
		node.name = "seasonal_decor:punkin_head_on"
		minetest.swap_node(pos, node)
	end,
})

minetest.register_node("seasonal_decor:punkin_head_on", {
	description = "Jack 'O Lantern",
	tiles = {
		"seasonal_decor_pumpkin_top.png",
		"seasonal_decor_pumpkin_bottom.png",
		"seasonal_decor_pumpkin_side.png",
		"seasonal_decor_pumpkin_side.png",
		"seasonal_decor_pumpkin_side.png",
		--"seasonal_decor_pumpkin_face_on.png"
		{
			image = "seasonal_decor_pumpkin_face_on_anim.png",
			--backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 5
			},
		}
	},
	drawtype = "nodebox",
	light_source = 6,
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	on_rotate = screwdriver.rotate_simple,
	is_ground_content = false,
	groups = {crumbly = 1, oddly_breakable_by_hand = 1,
	not_in_creative_inventory = 1},
	drop = "seasonal_decor:punkin_head",
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0.3125, -0.1875, 0.125, 0.375, 0.1875},
			{-0.5, -0.375, -0.375, 0.5, 0.1875, 0.375},
			{-0.375, -0.375, -0.5, 0.375, 0.1875, 0.5},
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.25, 0.4375},
			{-0.0625, 0.375, -0.0625, 0.0625, 0.4375, 0.0625},
			{-0.375, -0.5, -0.375, 0.375, 0.3125, 0.375},
			{-0.1875, 0.3125, -0.125, 0.1875, 0.375, 0.125},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0.125, 0.3125}, -- sbox
		},
	},
	on_punch = function(pos, node, puncher)
		node.name = "seasonal_decor:punkin_head"
		minetest.swap_node(pos, node)
	end,
})
