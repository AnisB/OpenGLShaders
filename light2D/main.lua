
local W, H

function love.load ()
   W = love.graphics.getWidth
   H = love.graphics.getHeight
   love.graphics.setBackgroundColor(0, 0, 0)

   LightZPosition = 10
   box = love.graphics.newImage "box.png"
   diffuseBox  = love.graphics.newQuad(0, 0, 32, 32, 96, 32)


   canvas = love.graphics.newCanvas(W(), H())
   effect = love.graphics.newPixelEffect ("shader.glsl")
end

function love.update (dt)

   local x, y = love.mouse.getPosition()
   mouse = {x=x, y=y}
   y = H() - y
   effect:send("lightPos", {x, y, LightZPosition})
end

function love.mousepressed ()
end

function love.draw ()
   canvas:clear()
   love.graphics.setCanvas(canvas)
   draw()
   love.graphics.setCanvas()
   love.graphics.setPixelEffect()
   love.graphics.draw(canvas, 0, 0, 0)
end


function draw ()
   love.graphics.setPixelEffect()
   love.graphics.setColor(255, 255, 255)
   love.graphics.setPixelEffect(effect)
   love.graphics.setColor(255, 100, 100)
   love.graphics.drawq(box, diffuseBox, W()/2 - 34, H()/2 - 18)
   love.graphics.drawq(box, diffuseBox, W()/2 + 34, H()/2 + 18)
   love.graphics.setPixelEffect()
end

