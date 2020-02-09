.text
# s4 vetor cobra 
right:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00010000 # valor um na coordenada x
	add a0, a0, t0 	# adiciona 1 a cordenada x da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca

	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop
########################################################################################################################
down:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00000001 # valor um na coordenada y
	add a0, a0, t0 	# adiciona 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop
########################################################################################################################
up:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00000001 # valor um na coordenada y
	sub a0, a0, t0 	# subtrai 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop
########################################################################################################################
left:	addi sp, sp, -20	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)

	li s1, 0	# Contador inicia em 0
	
	addi a0, s4, 4	# pega endereco do rabo da cobra
	lw a0, (a0) 	# carrega valor do rabo
	li a1, 0x00228B22	# cor de fundo
	jal Ponto 	# apaga rabo da cobra
	
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add a0, s4, s0 	# pega o endereco da cabeca da cobra
	lw a0, (a0)
	li t0, 0x00010000 # valor um na coordenada y
	sub a0, a0, t0 	# subtrai 1 a cordenada y da cabeca da cobra
	add s2, a0, zero # coordenada da nova cabeca
	
	add s3, s4, s0 # ultimo endereco do vetor
	li a1, 0x0000	# cor preta
	jal Ponto
	
	addi s0, s0, -4 # faz o loop n?o pegar valores de endereco indevido
	jal directionLoop
###########################################################################################################
directionLoop:	beq s0, s1, endDirectionLoop
		addi s1, s1, 8
		add a0, s4, s1 # endereco de cada ponto
		addi a1, a0, -4
		lw a0, (a0)
		sw a0, (a1)
		addi s1, s1, -4
		j directionLoop
		
endDirectionLoop:	sw s2, (s3)
			lw ra, 0(sp)
			lw s0, 4(sp)
			lw s1, 8(sp)
			lw s2, 12(sp)
			lw s3, 16(sp)
			addi sp, sp, 16
			ret	
###########################################################################################################
verificaDireita:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	srli t3, t0, 16 # pega x
	li t1, 0x00000025 # borda direira
	
	bge t3, t1, R1
	blt t3, t1, R2
	R1 : jal LOSE
	R2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret
		
###########################################################################################################
verificaEsquerda:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	srli t3, t0, 16 # pega x
	li t1, 0x00000002 # borda esquerda
	
	ble t3, t1, L1
	bgt t3, t1, L2
	L1 : jal LOSE
	L2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret
###########################################################################################################

verificaAcima:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	li t1, 0x0000FFFF
	and t3, t0, t1
	li t1, 0x00000005 # borda de cima
	
	ble t3, t1, U1
	bgt t3, t1, U2
	U1 : jal LOSE
	U2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret
###########################################################################################################

verificaAbaixo:
	addi sp, sp, -8	# espaco na pilha para registradores salvos e ra
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	jal pegaCabeca
	li t1, 0x0000FFFF
	and t3, t0, t1
	li t1, 0x0000001B # borda de baixo
	
	bge t3, t1, D1
	blt t3, t1, D2
	D1 : jal LOSE
	D2:	lw ra, 0(sp)
		lw s0, 4(sp)
		addi sp, sp, 8
		ret	
###########################################################################################################
		
pegaCabeca:
	lw s0, 0(s4) 	# Carrega tamanho da cobra
	slli s0, s0, 2	# Multiplica por 4
	add t0, s4, s0 	# pega o endereco da cabeca da cobra
	lw t0, (t0) 	# Carrega a coordenada
	ret