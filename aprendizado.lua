--[==[function desenhaQuadrado(modo, x, y, tam)
    love.graphics.rectangle(modo, x, y, tam, tam)
end

function desenhaCirculo(modo, x, y, tam)
    love.graphics.circle(modo, x, y, tam)
end

function love.draw() --função callback chamada pelo Love a cada frame para a execução de desenhos
    --love.graphics.rectangle(mode, x, y, width, height, rx, ry, segments)
    --mode -> indica se o retangulo será preenchido ou não e pode ser 'fill' ou 'line'
    --x -> posição no eixo X
    --y -> posição no eixo y
    --width -> largura
    --height -> altura
    --rx e ry-> definem o quanto o retangulo pode ficar arredondado
    --segmentos -> numero de segmentos usados para desenhar os cantos arredondados. Caso não seja colocado nenhum valor, o valor usado será o padrão
    --os tres últimos parâmetros são opcionais
    love.graphics.rectangle("fill", 20, 50, 60, 120) --desenha um retângulo na tela
    love.graphics.rectangle("line", 150, 50, 60, 120)

    love.graphics.setColor(255, 0, 0) --define a cor dos desenhos

    love.graphics.rectangle("fill", 20, 180, 60, 120)
    love.graphics.rectangle("line", 150, 180, 60, 120)

    love.graphics.setColor(255, 255, 255)

    love.graphics.rectangle("fill", 20, 310, 60, 120, 10, 10)
    love.graphics.rectangle("line", 150, 310, 60, 120, 10, 10)

    desenhaQuadrado("line", 400, 240, 80)
    
    love.graphics.setColor(0, 0, 255)
    desenhaCirculo("fill", 200, 200, 50)
    love.graphics.setColor(255, 255, 255)

    --love.graphics.polygon(mode, vertices)
    local vertices = {400, 400, 500, 400, 450, 500}
    love.graphics.polygon("fill", vertices)
end
]==]

function arquivo()
    nomeArquivo = "pontuacao.txt"
    arquivo = assert(io.open(nomeArquivo, "w"), "arquivo não pode ser criado")
    arquivo:write("ok\n")
    arquivo:flush()
    io.close(arquivo)
end

