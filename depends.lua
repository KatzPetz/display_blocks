--
--Titanium
--


minetest.register_node( "display_blocks:titanium_in_ground", {
	description = "Titanium Ore",
	tile_images = { "default_stone.png^titanium_titanium_in_ground.png" },
	is_ground_content = true,
	groups = {cracky=1},
	drop = 'craft "display_blocks:titanium" 1',
})

minetest.register_node( "display_blocks:titanium_block", {
	description = "Titanium Block",
	tile_images = { "titanium_block.png" },
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_craftitem( "display_blocks:titanium", {
	description = "Titanium",
	inventory_image = "titanium_titanium.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "display_blocks:tougher_titanium", {
	description = "Tougher Titanium",
	inventory_image = "tougher_titanium.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--Craft Recipes
minetest.register_craft({
	output = 'display_blocks:titanium_block',
	recipe = {
		{'display_blocks:titanium', 'display_blocks:titanium', 'display_blocks:titanium'},
		{'display_blocks:titanium', 'display_blocks:titanium', 'display_blocks:titanium'},
		{'display_blocks:titanium', 'display_blocks:titanium', 'display_blocks:titanium'},
	}
})

minetest.register_craft({
	output = 'display_blocks:titanium 9',
	recipe = {
		{'', 'display_blocks:block', ''},
	}
})

minetest.register_craft({
	output = 'display_blocks:tougher_titanium',
	recipe = {
		{'display_blocks:titanium', 'display_blocks:titanium'},
		{'display_blocks:titanium', 'display_blocks:titanium'},
	}
})

--Ore generation
local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
end

minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("display_blocks:titanium_in_ground", "default:stone", minp, maxp, seed+21,   1/9/9/9,    5, -31000,  -400)
end)



--
--Uranium
--


minetest.register_node( "display_blocks:uranium_ore", {
	description = "Uranium Ore",
	tile_images = { "default_stone.png^uranium_ore.png" },
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'craft "display_blocks:uranium_dust" 3',
})

minetest.register_craftitem( "display_blocks:uranium_dust", {
	description = "Uranium Dust",
	inventory_image = "uranium_dust.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_node( "display_blocks:uranium_block", {
	description = "Uranium Block",
	tile_images = { "uranium_block.png" },
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 15,
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
})


minetest.register_craft( {
	output = 'node "display_blocks:uranium_block" 1',
	recipe = {
		{ 'display_blocks:uranium_dust', 'display_blocks:uranium_dust', 'display_blocks:uranium_dust' },
		{ 'display_blocks:uranium_dust', 'display_blocks:uranium_dust', 'display_blocks:uranium_dust' },
		{ 'display_blocks:uranium_dust', 'display_blocks:uranium_dust', 'display_blocks:uranium_dust' },
	}
})

-- Ore generation

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
	if (y_max-chunk_size+1 <= y_min) then return end
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	--print("generate_ore done")
end

minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("display_blocks:uranium_ore", "default:stone", minp, maxp, seed+21,   1/13/13/13,    5, -31000,  -150)

end)
