minetest.register_globalstep(function()
	if not minetest.settings:get_bool("autodam") then return end
	local player = minetest.localplayer
	if not player then return end
	if player:get_wielded_item():get_name() ~= "mcl_core:dirt" then return end
	local dirt = minetest.find_nodes_near(vector.add(player:get_pos(), vector.new(0, 1, 0)), 4, "mcl_core:dirt")
	for _, dp in ipairs(dirt) do
		local above = minetest.get_node_or_nil(vector.add(dp, vector.new(0, 1, 0)))
		if above and above.name == "mcl_core:dirt" then
			local underp = vector.subtract(dp, vector.new(0, 1, 0))
			local under = minetest.get_node_or_nil(underp)
			if under and under.name == "mcl_core:water_source" then
				minetest.place_node(underp)
			end
		end
	end
end)

minetest.register_cheat("AutoDam", "World", "autodam")
