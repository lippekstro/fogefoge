def da_boas_vindas
    puts "Bem vindo ao Foge-Foge"
    puts "Qual é o seu nome? "
    nome = gets.strip
    puts "\n\n"
    puts "Comecaremos o jogo para voce, #{nome}"
    nome
end

def desenha(mapa)
    puts mapa
end

def pede_movimento
    puts "Para onde deseja ir? "
    movimento = gets.strip.upcase
    movimento
end

def game_over
    puts "\n\n"
    puts "GAME OVER"
end