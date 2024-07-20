.data
F1: .float 32.0        # Valor 32.0 para subtrair
F2: .float 5.0         # Fator multiplicativo 5.0
F3: .float 9.0         # Divisor 9.0
request_msg: .asciiz "Indique a temperatura em Fahrenheit: "    
final_msg: .asciiz "A temperatura em Celsius é: "             

.text
main:
	li $v0, 4             # Chamada do sistema para imprimir uma string
	la $a0, request_msg   # Carrega o endereço da mensagem request_msg em $a0
	syscall               # Imprime a mensagem
	
	li $v0, 6             # Chamada do sistema para ler um número de ponto flutuante
	syscall               # Lê a temperatura em Fahrenheit e armazena em $f0
	
	lwc1 $f1, F1          # Carrega o valor 32.0 em $f1
	sub.s $f2, $f0, $f1   # $f2 = $f0 - 32.0
	
	lwc1 $f3, F2          # Carrega o valor 5.0 em $f3
	mul.s $f4, $f3, $f2   # $f4 = 5.0 * $f2
	
	lwc1 $f5, F3          # Carrega o valor 9.0 em $f5
	div.s $f6, $f4, $f5   # $f6 = $f4 / 9.0
	
	li $v0, 4             # Chamada do sistema para imprimir uma string
	la $a0, final_msg     # Carrega o endereço da mensagem final_msg em $a0
	syscall               # Imprime a mensagem
	
	li $v0, 2             # Chamada do sistema para imprimir um número de ponto flutuante
	mov.s $f12, $f6       # Move o valor de $f6 para $f12
	syscall               # Imprime a temperatura em Celsius
