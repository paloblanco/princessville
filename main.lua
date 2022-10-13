-- thing class

thing = {}

function thing:init()
end

function thing:new(o)
    local o=o or {}
    local t={}
    for k,v in pairs(self) do
        if type(v) == "table" then
            newt = {}
            for kk,vv in pairs(v) do
                newt[kk]=vv
            end
            t[k]=newt
        else
            t[k] = v
        end
    end
    for k,v in pairs(o) do
        t[k] = v
    end
    setmetatable(t,self)
    self.__index=self
    t:init()
    return t
end

background = thing:new()
background.path = "art/working/frost_sprite.png"
-- you must provide path

function background:init()
    local bg = love.graphics.newImage(self.path)
    local w = bg:getWidth()
    local h = bg:getHeight()
    local wscale = love.graphics.getWidth() / w
    local hscale = love.graphics.getHeight() / h
    self.texture = bg
    self.w = w
    self.h = h
    self.wscale = wscale
    self.hscale = hscale
end

function background:draw()
    love.graphics.draw(self.texture,0,0,0,self.wscale,self.hscale)
end

function love.load()
    frostCastle = background:new{path="art/raw/frostcastle.png"}
    frostP = love.graphics.newImage("art/working/frost_sprite.png")
end

function love.update(dt)

end

function love.keypressed(key, u)
    --Debug
    if key == "lctrl" then --set to whatever key you want to use
       debug.debug()
    end
 end

function love.draw()
    -- love.graphics.print("Hello World", 400, 300)
    -- love.graphics.draw(frostCastle,0,0,0,1,1)
    frostCastle:draw()
end