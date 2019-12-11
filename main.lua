local score = nil
local vidas = nil
local background = nil
local playOnce = true
local bolaComida = {}
local comedor = {}
local maxScore = nil

local fontePrincipal = "assets/fonts/acme.ttf"

local bolas = {}


local menuInicialAtivo = true
local perdeu = nil

-- funções relativas ao objeto comedor
function getComedorX(comedor)
    return comedor.posX
end

function getComedorY(comedor)
    return comedor.posY
end
---


function perdeu()
    if(perdeu == true) then
        return true
    end
    return false
end

function reproduzSomDaDerrota()
    if(playOnce) then
        somDerrota:play()
        playOnce = false
    end
end

function atualizaBola(bola, comedor)
    if(bola.y >= 599) then
        bola.y = 0
        bola.x = math.random(1, 790)
    else
        bola.y = bola.y + bola.f
    end

    if(bola.y >= 575 and (bola.x >= comedor.posX and bola.x <= comedor.posX + 50)) then
        if(vidas == 0) then
            perdeu = true
        end
        bola.y = 0
        vidas = vidas - 1
    end
end


function atualizaBolaComida(bolaComida, comedor)
    if(bolaComida.y >= 599) then
        bolaComida.y = 0
        bolaComida.x = math.random(1, 790)
    else
        bolaComida.y = bolaComida.y + bolaComida.f
    end

    if(bolaComida.y >= 575 and (bolaComida.x >= comedor.posX and bolaComida.x <= comedor.posX + 50)) then
        bolaComida.y = 0
        bolaComida.f = math.random(5, 15)
        vidas = vidas + 1 -- atualiza o score caso o comedor coma a bola
        somComeu:play()
    end
end


function movimentoEsquerda()
    if(comedor.posX <= 0) then
        comedor.posX = love.graphics.getWidth()
    else
        comedor.posX = comedor.posX - 7.5
    end
end

function movimentoDireita()
    if(comedor.posX >= love.graphics.getWidth()) then
        comedor.posX = 0
    else
        comedor.posX = comedor.posX + 7.5
    end
end 

function love.load()
    math.randomseed(os.time())
    perdeu = false
    score = 0
    vidas = 3
    --CARREGANDO IMAGENS
    background = love.graphics.newImage("assets/img/green-back.png")
    --SONS USADOS DENTRO DO JOGO
    musicaTema = love.audio.newSource("assets/songs/song.mp3","static")
    somDerrota = love.audio.newSource("assets/songs/losssong.mp3", "static")
    somComeu = love.audio.newSource("assets/songs/comeu.wav", "static")
    --REPRODUZINDO MÚSICA PRINCIPAL
    --musicaTema:play()
	--musicaTema:setLooping(true)
    --CRIA AS BOLAS
    for i=1,15 do
        bolas[i] = {}
    end
    --INICIALIZA AS BOLAS
    bolaComida = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(2, 12)}
    for i=1,15 do
        bolas[i].raio = 10
        bolas[i].x = math.random(1, 790)
        bolas[i].y = 0
        bolas[i].f = math.random(math.random(1, 4), math.random(4, 9))
    end

    --INICIALIZA O COMEDOR
    comedor = {posX = 0, posY = 575, largura = 50, altura = 25}
    love.mouse.setVisible(false) --desativa o mouse dentro da janela do jogo
    


end

function love.update(dt)
    if(perdeu == false) then
        for i=1,15 do
            atualizaBola(bolas[i], comedor)
        end
        atualizaBolaComida(bolaComida, comedor)
    end
    if(love.keyboard.isDown("left")) then
        movimentoEsquerda()
    end
    if(love.keyboard.isDown("right")) then 
        movimentoDireita()
    end
    score = score + 1
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    if(menuInicialAtivo == true) then
        love.graphics.setFont(love.graphics.newFont(fontePrincipal), 15)
        love.graphics.print("PRESSIONE ESPAÇO PARA INICIAR", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2)
        if(love.keyboard.isDown("space")) then 
            menuInicialAtivo = false
        end
    elseif(perdeu == true) then
        musicaTema:stop()
        love.graphics.setFont(love.graphics.newFont(fontePrincipal), 15)
        love.graphics.print("VOCÊ PERDEU! PRESSIONE ESPAÇO PARA INICIAR NOVAMENTE", love.graphics.getHeight()/2 - 60, love.graphics.getWidth()/2 - 140)
        reproduzSomDaDerrota()
        if(love.keyboard.isDown("space")) then 
            score = 0 --
            playOnce = true
            perdeu = false
            vidas = 3
        end
    else 
        musicaTema:play()
        musicaTema:setLooping(true)
        love.graphics.setColor(255,255,0)
        love.graphics.circle("fill", bolaComida.x, bolaComida.y, bolaComida.raio)
        love.graphics.setColor(255, 255, 255)
        for i=1,15 do
            love.graphics.circle("fill", bolas[i].x, bolas[i].y, bolas[i].raio)
        end
        love.graphics.setColor(200, 150, 100)
        love.graphics.rectangle("fill", comedor.posX, comedor.posY, comedor.largura, comedor.altura)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("Pontuação: " .. score, 0, 0)
        love.graphics.print("Vidas: " .. vidas, love.graphics.getWidth()/2 - 100, 0)
    end
end
