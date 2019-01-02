class Heroi
    attr_accessor :linha, :coluna

    def calcula_nova_posicao(movimento)
        novo_heroi = self.dup
        movimentos = {
            "W" => [-1, 0],
            "S" => [1, 0],
            "A" => [0, -1],
            "D" => [0, 1]
        }
        direcao = movimentos[movimento]
        novo_heroi.linha += direcao[0]
        novo_heroi.coluna += direcao[1]
        novo_heroi
    end

    def direita
        calcula_nova_posicao "D"
    end

    def esquerda
        calcula_nova_posicao "A"
    end

    def cima
        calcula_nova_posicao "W"
    end

    def baixo
        calcula_nova_posicao "S"
    end

    def to_array
        return [linha, coluna]
    end

    def remove_do_mapa(mapa)
        mapa[linha][coluna] = " "
    end

    def coloca_no_mapa(mapa)
        mapa[linha][coluna] = "H"
    end
end