local r = nil
local x = nil
local y = nil
local score = nil
local vidas = nil
local bola1 = {}
local background = nil
local playOnce = true
local bola2 = {}
local bola3 = {}
local bola4 = {}
local bola5 = {}
local bola6 = {}
local bola7 = {}
local bola8 = {}
local bola9 = {}
local bola10 = {}
local bola11 = {}
local bola12 = {}
local bola13 = {}
local bola14 = {}
local bola15 = {}
local bolaComida = {}
local comedor = {}
local maxScore = nil




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
    --INICIALIZA AS BOLAS
    bolaComida = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(2, 12)}
    bola1 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 9)}
    bola2 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(2, 7)}
    bola3 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 9)}
    bola4 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(3, 6)}
    bola5 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(7, 9)}
    bola6 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 8)} 
    bola7 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(5, 10)}
    bola8 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(6, 11)}
    bola9 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(5, 11)} 
    bola10 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(5, 11)}
    bola11 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(6, 13)}
    bola12 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(7, 11)} 
    bola13 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(8, 10)}
    bola14 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(3, 15)}
    bola15 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 12)} 


    --INICIALIZA O COMEDOR
    comedor = {posX = 0, posY = 575, largura = 50, altura = 25}
    love.mouse.setVisible(false) --desativa o mouse dentro da janela do jogo
    


end

function love.update(dt)
    if(perdeu == false) then
        atualizaBola(bola1, comedor)
        atualizaBola(bola2, comedor)
        atualizaBola(bola3, comedor)
        atualizaBola(bola4, comedor)
        atualizaBola(bola5, comedor)
        atualizaBola(bola6, comedor)
        atualizaBola(bola7, comedor)
        atualizaBola(bola8, comedor)
        atualizaBola(bola9, comedor)
        atualizaBola(bola10, comedor)
        atualizaBola(bola11, comedor)
        atualizaBola(bola12, comedor)
        atualizaBola(bola13, comedor)
        atualizaBola(bola14, comedor)
        atualizaBola(bola15, comedor)
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
        love.graphics.print("PRESSIONE ESPAÇO PARA INICIAR", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2)
        if(love.keyboard.isDown("space")) then 
            menuInicialAtivo = false
        end
    elseif(perdeu == true) then
        musicaTema:stop()
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
        love.graphics.circle("fill", bola1.x, bola1.y, bola1.raio)
        love.graphics.circle("fill", bola2.x, bola2.y, bola2.raio)
        love.graphics.circle("fill", bola3.x, bola3.y, bola3.raio)
        love.graphics.circle("fill", bola4.x, bola4.y, bola4.raio)        
        love.graphics.circle("fill", bola5.x, bola5.y, bola5.raio) --pintando uma bola de amarelho, pois essa é a comida
        love.graphics.circle("fill", bola6.x, bola6.y, bola6.raio)
        love.graphics.circle("fill", bola7.x, bola7.y, bola7.raio)
        love.graphics.circle("fill", bola8.x, bola8.y, bola8.raio)
        love.graphics.circle("fill", bola9.x, bola9.y, bola9.raio)
        love.graphics.circle("fill", bola10.x, bola10.y, bola10.raio)  
        love.graphics.circle("fill", bola11.x, bola11.y, bola11.raio)
        love.graphics.circle("fill", bola12.x, bola12.y, bola12.raio)
        love.graphics.circle("fill", bola13.x, bola13.y, bola13.raio)
        love.graphics.circle("fill", bola14.x, bola14.y, bola14.raio)
        love.graphics.circle("fill", bola15.x, bola15.y, bola15.raio) 
        love.graphics.rectangle("fill", comedor.posX, comedor.posY, comedor.largura, comedor.altura)
        love.graphics.print("Pontuação: " .. score, 0, 0)
        love.graphics.print("Vidas: " .. vidas, love.graphics.getWidth()/2 - 100, 0)
    end
end
