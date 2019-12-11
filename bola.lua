--CRIA AS BOLAS
function criaBolas()
    bolas = {}
    bolaComida = {}
    for i=1,15 do
        bolas[i] = {}
    end
end

--INICIALIZA AS BOLAS
function inicializaBolas()
    bolaComida = {raio = 10, x = math.random(1, 790), y = 0, f = math.random(4, 8)}
    for i=1,15 do
        bolas[i].raio = 10
        bolas[i].x = math.random(1, 790)
        bolas[i].y = 0
        bolas[i].f = math.random(5, 10)
    end
end