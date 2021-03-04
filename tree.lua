function create_tree(x, y)
	local tree = {}
	tree.x = x
	tree.y = y
	tree.age = 0
	return tree
end

function initialize_forest()
	forest = {}
	local tree = create_tree(window_w / 2, window_h / 2)
	table.insert(forest, tree)
end

function draw_tree(tree)
	if tree.age > 2 then
		local diametre = diam_max*(1 - math.exp(- tree.age / 12))
		love.graphics.circle("fill", tree.x, tree.y, diametre)
	end
end


function update_tree(tree, number)
	tree.age = tree.age + .05*temps
	if tree.age > 20 then
		local morbidite = math.random()
		if morbidite < proba_mort then
			table.remove(forest, number)
			print("mort", number)
		end
	end
end


function reproduce_tree(father)
	if father.age > 5 then-- premier model un peu débile : 
		-- on se reproduit tout le temps avec proba p si on est assez age
		local fecondite = math.random()
		if fecondite < proba_reproduction then
			-- on choisit un endroit pour le fils
			local new_x = father.x + math.random()*distance_max*2 - distance_max
			local new_y = father.y + math.random()*distance_max*2 - distance_max
			local vivable = true
			for a, t in pairs(forest) do
				-- print(distance_max*distance_max)
				-- print((new_x - t.x)*(new_x-t.x)+ (new_y - t.y)*(new_y - t.y))
				if (new_x - t.x)*(new_x-t.x)+ (new_y - t.y)*(new_y - t.y) < distance_max*distance_max then
					vivable = false
				end
			end
			if vivable then	
				print("nouveau fils")
				local son = create_tree(new_x, new_y)
				return son
			end
		end
	end

end