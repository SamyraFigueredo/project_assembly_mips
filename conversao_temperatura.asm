.data
F1: .float 32.0                # Valor 32.0
F2: .float 5.0                 # Valor 5.0
F3: .float 9.0                 # Valor 9.0
F4: .float 1.8                 # Valor 1.8 (1.8 = 9.0 / 5.0)
menu_msg: .asciiz "1: Converter de Fahrenheit para Celsius\n2: Converter de Celsius para Fahrenheit\n3: Sair\nEscolha uma opcao: "
request_f_msg: .asciiz "Indique a temperatura em Fahrenheit: "
request_c_msg: .asciiz "Indique a temperatura em Celsius: "
final_c_msg: .asciiz "A temperatura em Celsius é: "
final_f_msg: .asciiz "A temperatura em Fahrenheit é: "

.text
main:
    # Exibir o menu
    li $v0, 4                  # Chamada para imprimir string
    la $a0, menu_msg           # Carregar mensagem do menu
    syscall                    # Imprimir mensagem

    # Ler a opção do usuário
    li $v0, 5                  # Chamada para ler inteiro
    syscall                    # Ler a opção
    move $t0, $v0              # Armazenar a opção em $t0

    # Verificar a opção escolhida
    beq $t0, 1, option1        # Se $t0 == 1, vai para opção 1
    beq $t0, 2, option2        # Se $t0 == 2, vai para opção 2
    beq $t0, 3, exit           # Se $t0 == 3, vai para sair

    # Voltar ao início se a opção não for válida
    j main                     # Voltar ao menu

option1:                       # Converter de Fahrenheit para Celsius
    li $v0, 4                  # Chamada para imprimir string
    la $a0, request_f_msg      # Carregar mensagem de solicitação
    syscall                    # Imprimir mensagem

    li $v0, 6                  # Chamada para ler número de ponto flutuante
    syscall                    # Ler a temperatura em Fahrenheit e armazenar em $f0

    # Cálculo: (Fahrenheit - 32) * 5 / 9
    lwc1 $f1, F1               # Carregar 32.0 em $f1
    sub.s $f2, $f0, $f1        # $f2 = Fahrenheit - 32.0

    lwc1 $f3, F2               # Carregar 5.0 em $f3
    mul.s $f4, $f3, $f2        # $f4 = $f2 * 5.0

    lwc1 $f5, F3               # Carregar 9.0 em $f5
    div.s $f6, $f4, $f5        # $f6 = $f4 / 9.0

    # Exibir resultado
    li $v0, 4                  # Chamada para imprimir string
    la $a0, final_c_msg        # Carregar mensagem final
    syscall                    # Imprimir mensagem

    li $v0, 2                  # Chamada para imprimir número de ponto flutuante
    mov.s $f12, $f6            # Mover resultado para $f12
    syscall                    # Imprimir temperatura em Celsius

    j main                     # Voltar ao menu

option2:                       # Converter de Celsius para Fahrenheit
    li $v0, 4                  # Chamada para imprimir string
    la $a0, request_c_msg      # Carregar mensagem de solicitação
    syscall                    # Imprimir mensagem

    li $v0, 6                  # Chamada para ler número de ponto flutuante
    syscall                    # Ler a temperatura em Celsius e armazenar em $f0

    # Cálculo: (Celsius * 1.8) + 32
    lwc1 $f1, F4               # Carregar 1.8 em $f1
    mul.s $f2, $f0, $f1        # $f2 = Celsius * 1.8

    lwc1 $f3, F1               # Carregar 32.0 em $f3
    add.s $f4, $f2, $f3        # $f4 = $f2 + 32.0

    # Exibir resultado
    li $v0, 4                  # Chamada para imprimir string
    la $a0, final_f_msg        # Carregar mensagem final
    syscall                    # Imprimir mensagem

    li $v0, 2                  # Chamada para imprimir número de ponto flutuante
    mov.s $f12, $f4            # Mover resultado para $f12
    syscall                    # Imprimir temperatura em Fahrenheit

    j main                     # Voltar ao menu

exit:                          # Sair
    li $v0, 10                 # Chamada para sair do programa
    syscall                    # Sair
