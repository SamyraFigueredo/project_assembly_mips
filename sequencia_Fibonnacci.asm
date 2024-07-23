.data
msg1: .asciiz "Digite o enésimo termo da sequência de Fibonacci que você gostaria de saber: "
msg2: .asciiz "O enésimo termo da sequência de Fibonacci é: "

.text
main:
    # Imprimir mensagem para entrada
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg1         # Endereço da mensagem msg1
    syscall              # Executa o syscall

    # Ler o número
    li $v0, 5            # Código do syscall para ler inteiro
    syscall              # Executa o syscall
    move $t0, $v0        # Move o número digitado para $t0 (armazenará o valor N)

    # Inicializar variáveis
    li $t1, 0            # F(0) = 0
    li $t2, 1            # F(1) = 1
    li $t3, 1            # Contador inicializado com 1

    # Se n for 0 ou 1, imprimir o resultado diretamente
    bne $t0, $zero, check_one
    j print_fib_0

check_one:
    bne $t0, $t3, fib_loop
    j print_fib_1

fib_loop:
    # Loop para calcular o enésimo termo
    bge $t3, $t0, print_fib
    add $t4, $t1, $t2    # t4 = F(n-1) + F(n-2)
    move $t1, $t2        # F(n-2) = F(n-1)
    move $t2, $t4        # F(n-1) = F(n)
    addi $t3, $t3, 1     # Incrementa o contador
    j fib_loop

print_fib:
    # Imprimir mensagem de saída do enésimo termo
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg2         # Endereço da mensagem msg2
    syscall              # Executa o syscall

    # Imprimir o termo N da sequência de Fibonacci
    move $a0, $t2        # Move o valor do termo em $a0
    li $v0, 1            # Código do syscall para imprimir inteiro
    syscall              # Executa o syscall

    # Finaliza o programa
    li $v0, 10           # Código do syscall para finalizar o programa
    syscall              # Executa o syscall

print_fib_0:
    # Imprimir mensagem de saída do enésimo termo para N = 0
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg2         # Endereço da mensagem msg2
    syscall              # Executa o syscall

    li $a0, 0            # Move o valor 0 para $a0
    li $v0, 1            # Código do syscall para imprimir inteiro
    syscall              # Executa o syscall

    # Finaliza o programa
    li $v0, 10           # Código do syscall para finalizar o programa
    syscall              # Executa o syscall

print_fib_1:
    # Imprimir mensagem de saída do enésimo termo para N = 1
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg2         # Endereço da mensagem msg2
    syscall              # Executa o syscall

    li $a0, 1            # Move o valor 1 para $a0
    li $v0, 1            # Código do syscall para imprimir inteiro
    syscall              # Executa o syscall

    # Finaliza o programa
    li $v0, 10           # Código do syscall para finalizar o programa
    syscall              # Executa o syscall
