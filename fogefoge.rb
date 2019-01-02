require_relative 'ui'
require_relative 'heroi'

def le_mapa(numero)
    arquivo = "mapa#{numero}.txt"
    texto = File.read arquivo
    mapa = texto.split "\n"
end

def encontra_jogador(mapa)
    heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna = linha_atual.index heroi
        if coluna
            jogador = Heroi.new
            jogador.linha = linha
            jogador.coluna = coluna
            return jogador
        end
    end
    nil
end

def posicao_valida?(mapa, posicao)
    linhas = mapa.size
    colunas = mapa[0].size
    estourou_linhas = posicao[0] < 0 || posicao[0] >= linhas
    estourou_colunas = posicao[1] < 0 || posicao[1] >= colunas
   
    if estourou_linhas || estourou_colunas
        return false
    end
    if mapa[posicao[0]][posicao[1]] == "X" || mapa[posicao[0]][posicao[1]] == "F"
        return false
    end
    true
end

def posicoes_validas(mapa, novo_mapa, posicao)
    posicoes = []
    movimentos = [
        [1, 0],
        [0, 1],
        [-1, 0],
        [0, -1]
    ]

    movimentos.each do |movimento|
        nova_posicao = [posicao[0] + movimento[0], posicao[1] + movimento[1]]
        if posicao_valida?(mapa, nova_posicao) && posicao_valida?(novo_mapa, nova_posicao)
            posicoes << nova_posicao
        end
    end
    posicoes
end

def move_fantasma(mapa, novo_mapa, linha, coluna)
    posicoes = posicoes_validas mapa, novo_mapa, [linha, coluna]
    if posicoes.empty?
        return
    end
    aleatorio = rand posicoes.size
    posicao = posicoes[aleatorio]
    mapa[linha][coluna] = " "
    novo_mapa[posicao[0]][posicao[1]] = "F"
end

def copia_mapa(mapa)
    novo_mapa = mapa.join("\n").tr("F", " ").split "\n"
end

def move_fantasmas(mapa)
    fantasma = "F"
    novo_mapa = copia_mapa mapa
    mapa.each_with_index do |linha_atual, linha|
        linha_atual.chars.each_with_index do |caractere_atual, coluna|
            eh_fantasma = caractere_atual == fantasma
            if eh_fantasma
                move_fantasma mapa, novo_mapa, linha, coluna
            end
        end
    end
    novo_mapa
end

def executa_remocao(mapa, posicao, quantidade)
    if mapa[posicao.linha][posicao.coluna] == "X"
        return
    end
    posicao.remove_do_mapa mapa
    remove mapa, posicao, quantidade - 1
end

def remove(mapa, posicao, casas)
    if casas == 0
        return
    end
    executa_remocao(mapa, posicao.direita, casas)
    executa_remocao(mapa, posicao.cima, casas)
    executa_remocao(mapa, posicao.esquerda, casas)
    executa_remocao(mapa, posicao.baixo, casas)
end

def joga(nome)
    mapa = le_mapa 4

    while true
        desenha mapa
        movimento = pede_movimento
        heroi = encontra_jogador mapa
        nova_posicao = heroi.calcula_nova_posicao movimento

        if !posicao_valida? mapa, nova_posicao.to_array
            next
        end
        heroi.remove_do_mapa mapa
        if mapa[nova_posicao.linha][nova_posicao.coluna] == "*"
            for direita in 1..4
                remove mapa, nova_posicao, 4
            end
        end
        nova_posicao.coloca_no_mapa mapa

        mapa = move_fantasmas mapa
        if !encontra_jogador(mapa)
            game_over
            break
        end
    end
end

def inicia
    nome = da_boas_vindas
    joga nome
end