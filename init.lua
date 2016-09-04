-- Antifire
-- Copyright 2016 James Stevenson (everamzah)
-- LGPL v2.1+

-- Find a flame, then find another flame,
-- then remove the previous one, and continue.

-- Antiflame shall be blue.

minetest.register_node("antifire:antiflame", {
	drawtype = "firelike",
	tiles = {
		{
			name = "fire_basic_flame_animated.png^[colorize:cyan:127",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
	},
	inventory_image = "fire_basic_flame.png^[colorize:cyan:127",
	paramtype = "light",
	light_source = 14,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	damage_per_second = 4,
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
})

minetest.register_tool("antifire:antifire", {
	description = "Antiflame",
	inventory_image = "fire_basic_flame.png^[colorize:cyan:127",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then return end
		if minetest.get_node(pointed_thing.under).name == "fire:basic_flame" then
			minetest.set_node(pointed_thing.under, {name = "antifire:antiflame"})
		end
	end
})

minetest.register_abm({
	nodenames = {"antifire:antiflame"},
	interval = 3,
	chance = 1,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local n = minetest.find_node_near(pos, 5, {"fire:basic_flame"})
		if n then
			return minetest.set_node(n, {name = "antifire:antiflame"})
		end
		minetest.remove_node(pos)
	end
})
