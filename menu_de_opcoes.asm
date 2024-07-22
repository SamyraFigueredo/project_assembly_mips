.data
# Mensagens
msg1: .asciiz "Escolha uma opção:\n1. Converter Fahrenheit para Celsius\n2. Calcular o enésimo termo da sequência de Fibonacci\n3. Encontrar o enésimo número par\n4. Sair\nDigite a opção desejada: "
msg2: .asciiz "Digite o valor : "
msg3: .asciiz "A temperatura em Celsius é: "
msg4: .asciiz "O enésimo termo da sequência de Fibonacci é: "
msg5: .asciiz "O enésimo número par é: "
msg6: .asciiz "Esse número não é par\n"
msg7: .asciiz "Número inválido\n"
newline: .asciiz "\n"

# Dados para conversão Fahrenheit para Celsius
F1: .float 32.0
F2: .float 5.0
F3: .float 9.0

.text
main:
    # Imprimir menu de opções
    li $v0, 4           # Imprimir string
    la $a0, msg1        # Endereço do menu
    syscall

    # Ler a opção escolhida
    li $v0, 5           # Ler inteiro
    syscall
    move $t0, $v0       # Opção escolhida

    # Verificar a opção
    beq $t0, 1, convert_fahrenheit
    beq $t0, 2, calculate_fibonacci
    beq $t0, 3, find_even
    beq $t0, 4, exit_program

    # Opção inválida
    li $v0, 4           # Imprimir string
    la $a0, msg7        # Mensagem de erro
    syscall
    j main              # Voltar ao menu

convert_fahrenheit:
    # Imprimir mensagem para entrada
    li $v0, 4
    la $a0, msg2
    syscall

    # Ler o valor em Fahrenheit
    li $v0, 6           # Ler número de ponto flutuante
    syscall
    mov.s $f0, $f0      # Armazena o valor lido em $f0

    # Realizar a conversão de Fahrenheit para Celsius
    l.s $f1, F1         # Carrega 32.0 em $f1
    sub.s $f2, $f0, $f1 # $f2 = $f0 - 32.0
    l.s $f3, F2         # Carrega 5.0 em $f3
    mul.s $f4, $f3, $f2 # $f4 = 5.0 * $f2
    l.s $f5, F3         # Carrega 9.0 em $f5
    div.s $f6, $f4, $f5 # $f6 = $f4 / 9.0

    # Imprimir resultado
    li $v0, 4
    la $a0, msg3
    syscall
    li $v0, 2           # Imprimir número de ponto flutuante
    mov.s $f12, $f6
    syscall

    # Imprimir quebra de linha
    li $v0, 4
    la $a0, newline
    syscall

    # Voltar para o menu principal
    j main

calculate_fibonacci:
    # Imprimir mensagem para entrada
    li $v0, 4
    la $a0, msg2
    syscall

    # Ler o número
    li $v0, 5
    syscall
    move $t0, $v0

    # Inicializar variáveis
    li $t1, 0
    li $t2, 1
    beq $t0, $t1, print_fib_0
    li $t3, 1
    beq $t0, $t3, print_fib_1

    li $t4, 2

fib_loop:
    bge $t4, $t0, print_fib
    add $t3, $t1, $t2
    move $t1, $t2
    move $t2, $t3
    addi $t4, $t4, 1
    j fib_loop

print_fib:
    # Imprimir resultado
    li $v0, 4
    la $a0, msg4
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir quebra de linha
    li $v0, 4
    la $a0, newline
    syscall

    # Voltar para o menu principal
    j main

print_fib_0:
    li $v0, 4
    la $a0, msg4
    syscall
    li $a0, 0
    li $v0, 1
    syscall

    # Imprimir quebra de linha
    li $v0, 4
    la $a0, newline
    syscall

    # Voltar para o menu principal
    j main

print_fib_1:
    li $v0, 4
    la $a0, msg4
    syscall
    li $a0, 1
    li $v0, 1
    syscall

    # Imprimir quebra de linha
    li $v0, 4
    la $a0, newline
    syscall

    # Voltar para o menu principal
    j main

find_even:
    # Imprimir mensagem para entrada
    li $v0, 4
    la $a0, msg2
    syscall

    # Ler o número
    li $v0, 5
    syscall
    move $t0, $v0

    # Verificar se é par
    andi $t1, $t0, 1
    bne $t1, $zero, not_even

    # Calcular o enésimo número par
    li $t1, 2
    mul $t2, $t1, $t0

    # Imprimir resultado
    li $v0, 4
    la $a0, msg5
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir quebra de linha
    li $v0, 4
    la $a0, newline
    syscall

    # Voltar para o menu principal
    j main

not_even:
    # Imprimir mensagem de número não par
    li $v0, 4
    la $a0, msg6
    syscall

    # Imprimir quebra de linha
    li $v0, 4
    la $a0, newline
    syscall

    # Voltar para o menu principal
    j main

exit_program:
    # Finaliza o programa
    li $v0, 10          # Código para sair do programa
    syscall
