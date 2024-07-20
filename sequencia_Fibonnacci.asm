.data
msg1: .asciiz "Digite o enésimo termo da sequência de Fibonacci que você gostaria de saber: "
msg2: .asciiz "O enésimo termo da sequência de Fibonacci é: "

.text
main:
    # Imprimir pergunta sobre o enésimo termo
    li $v0, 4        # Carrega o valor 4 no registrador $v0 (código do syscall para imprimir string)
    la $a0, msg1     # Carrega o endereço da mensagem msg1 no registrador $a0 (argumento para syscall)
    syscall          # Executa a syscall para imprimir a mensagem

    # Ler o número
    li $v0, 5        # Carrega o valor 5 no registrador $v0 (código do syscall para ler inteiro)
    syscall          # Executa a syscall para ler o número digitado pelo usuário
                     # O valor digitado será armazenado no registrador $v0

    # Inicializando as variáveis
    move $t0, $v0    # Move o valor digitado para o registrador $t0 (armazenará o valor N)
    li $t1, 0        # Inicializa $t1 com zero (F(0) = 0)
    li $t2, 1        # Inicializa $t2 com um (F(1) = 1)
    li $t4, 2        # Inicializa $t4 com dois (contador começando do terceiro termo)

    # Verificar se N é 0 ou 1
    beq $t0, $zero, print_result_zero # Se N for 0, imprime 0
    li $t3, 1
    beq $t0, $t3, print_result_one    # Se N for 1, imprime 1

    # Calcular o enésimo termo da sequência de Fibonacci
fib_loop:
    bge $t4, $t0, print_result # Se contador >= N, sai do loop

    add $t3, $t1, $t2          # F(n) = F(n-1) + F(n-2)

    # Atualizando as variáveis
    move $t1, $t2              # F(n-1) = F(n-2)
    move $t2, $t3              # F(n) = F(n-1)

    # Incrementando o contador
    addi $t4, $t4, 1           # Incrementa o contador
    j fib_loop                 # Volta para o início do loop

# Imprime a mensagem de saída do enésimo termo
print_result:
    li $v0, 4            # Carrega o valor 4 no registrador $v0 (código do syscall para imprimir string)
    la $a0, msg2         # Carrega o endereço da mensagem msg2 no registrador $a0 (argumento para syscall)
    syscall              # Executa a syscall para imprimir a mensagem

    # Imprime o termo N da sequência de Fibonacci
    move $a0, $t2        # Move o valor do enésimo termo para o registrador $a0
    li $v0, 1            # Carrega o valor 1 no registrador $v0 (código do syscall para imprimir inteiro)
    syscall              # Executa a syscall para imprimir o inteiro

    # Finaliza o programa
    li $v0, 10           # Carrega o valor 10 no registrador $v0 (código do syscall para finalizar o programa)
    syscall              # Executa a syscall para finalizar o programa

# Caso N seja 0
print_result_zero:
    li $v0, 4            # Carrega o valor 4 no registrador $v0 (código do syscall para imprimir string)
    la $a0, msg2         # Carrega o endereço da mensagem msg2 no registrador $a0 (argumento para syscall)
    syscall              # Executa a syscall para imprimir a mensagem

    li $a0, 0            # Move o valor 0 para o registrador $a0
    li $v0, 1            # Carrega o valor 1 no registrador $v0 (código do syscall para imprimir inteiro)
    syscall              # Executa a syscall para imprimir o inteiro

    # Finaliza o programa
    li $v0, 10           # Carrega o valor 10 no registrador $v0 (código do syscall para finalizar o programa)
    syscall              # Executa a syscall para finalizar o programa

# Caso N seja 1
print_result_one:
    li $v0, 4            # Carrega o valor 4 no registrador $v0 (código do syscall para imprimir string)
    la $a0, msg2         # Carrega o endereço da mensagem msg2 no registrador $a0 (argumento para syscall)
    syscall              # Executa a syscall para imprimir a mensagem

    li $a0, 1            # Move o valor 1 para o registrador $a0
    li $v0, 1            # Carrega o valor 1 no registrador $v0 (código do syscall para imprimir inteiro)
    syscall              # Executa a syscall para imprimir o inteiro

    # Finaliza o programa
    li $v0, 10           # Carrega o valor 10 no registrador $v0 (código do syscall para finalizar o programa)
    syscall              # Executa a syscall para finalizar o programa
