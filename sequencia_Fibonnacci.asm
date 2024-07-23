.data
msg1: .asciiz "Digite o enésimo termo da sequência de Fibonacci que você gostaria de saber: "
msg2: .asciiz "O enésimo termo da sequência de Fibonacci é: "

.text
main:
    # Imprimir pergunta sobre o enésimo termo
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg1         # Endereço da mensagem msg1
    syscall              # Executa o syscall

    # Ler o número
    li $v0, 5            # Código do syscall para ler inteiro
    syscall              # Executa o syscall
    move $t0, $v0        # Move o número digitado para $t0 (armazenará o valor N)

    # Inicializa as variáveis
    li $t1, 0            # F(0) = 0
    li $t2, 1            # F(1) = 1

    # Verificar se N é 0 ou 1
    beq $t0, $zero, print_result_zero # Se N == 0, ir para print_result_zero
    li $t3, 1
    beq $t0, $t3, print_result_one    # Se N == 1, ir para print_result_one

    # Calcular o enésimo termo da sequência de Fibonacci
    li $t4, 2            # Inicializa o contador com 2 (começa do terceiro termo)

fib_loop: 
    bge $t4, $t0, print_result # Se contador >= N, ir para print_result
    add $t3, $t1, $t2    # F(n) = F(n-1) + F(n-2)

    # Atualiza as variáveis
    move $t1, $t2        # F(n-1) = F(n-2)
    move $t2, $t3        # F(n) = F(n-1)

    addi $t4, $t4, 1     # Incrementa o contador
    j fib_loop           # Volta para o início do loop

# Imprime a mensagem de saída do enésimo termo
print_result:
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg2         # Endereço da mensagem msg2
    syscall              # Executa o syscall

    # Imprime o termo N da sequência de Fibonacci
    move $a0, $t2        # Move o valor do termo em $a0
    li $v0, 1            # Código do syscall para imprimir inteiro
    syscall              # Executa o syscall

    # Finaliza o programa
    li $v0, 10           # Código do syscall para finalizar o programa
    syscall              # Executa o syscall

# Caso N seja 0
print_result_zero:
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg2         # Endereço da mensagem msg2
    syscall              # Executa o syscall

    li $a0, 0            # Move o valor 0 para $a0
    li $v0, 1            # Código do syscall para imprimir inteiro
    syscall              # Executa o syscall

    # Finaliza o programa
    li $v0, 10           # Código do syscall para finalizar o programa
    syscall              # Executa o syscall

# Caso N seja 1
print_result_one:
    li $v0, 4            # Código do syscall para imprimir string
    la $a0, msg2         # Endereço da mensagem msg2
    syscall              # Executa o syscall

    li $a0, 1            # Move o valor 1 para $a0
    li $v0, 1            # Código do syscall para imprimir inteiro
    syscall              # Executa o syscall

    # Finaliza o programa
    li $v0, 10           # Código do syscall para finalizar o programa
    syscall              # Executa o syscall
