local r = nil
local x = nil
local y = nil
local score = 0
local bola1 = {}
local background = nil
bola2 = {}
bola3 = {}
bola4 = {}
bola5 = {}
bola6 = {}
bola7 = {}
bola8 = {}
bola9 = {}
bola10 = {}
comedor = {}
local menuInicialAtivo = true
local perdeu = false




function atualizaBola(bola)
    if(bola.y >= 599) then
        bola.y = 0
        bola.x = math.random(1, 790)
    else
        bola.y = bola.y + bola.f
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

function perdeu()
    if(score == 400 or score > 400) then
        return true
    end
    return false
end

function love.load()
    math.randomseed(os.time())

    --CARREGANDO IMAGENS
    background = love.graphics.newImage("assets/img/green-back.png")

    --SONS USADOS DENTRO DO JOGO
    musicaTema = love.audio.newSource("assets/songs/song.mp3","static")


    --REPRODUZINDO MÚSICA PRINCIPAL
    --musicaTema:play()
	--musicaTema:setLooping(true)

    --INICIALIZA AS BOLAS
    bola1 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(2, 5)}
    bola2 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(2, 7)}
    bola3 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 9)}
    bola4 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(3, 6)}
    bola5 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(7, 9)}
    bola6 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 8)} 
    bola7 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(5, 10)}
    bola8 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(6, 11)}
    bola9 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(5, 11)} 
    bola10 = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(3, 9)}

    --INICIALIZA O COMEDOR
    comedor = {posX = 0, posY = 575, largura = 50, altura = 25}

    love.mouse.setVisible(false) --desativa o mouse dentro da janela do jogo
   
end


function love.update(dt)
    atualizaBola(bola1)
    atualizaBola(bola2)
    atualizaBola(bola3)
    atualizaBola(bola4)
    atualizaBola(bola5)
    atualizaBola(bola6)
    atualizaBola(bola7)
    atualizaBola(bola8)
    atualizaBola(bola9)
    atualizaBola(bola10)
    if(love.keyboard.isDown("left")) then
        movimentoEsquerda()
    end

    if(love.keyboard.isDown("right")) then 
        movimentoDireita()
    end

    score = score + 1 --atualiza a pontuação

    
    
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    if(menuInicialAtivo == true) then
        love.graphics.print("PRESSIONE ESPAÇO PARA INICIAR", love.graphics.getHeight()/2, love.graphics.getWidth()/2)
        if(love.keyboard.isDown("space")) then 
            menuInicialAtivo = false
        end
    elseif(perdeu() == true) then
        musicaTema:stop()
        love.graphics.print("VOCÊ PERDEU! PRESSIONE ESPAÇO PARA INICIAR NOVAMENTE", love.graphics.getHeight()/2, love.graphics.getWidth()/2)
        if(love.keyboard.isDown("space")) then 
            score = 0 --score maior ou igual a 400 é a condição para que o jogador perca. Portanto, se o score zerar, o jogo reiniciará.
        end
    else 
        musicaTema:play()
	    musicaTema:setLooping(true)
        love.graphics.circle("fill", bola1.x, bola1.y, bola1.raio)
        love.graphics.circle("fill", bola2.x, bola2.y, bola2.raio)
        love.graphics.circle("fill", bola3.x, bola3.y, bola3.raio)
        love.graphics.circle("fill", bola4.x, bola4.y, bola4.raio)
        love.graphics.setColor(255,255,0)
        love.graphics.circle("fill", bola5.x, bola5.y, bola5.raio) --pintando uma bola de amarelho, pois essa é a comida
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", bola6.x, bola6.y, bola6.raio)
        love.graphics.circle("fill", bola7.x, bola7.y, bola7.raio)
        love.graphics.circle("fill", bola8.x, bola8.y, bola8.raio)
        love.graphics.circle("fill", bola9.x, bola9.y, bola9.raio)
        love.graphics.circle("fill", bola10.x, bola10.y, bola10.raio)  
        love.graphics.rectangle("fill", comedor.posX, comedor.posY, comedor.largura, comedor.altura)
        love.graphics.print("Pontuação: " .. score, 0, 0)
    end
end


--largura padrão: 800
--altura padrão: 600
-- love.graphics.getHeight ---> variável que representa a altura da janela
-- love.graphics.getWidth  ---> variável que representa a largura da janela