.data

msg1: .asciiz "Digite o enésimo número par que você gostaria de saber:  "
msg2: .asciiz "O enésimo termo par é: "
msg3: .asciiz "Esse número não é par"

.text

main:
    # Imprimir pergunta sobre o enésimo termo par
    li $v0, 4           # Carrega o valor 4 em $v0 para realizar a chamada do sistema para imprimir uma string
    la $a0, msg1        # Carrega o endereço da mensagem msg1 em $a0 para ser impressa
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Ler o número 
    li $v0, 5           # Carrega o valor 5 em $v0 para realizar a chamada do sistema para ler um inteiro
    syscall             # Realiza a chamada do sistema para ler o número digitado pelo usuário e armazenar em $v0
    move $t0, $v0       # Move o valor digitado para $t0 para ser usado no cálculo

    # Verificar se o número é par
    andi $t1, $t0, 1    # Realiza uma operação AND entre o número digitado ($t0) e 1, o resultado vai em $t1
    bne $t1, $zero, not_even # Se $t1 não for zero, o número é ímpar; pular para not_even

    # Calculando o enésimo número par
    li $t1, 2           # Inicializa $t1 com 2, que é o primeiro número par
    mul $t2, $t1, $t0   # Multiplica $t1 (2) pelo valor digitado ($t0) para obter o enésimo número par

    # Imprimir mensagem sobre qual é o enésimo termo par
    li $v0, 4           # Carrega o valor 4 em $v0 para realizar a chamada do sistema para imprimir uma string
    la $a0, msg2        # Carrega o endereço da mensagem msg2 em $a0 para ser impressa
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Imprimir qual é o enésimo número par
    li $v0, 1           # Carrega o valor 1 em $v0 para realizar a chamada do sistema para imprimir um inteiro
    move $a0, $t2       # Move o valor do enésimo número par ($t2) para $a0 para ser impresso
    syscall             # Realiza a chamada do sistema para imprimir o enésimo número par

    # Finaliza o programa
    li $v0, 10          # Código de syscall para finalizar o programa
    syscall             # Executa o syscall para encerrar o programa

not_even:
    # Imprimir mensagem de número não par
    li $v0, 4           # Carrega o valor 4 em $v0 para realizar a chamada do sistema para imprimir uma string
    la $a0, msg3        # Carrega o endereço da mensagem msg3 em $a0 para ser impressa
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Finaliza o programa
    li $v0, 10          # Código de syscall para finalizar o programa
    syscall             # Executa o syscall para encerrar o programa
