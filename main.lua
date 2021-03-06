local score = nil
local vidas = nil
local background = nil
local playOnce = true
local comedor = {}
local maxScore = nil
local fontePrincipal = "assets/fonts/acme.ttf"
local bolas = {}
local bolasAmarelas = {}
local numeroDeBolasAmarelas = nil
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
    for i=1, numeroDeBolasAmarelas, 1 do
        if(bolasAmarelas[i].y >= 599) then
            bolasAmarelas[i].y = 0
            bolasAmarelas[i].x = math.random(2, 799)
        else
            bolasAmarelas[i].y = bolasAmarelas[i].y + bolasAmarelas[i].f
        end

        if(bolasAmarelas[i].y >= 575 and (bolasAmarelas[i].x >= comedor.posX and bolasAmarelas[i].x <= comedor.posX + 50)) then
            bolasAmarelas[i].y = 0
            bolasAmarelas[i].x = math.random(2, 799)
            bolasAmarelas[i].f = math.random(5, 15)
            vidas = vidas + 1 -- atualiza o score caso o comedor coma a bola
            somComeu:play()
        end
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
    numeroDeBolasAmarelas = 10
    --CARREGANDO IMAGENS
    background = love.graphics.newImage("assets/img/ceu.png")
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
    for i=1, numeroDeBolasAmarelas, 1 do
        bolasAmarelas[i] = {}
    end
    --INICIALIZA AS BOLAS
    for i=1, numeroDeBolasAmarelas, 1 do 
        bolasAmarelas[i] = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 8)}
    end
    for i=1,15 do
        bolas[i].raio = 10
        bolas[i].x = math.random(1, 790)
        bolas[i].y = 0
        bolas[i].f = math.random(5, 10)
    end

    --INICIALIZA O COMEDOR
    comedor = {posX = 0, posY = 575, largura = 50, altura = 25}
    love.mouse.setVisible(false) --desativa o mouse dentro da janela do jogo
end

function love.update(dt)
    if(perdeu == false and menuInicialAtivo == false) then
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
        love.graphics.setFont(love.graphics.newFont(fontePrincipal, 25))
        love.graphics.setColor(255, 255, 0) -- definindo a cor amarela para o texto
        love.graphics.print("PRESSIONE ESPAÇO PARA INICIAR", love.graphics.getWidth()/2 - 200, love.graphics.getHeight()/2)
        love.graphics.setColor(255, 255, 255) -- resetando a cor
        if(love.keyboard.isDown("space")) then 
            menuInicialAtivo = false
        end
    elseif(perdeu == true) then
        musicaTema:stop()
        love.graphics.setFont(love.graphics.newFont(fontePrincipal, 25))
        love.graphics.setColor(255, 255, 0) -- definindo a cor amarela para o texto
        love.graphics.print("VOCÊ PERDEU! PRESSIONE ESPAÇO PARA INICIAR NOVAMENTE.", love.graphics.getHeight()/2 - 295, love.graphics.getWidth()/2 - 140)
        love.graphics.setColor(255, 255, 255) -- resetando a cor
        reproduzSomDaDerrota()
        
        for i=1,10,1 do -- assim que o jogo finalizar, todas as bolas devem voltar para o topo, para que, assim que o jogo iniciar novamente, elas não estejam no meio ou em qualquer ponto do eixo y a não ser a origem
            bolas[i].y = 0
        end

        if(love.keyboard.isDown("space")) then 
            score = 0 --
            playOnce = true
            perdeu = false
            vidas = 3
        end
    else 
        musicaTema:play()
        musicaTema:setLooping(true)
        love.graphics.setColor(255,255,0) -- definindo a cor amarela para a bola de vida
        for i=1, numeroDeBolasAmarelas, 1 do
            love.graphics.circle("fill", bolasAmarelas[i].x, bolasAmarelas[i].y, bolasAmarelas[i].raio)
        end
        love.graphics.setColor(0, 0, 0) -- definindo a cor verde para as bolas da morte
        for i=1,15 do
            love.graphics.circle("fill", bolas[i].x, bolas[i].y, bolas[i].raio)
        end
        love.graphics.setColor(255, 255, 255) --voltando à cor padrão
        love.graphics.rectangle("fill", comedor.posX, comedor.posY, comedor.largura, comedor.altura)
        love.graphics.print("Pontuação: " .. score, 0, 0)
        love.graphics.print("Vidas: " .. vidas, love.graphics.getWidth()/2 - 100, 0)
    end
end
