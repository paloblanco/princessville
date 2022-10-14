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
background.path = "art/raw/frostcastle.png"
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

sprite = thing:new()
sprite.path = "art/working/frost_sprite.png"

function sprite:init()
    local s = love.graphics.newImage(self.path)
    local w = s:getWidth()
    local h = s:getHeight()
    local wscale = 64 / w
    local hscale = 128 / h
    self.texture = s
    self.w = w
    self.h = h
    self.wscale = wscale
    self.hscale = hscale
    self.x = 0
    self.y = 0
end

function sprite:draw(x,y)
    love.graphics.setColor(0, 0, 0, 1)
    for xx=-1,1,1 do
        for yy=-1,1,1 do
            love.graphics.draw(self.texture,x+xx,y+yy,0,self.wscale,self.hscale)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.texture,x,y,0,self.wscale,self.hscale)
end

function love.load()
    frostCastle = background:new{path="art/raw/frostcastle.png"}
    frostP = sprite:new{"art/working/frost_sprite.png"}

    player = {}
    player.x = 200
    player.y = 300
    player.speed = 128
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed * dt
    end
end

function love.draw()
    -- love.graphics.print("Hello World", 400, 300)
    -- love.graphics.draw(frostCastle,0,0,0,1,1)
    frostCastle:draw()
    frostP:draw(player.x,player.y)
end