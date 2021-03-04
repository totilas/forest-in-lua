require('constants')
require('tree')

function love.load()
	math.randomseed(love.timer.getTime())
	initialize_forest()
end

function love.update(dt)
	for a, tree in pairs(forest) do
		if tree ~= nil then
			update_tree(tree, a)
			local fils = reproduce_tree(tree, a)
			table.insert(forest, fils)
		end
	end

	-- keyboard stuff
	if love.keyboard.isDown('down') then
		delta = -1
	elseif love.keyboard.isDown('up') then
      	delta = 1
	else
   		delta = 0

   	if love.keyboard.isDown('r') then
		change = "r"
	elseif love.keyboard.isDown('m') then
		change = "m"
	elseif love.keyboard.isDown('z') then
		change = "z"
	else
		change = ""
	end
	end
end



function love.draw()
	love.graphics.setBackgroundColor( 255, 255,255)
	love.graphics.setColor( 0, 155, 30)
	if change == "z" and delta == 1 then
		zoom = zoom * 1.02
	elseif change == "z" and delta ==-1 then
		zoom = zoom * .95
	end

	love.graphics.scale(zoom, zoom)
	love.graphics.translate((window_w *(1-zoom) /2)/zoom, (window_h * (1 - zoom)/2)/zoom)
	--love.graphics.translate(400, 400)


	if change == "m" then
		proba_mort = math.min(proba_mort * (1+.1*delta), 1)
	elseif change == "r" then
		proba_reproduction = math.min(proba_reproduction * (1+.1*delta), 1)
	end

	for a, tree in pairs(forest) do
		draw_tree(tree)
	end

	love.graphics.setColor( 0, 0,100)
	local textrep = "proba reproduction r = ".. tostring(proba_reproduction)
	local textmor = "proba mort m = " .. tostring(proba_mort)
	local z = zoom
	local textzoom = "zoom z = " .. tostring(z)
	love.graphics.origin()
	love.graphics.print(textrep,10, 10, 0, 1, 1)
	love.graphics.print(textmor, 10, 30 ,0, 1, 1)
	love.graphics.print(textzoom, 10, 50, 0, 1, 1)
end