	.file	"mem_management.c"
	.text
.Ltext0:
	.p2align 4
	.type	mem_init, @function
mem_init:
.LFB0:
	.file 1 "./mem/mem_management.c"
	.loc 1 41 27 view -0
	.cfi_startproc
	endbr64
	.loc 1 42 5 view .LVU1
	.loc 1 43 5 view .LVU2
.LVL0:
	.loc 1 43 13 view .LVU3
	.loc 1 41 27 is_stmt 0 view .LVU4
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	mem_dev@GOTPCREL(%rip), %rbx
	.loc 1 41 27 view .LVU5
	xorl	%eax, %eax
.LVL1:
	.p2align 4,,10
	.p2align 3
.L2:
	.loc 1 44 9 is_stmt 1 discriminator 3 view .LVU6
	.loc 1 44 28 is_stmt 0 discriminator 3 view .LVU7
	movq	16(%rbx), %rdx
	movb	$0, (%rdx,%rax)
	.loc 1 43 25 is_stmt 1 discriminator 3 view .LVU8
.LVL2:
	.loc 1 43 13 discriminator 3 view .LVU9
	addq	$1, %rax
.LVL3:
	.loc 1 43 5 is_stmt 0 discriminator 3 view .LVU10
	cmpq	$1048576, %rax
	jne	.L2
	movq	24(%rbx), %rdi
	movl	$65536, %edx
	xorl	%esi, %esi
	call	memset@PLT
.LVL4:
	.loc 1 49 5 is_stmt 1 view .LVU11
	.loc 1 49 20 is_stmt 0 view .LVU12
	movb	$1, 44(%rbx)
	.loc 1 50 1 view .LVU13
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE0:
	.size	mem_init, .-mem_init
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4
	.section	.text.unlikely
.Ltext_cold0:
	.text
	.globl	mem_peruser
	.type	mem_peruser, @function
mem_peruser:
.LFB5:
	.loc 1 120 32 is_stmt 1 view -0
	.cfi_startproc
	endbr64
	.loc 1 121 5 view .LVU15
.LVL5:
	.loc 1 122 5 view .LVU16
	.loc 1 123 5 view .LVU17
	.loc 1 123 15 is_stmt 0 view .LVU18
	movq	mem_dev@GOTPCREL(%rip), %rdx
	movzbl	44(%rdx), %eax
	.loc 1 123 7 view .LVU19
	testb	%al, %al
	je	.L7
.LVL6:
	.loc 1 127 13 is_stmt 1 view .LVU20
	.loc 1 127 22 is_stmt 0 view .LVU21
	movl	36(%rdx), %ecx
	.loc 1 127 5 view .LVU22
	testl	%ecx, %ecx
	je	.L28
	leal	-1(%rcx), %eax
	.loc 1 128 19 view .LVU23
	movq	24(%rdx), %rsi
	cmpl	$6, %eax
	jbe	.L22
	movl	%ecx, %edx
	pxor	%xmm1, %xmm1
	pxor	%xmm2, %xmm2
	movq	%rsi, %rax
	shrl	$3, %edx
	movdqa	.LC0(%rip), %xmm4
	subl	$1, %edx
	salq	$4, %rdx
	leaq	16(%rsi,%rdx), %rdx
.LVL7:
	.p2align 4,,10
	.p2align 3
.L12:
	.loc 1 128 9 is_stmt 1 view .LVU24
	.loc 1 129 13 view .LVU25
	movdqu	(%rax), %xmm0
	addq	$16, %rax
	pcmpeqw	%xmm2, %xmm0
	pandn	%xmm4, %xmm0
	movdqa	%xmm0, %xmm3
	punpckhwd	%xmm2, %xmm0
	punpcklwd	%xmm2, %xmm3
	paddd	%xmm3, %xmm0
	paddd	%xmm0, %xmm1
	.loc 1 127 37 view .LVU26
	.loc 1 127 13 view .LVU27
	cmpq	%rdx, %rax
	jne	.L12
	movdqa	%xmm1, %xmm0
	movl	%ecx, %edx
	psrldq	$8, %xmm0
	andl	$-8, %edx
	paddd	%xmm0, %xmm1
	movdqa	%xmm1, %xmm0
	psrldq	$4, %xmm0
	paddd	%xmm0, %xmm1
	movd	%xmm1, %eax
	testb	$7, %cl
	je	.L13
.L11:
.LVL8:
	.loc 1 128 9 view .LVU28
	.loc 1 128 26 is_stmt 0 view .LVU29
	movl	%edx, %edi
	.loc 1 129 16 view .LVU30
	cmpw	$1, (%rsi,%rdi,2)
	.loc 1 127 38 view .LVU31
	leal	1(%rdx), %edi
	.loc 1 129 16 view .LVU32
	sbbl	$-1, %eax
.LVL9:
	.loc 1 127 37 is_stmt 1 view .LVU33
	.loc 1 127 13 view .LVU34
	.loc 1 127 5 is_stmt 0 view .LVU35
	cmpl	%ecx, %edi
	jnb	.L13
	.loc 1 128 9 is_stmt 1 view .LVU36
	.loc 1 129 16 is_stmt 0 view .LVU37
	cmpw	$1, (%rsi,%rdi,2)
	.loc 1 127 38 view .LVU38
	leal	2(%rdx), %edi
.LVL10:
	.loc 1 129 16 view .LVU39
	sbbl	$-1, %eax
.LVL11:
	.loc 1 127 37 is_stmt 1 view .LVU40
	.loc 1 127 13 view .LVU41
	.loc 1 127 5 is_stmt 0 view .LVU42
	cmpl	%edi, %ecx
	jbe	.L13
	.loc 1 128 9 is_stmt 1 view .LVU43
	.loc 1 129 16 is_stmt 0 view .LVU44
	cmpw	$1, (%rsi,%rdi,2)
	.loc 1 127 38 view .LVU45
	leal	3(%rdx), %edi
.LVL12:
	.loc 1 129 16 view .LVU46
	sbbl	$-1, %eax
.LVL13:
	.loc 1 127 37 is_stmt 1 view .LVU47
	.loc 1 127 13 view .LVU48
	.loc 1 127 5 is_stmt 0 view .LVU49
	cmpl	%edi, %ecx
	jbe	.L13
	.loc 1 128 9 is_stmt 1 view .LVU50
	.loc 1 129 16 is_stmt 0 view .LVU51
	cmpw	$1, (%rsi,%rdi,2)
	.loc 1 127 38 view .LVU52
	leal	4(%rdx), %edi
.LVL14:
	.loc 1 129 16 view .LVU53
	sbbl	$-1, %eax
.LVL15:
	.loc 1 127 37 is_stmt 1 view .LVU54
	.loc 1 127 13 view .LVU55
	.loc 1 127 5 is_stmt 0 view .LVU56
	cmpl	%edi, %ecx
	jbe	.L13
	.loc 1 128 9 is_stmt 1 view .LVU57
	.loc 1 129 16 is_stmt 0 view .LVU58
	cmpw	$1, (%rsi,%rdi,2)
	.loc 1 127 38 view .LVU59
	leal	5(%rdx), %edi
.LVL16:
	.loc 1 129 16 view .LVU60
	sbbl	$-1, %eax
.LVL17:
	.loc 1 127 37 is_stmt 1 view .LVU61
	.loc 1 127 13 view .LVU62
	.loc 1 127 5 is_stmt 0 view .LVU63
	cmpl	%edi, %ecx
	jbe	.L13
	.loc 1 128 9 is_stmt 1 view .LVU64
	.loc 1 129 16 is_stmt 0 view .LVU65
	cmpw	$1, (%rsi,%rdi,2)
	sbbl	$-1, %eax
.LVL18:
	.loc 1 127 37 is_stmt 1 view .LVU66
	.loc 1 127 38 is_stmt 0 view .LVU67
	addl	$6, %edx
.LVL19:
	.loc 1 127 13 is_stmt 1 view .LVU68
	.loc 1 127 5 is_stmt 0 view .LVU69
	cmpl	%edx, %ecx
	jbe	.L13
	.loc 1 128 9 is_stmt 1 view .LVU70
	.loc 1 129 16 is_stmt 0 view .LVU71
	cmpw	$1, (%rsi,%rdx,2)
	sbbl	$-1, %eax
.LVL20:
.L13:
	.loc 1 134 5 is_stmt 1 view .LVU72
	.loc 1 134 15 is_stmt 0 view .LVU73
	imull	$100, %eax, %eax
	.loc 1 134 19 view .LVU74
	xorl	%edx, %edx
	divl	%ecx
	.loc 1 135 1 view .LVU75
	ret
.LVL21:
	.p2align 4,,10
	.p2align 3
.L7:
	.loc 1 120 32 view .LVU76
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movb	%al, 15(%rsp)
.LBB4:
.LBI4:
	.loc 1 120 15 is_stmt 1 view .LVU77
.LBB5:
	.loc 1 124 9 view .LVU78
	call	*(%rdx)
.LVL22:
	.loc 1 125 9 view .LVU79
	movzbl	15(%rsp), %eax
.LBE5:
.LBE4:
	.loc 1 135 1 is_stmt 0 view .LVU80
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
.LVL23:
	.p2align 4,,10
	.p2align 3
.L22:
	.loc 1 127 10 view .LVU81
	xorl	%edx, %edx
	.loc 1 121 9 view .LVU82
	xorl	%eax, %eax
	jmp	.L11
.L28:
	jmp	.L24
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	mem_peruser.cold, @function
mem_peruser.cold:
.LFSB5:
.L24:
	.loc 1 134 5 is_stmt 1 view -0
	ud2
	.cfi_endproc
.LFE5:
	.text
	.size	mem_peruser, .-mem_peruser
	.section	.text.unlikely
	.size	mem_peruser.cold, .-mem_peruser.cold
.LCOLDE1:
	.text
.LHOTE1:
	.p2align 4
	.globl	mem_malloc
	.type	mem_malloc, @function
mem_malloc:
.LVL24:
.LFB2:
	.loc 1 84 36 view -0
	.cfi_startproc
	.loc 1 84 36 is_stmt 0 view .LVU85
	endbr64
	.loc 1 85 5 is_stmt 1 view .LVU86
	.loc 1 84 36 is_stmt 0 view .LVU87
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edi, %ebx
.LVL25:
.LBB8:
.LBI8:
	.loc 1 52 12 is_stmt 1 view .LVU88
.LBB9:
	.loc 1 53 5 view .LVU89
	.loc 1 54 5 view .LVU90
	.loc 1 55 5 view .LVU91
	.loc 1 56 5 view .LVU92
	.loc 1 57 5 view .LVU93
.LBE9:
.LBE8:
	.loc 1 84 36 is_stmt 0 view .LVU94
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.LBB13:
.LBB10:
	.loc 1 57 15 view .LVU95
	movq	mem_dev@GOTPCREL(%rip), %rbp
	.loc 1 57 7 view .LVU96
	cmpb	$0, 44(%rbp)
	jne	.L30
	.loc 1 58 9 is_stmt 1 view .LVU97
	call	*0(%rbp)
.LVL26:
.L30:
	.loc 1 60 5 view .LVU98
	.loc 1 60 7 is_stmt 0 view .LVU99
	testl	%ebx, %ebx
	je	.L37
	.loc 1 63 5 is_stmt 1 view .LVU100
	.loc 1 63 30 is_stmt 0 view .LVU101
	movl	40(%rbp), %ecx
	xorl	%edx, %edx
	movl	%ebx, %eax
	.loc 1 69 24 view .LVU102
	movq	24(%rbp), %rdi
	divl	%ecx
.LVL27:
	.loc 1 64 5 is_stmt 1 view .LVU103
	.loc 1 65 17 is_stmt 0 view .LVU104
	cmpl	$1, %edx
	.loc 1 67 33 view .LVU105
	movl	36(%rbp), %edx
	.loc 1 65 17 view .LVU106
	sbbl	$-1, %eax
.LVL28:
	.loc 1 67 5 is_stmt 1 view .LVU107
	.loc 1 67 11 is_stmt 0 view .LVU108
	leal	-1(%rdx), %esi
.LVL29:
	.loc 1 68 5 is_stmt 1 view .LVU109
	.loc 1 68 40 view .LVU110
	.loc 1 55 9 is_stmt 0 view .LVU111
	xorl	%edx, %edx
.LVL30:
	.p2align 4,,10
	.p2align 3
.L44:
	.loc 1 69 9 is_stmt 1 view .LVU112
	.loc 1 70 22 is_stmt 0 view .LVU113
	addl	$1, %edx
.LVL31:
	.loc 1 69 11 view .LVU114
	cmpw	$0, (%rdi,%rsi,2)
	je	.L34
	.loc 1 72 23 view .LVU115
	xorl	%edx, %edx
.LVL32:
.L34:
	.loc 1 74 9 is_stmt 1 view .LVU116
	.loc 1 74 11 is_stmt 0 view .LVU117
	cmpl	%edx, %eax
	je	.L56
	.loc 1 68 50 is_stmt 1 view .LVU118
	.loc 1 68 56 is_stmt 0 view .LVU119
	subq	$1, %rsi
.LVL33:
	.loc 1 68 40 is_stmt 1 view .LVU120
	.loc 1 68 5 is_stmt 0 view .LVU121
	cmpq	$-1, %rsi
	jne	.L44
.LVL34:
.L37:
	.loc 1 68 5 view .LVU122
.LBE10:
.LBE13:
	.loc 1 91 1 view .LVU123
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	.loc 1 87 16 view .LVU124
	xorl	%eax, %eax
	.loc 1 91 1 view .LVU125
	popq	%rbx
	.cfi_def_cfa_offset 16
.LVL35:
	.loc 1 91 1 view .LVU126
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.LVL36:
	.p2align 4,,10
	.p2align 3
.L56:
	.cfi_restore_state
.LBB14:
.LBB11:
	.loc 1 75 21 is_stmt 1 view .LVU127
	.loc 1 75 13 is_stmt 0 view .LVU128
	testl	%edx, %edx
	je	.L42
	leal	-1(%rdx), %eax
.LVL37:
	.loc 1 75 13 view .LVU129
	movl	%edx, %r10d
	cmpl	$6, %eax
	jbe	.L46
	movl	%edx, %r8d
	movd	%edx, %xmm0
	leaq	(%rdi,%rsi,2), %rax
	shrl	$3, %r8d
	punpcklwd	%xmm0, %xmm0
	subl	$1, %r8d
	pshufd	$0, %xmm0, %xmm0
	salq	$4, %r8
	addq	%rax, %r8
.LVL38:
	.p2align 4,,10
	.p2align 3
.L40:
	.loc 1 76 17 is_stmt 1 view .LVU130
	movq	%rax, %r9
	.loc 1 76 42 is_stmt 0 view .LVU131
	movups	%xmm0, (%rax)
	.loc 1 75 33 is_stmt 1 view .LVU132
	.loc 1 75 21 view .LVU133
	addq	$16, %rax
	cmpq	%r8, %r9
	jne	.L40
	movl	%edx, %eax
	andl	$-8, %eax
	testb	$7, %dl
	je	.L42
.L39:
.LVL39:
	.loc 1 76 17 view .LVU134
	.loc 1 76 38 is_stmt 0 view .LVU135
	movl	%eax, %r8d
	.loc 1 76 31 view .LVU136
	addq	%rsi, %r8
	.loc 1 76 42 view .LVU137
	movw	%r10w, (%rdi,%r8,2)
	.loc 1 75 33 is_stmt 1 view .LVU138
	.loc 1 75 34 is_stmt 0 view .LVU139
	leal	1(%rax), %r8d
.LVL40:
	.loc 1 75 21 is_stmt 1 view .LVU140
	.loc 1 75 13 is_stmt 0 view .LVU141
	cmpl	%r8d, %edx
	jbe	.L42
	.loc 1 76 17 is_stmt 1 view .LVU142
	.loc 1 76 31 is_stmt 0 view .LVU143
	addq	%rsi, %r8
.LVL41:
	.loc 1 76 42 view .LVU144
	movw	%r10w, (%rdi,%r8,2)
	.loc 1 75 33 is_stmt 1 view .LVU145
	.loc 1 75 34 is_stmt 0 view .LVU146
	leal	2(%rax), %r8d
.LVL42:
	.loc 1 75 21 is_stmt 1 view .LVU147
	.loc 1 75 13 is_stmt 0 view .LVU148
	cmpl	%r8d, %edx
	jbe	.L42
	.loc 1 76 17 is_stmt 1 view .LVU149
	.loc 1 76 31 is_stmt 0 view .LVU150
	addq	%rsi, %r8
.LVL43:
	.loc 1 76 42 view .LVU151
	movw	%r10w, (%rdi,%r8,2)
	.loc 1 75 33 is_stmt 1 view .LVU152
	.loc 1 75 34 is_stmt 0 view .LVU153
	leal	3(%rax), %r8d
.LVL44:
	.loc 1 75 21 is_stmt 1 view .LVU154
	.loc 1 75 13 is_stmt 0 view .LVU155
	cmpl	%r8d, %edx
	jbe	.L42
	.loc 1 76 17 is_stmt 1 view .LVU156
	.loc 1 76 31 is_stmt 0 view .LVU157
	addq	%rsi, %r8
.LVL45:
	.loc 1 76 42 view .LVU158
	movw	%r10w, (%rdi,%r8,2)
	.loc 1 75 33 is_stmt 1 view .LVU159
	.loc 1 75 34 is_stmt 0 view .LVU160
	leal	4(%rax), %r8d
.LVL46:
	.loc 1 75 21 is_stmt 1 view .LVU161
	.loc 1 75 13 is_stmt 0 view .LVU162
	cmpl	%r8d, %edx
	jbe	.L42
	.loc 1 76 17 is_stmt 1 view .LVU163
	.loc 1 76 31 is_stmt 0 view .LVU164
	addq	%rsi, %r8
.LVL47:
	.loc 1 76 42 view .LVU165
	movw	%r10w, (%rdi,%r8,2)
	.loc 1 75 33 is_stmt 1 view .LVU166
	.loc 1 75 34 is_stmt 0 view .LVU167
	leal	5(%rax), %r8d
.LVL48:
	.loc 1 75 21 is_stmt 1 view .LVU168
	.loc 1 75 13 is_stmt 0 view .LVU169
	cmpl	%r8d, %edx
	jbe	.L42
	.loc 1 76 17 is_stmt 1 view .LVU170
	.loc 1 76 31 is_stmt 0 view .LVU171
	addq	%rsi, %r8
.LVL49:
	.loc 1 75 34 view .LVU172
	addl	$6, %eax
.LVL50:
	.loc 1 76 42 view .LVU173
	movw	%r10w, (%rdi,%r8,2)
	.loc 1 75 33 is_stmt 1 view .LVU174
	.loc 1 75 21 view .LVU175
	.loc 1 75 13 is_stmt 0 view .LVU176
	cmpl	%eax, %edx
	jbe	.L42
	.loc 1 76 17 is_stmt 1 view .LVU177
	.loc 1 76 31 is_stmt 0 view .LVU178
	addq	%rsi, %rax
	.loc 1 76 42 view .LVU179
	movw	%r10w, (%rdi,%rax,2)
	.loc 1 75 33 is_stmt 1 view .LVU180
	.loc 1 75 21 view .LVU181
.L42:
	.loc 1 78 13 view .LVU182
	.loc 1 78 26 is_stmt 0 view .LVU183
	imull	%esi, %ecx
.LVL51:
	.loc 1 78 26 view .LVU184
.LBE11:
.LBE14:
	.loc 1 86 5 is_stmt 1 view .LVU185
	.loc 1 86 7 is_stmt 0 view .LVU186
	cmpl	$-1, %ecx
	je	.L37
	.loc 1 89 9 is_stmt 1 view .LVU187
	.loc 1 89 16 is_stmt 0 view .LVU188
	movq	16(%rbp), %rax
	.loc 1 91 1 view .LVU189
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
.LVL52:
	.loc 1 91 1 view .LVU190
	popq	%rbp
	.cfi_def_cfa_offset 8
	.loc 1 89 16 view .LVU191
	addq	%rcx, %rax
.LVL53:
	.loc 1 91 1 view .LVU192
	ret
.LVL54:
	.p2align 4,,10
	.p2align 3
.L46:
	.cfi_restore_state
.LBB15:
.LBB12:
	.loc 1 75 18 view .LVU193
	xorl	%eax, %eax
	jmp	.L39
.LBE12:
.LBE15:
	.cfi_endproc
.LFE2:
	.size	mem_malloc, .-mem_malloc
	.p2align 4
	.globl	mem_free_c
	.type	mem_free_c, @function
mem_free_c:
.LVL55:
.LFB3:
	.loc 1 93 26 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 93 26 is_stmt 0 view .LVU195
	endbr64
	.loc 1 94 5 is_stmt 1 view .LVU196
	.loc 1 95 5 view .LVU197
	.loc 1 93 26 is_stmt 0 view .LVU198
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	.loc 1 95 15 view .LVU199
	movq	mem_dev@GOTPCREL(%rip), %rcx
	.loc 1 95 7 view .LVU200
	cmpb	$0, 44(%rcx)
	je	.L64
	.loc 1 99 5 is_stmt 1 view .LVU201
	.loc 1 107 16 is_stmt 0 view .LVU202
	movl	$2, %r8d
	.loc 1 99 7 view .LVU203
	cmpl	%edi, 32(%rcx)
	jbe	.L57
	.loc 1 100 9 is_stmt 1 view .LVU204
.LVL56:
	.loc 1 101 9 view .LVU205
	.loc 1 100 26 is_stmt 0 view .LVU206
	movl	%edi, %eax
	xorl	%edx, %edx
	divl	40(%rcx)
	.loc 1 101 40 view .LVU207
	movq	24(%rcx), %rdx
	cltq
	leaq	(%rdx,%rax,2), %rdi
.LVL57:
	.loc 1 101 40 view .LVU208
	movzwl	(%rdi), %eax
.LVL58:
	.loc 1 102 9 is_stmt 1 view .LVU209
	.loc 1 102 17 view .LVU210
	.loc 1 102 9 is_stmt 0 view .LVU211
	testw	%ax, %ax
	je	.L61
	.loc 1 103 40 view .LVU212
	subl	$1, %eax
.LVL59:
	.loc 1 103 40 view .LVU213
	xorl	%esi, %esi
	leaq	2(%rax,%rax), %rdx
	call	memset@PLT
.LVL60:
.L61:
	.loc 1 105 16 view .LVU214
	xorl	%r8d, %r8d
.L57:
	.loc 1 109 1 view .LVU215
	movl	%r8d, %eax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.LVL61:
	.p2align 4,,10
	.p2align 3
.L64:
	.cfi_restore_state
.LBB18:
.LBI18:
	.loc 1 93 4 is_stmt 1 view .LVU216
.LBB19:
	.loc 1 96 9 view .LVU217
	call	*(%rcx)
.LVL62:
	.loc 1 97 9 view .LVU218
	.loc 1 96 9 is_stmt 0 view .LVU219
	movl	$1, %r8d
.LBE19:
.LBE18:
	.loc 1 109 1 view .LVU220
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	movl	%r8d, %eax
	ret
	.cfi_endproc
.LFE3:
	.size	mem_free_c, .-mem_free_c
	.p2align 4
	.globl	mem_free
	.type	mem_free, @function
mem_free:
.LVL63:
.LFB4:
	.loc 1 111 25 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 111 25 is_stmt 0 view .LVU222
	endbr64
	.loc 1 112 5 is_stmt 1 view .LVU223
	.loc 1 113 5 view .LVU224
	.loc 1 113 7 is_stmt 0 view .LVU225
	testq	%rdi, %rdi
	je	.L65
	.loc 1 113 39 discriminator 2 view .LVU226
	movq	mem_dev@GOTPCREL(%rip), %rax
	movq	16(%rax), %rdx
	.loc 1 113 17 discriminator 2 view .LVU227
	cmpq	%rdi, %rdx
	ja	.L65
	.loc 1 114 5 is_stmt 1 view .LVU228
	.loc 1 114 23 is_stmt 0 view .LVU229
	subq	%rdx, %rdi
.LVL64:
	.loc 1 115 5 is_stmt 1 view .LVU230
	.loc 1 115 7 is_stmt 0 view .LVU231
	cmpl	%edi, 32(%rax)
	ja	.L70
.LVL65:
.L65:
	.loc 1 118 1 view .LVU232
	ret
.LVL66:
	.p2align 4,,10
	.p2align 3
.L70:
	.loc 1 116 9 is_stmt 1 view .LVU233
	jmp	mem_free_c@PLT
.LVL67:
	.loc 1 116 9 is_stmt 0 view .LVU234
	.cfi_endproc
.LFE4:
	.size	mem_free, .-mem_free
	.p2align 4
	.globl	rest_malloc
	.type	rest_malloc, @function
rest_malloc:
.LFB6:
	.loc 1 137 23 is_stmt 1 view -0
	.cfi_startproc
	endbr64
	.loc 1 138 5 view .LVU236
	.loc 1 138 12 is_stmt 0 view .LVU237
	movq	mem_dev@GOTPCREL(%rip), %rax
	.loc 1 138 5 view .LVU238
	jmp	*(%rax)
.LVL68:
	.cfi_endproc
.LFE6:
	.size	rest_malloc, .-rest_malloc
	.globl	mem_dev
	.section	.data.rel,"aw"
	.align 32
	.type	mem_dev, @object
	.size	mem_dev, 48
mem_dev:
	.quad	mem_init
	.quad	mem_peruser
	.quad	mem_buf
	.quad	mem_management_table
	.long	1048576
	.long	32768
	.long	32
	.byte	0
	.zero	3
	.local	mem_management_table
	.comm	mem_management_table,65536,32
	.local	mem_buf
	.comm	mem_buf,1048576,32
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.value	1
	.value	1
	.value	1
	.value	1
	.value	1
	.value	1
	.value	1
	.value	1
	.text
.Letext0:
	.section	.text.unlikely
.Letext_cold0:
	.file 2 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x495
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF376
	.byte	0xc
	.long	.LASF377
	.long	.LASF378
	.long	.Ldebug_ranges0+0x80
	.quad	0
	.long	.Ldebug_line0
	.long	.Ldebug_macro0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF352
	.uleb128 0x3
	.string	"u32"
	.byte	0x1
	.byte	0x7
	.byte	0x16
	.long	0x2d
	.uleb128 0x3
	.string	"u16"
	.byte	0x1
	.byte	0x8
	.byte	0x18
	.long	0x4c
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF353
	.uleb128 0x3
	.string	"u8"
	.byte	0x1
	.byte	0x9
	.byte	0x17
	.long	0x5e
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF354
	.uleb128 0x4
	.long	0x7f
	.long	0x78
	.uleb128 0x5
	.long	0x78
	.long	0xfffff
	.byte	0
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF355
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF356
	.uleb128 0x6
	.long	.LASF357
	.byte	0x1
	.byte	0xc
	.byte	0xd
	.long	0x65
	.uleb128 0x9
	.byte	0x3
	.quad	mem_buf
	.uleb128 0x4
	.long	0x4c
	.long	0xad
	.uleb128 0x7
	.long	0x78
	.value	0x7fff
	.byte	0
	.uleb128 0x6
	.long	.LASF358
	.byte	0x1
	.byte	0xe
	.byte	0x17
	.long	0x9c
	.uleb128 0x9
	.byte	0x3
	.quad	mem_management_table
	.uleb128 0x8
	.long	.LASF379
	.byte	0x30
	.byte	0x1
	.byte	0x10
	.byte	0x8
	.long	0x139
	.uleb128 0x9
	.long	.LASF359
	.byte	0x1
	.byte	0x11
	.byte	0xc
	.long	0x13a
	.byte	0
	.uleb128 0x9
	.long	.LASF360
	.byte	0x1
	.byte	0x12
	.byte	0x15
	.long	0x145
	.byte	0x8
	.uleb128 0x9
	.long	.LASF361
	.byte	0x1
	.byte	0x13
	.byte	0x9
	.long	0x14b
	.byte	0x10
	.uleb128 0x9
	.long	.LASF362
	.byte	0x1
	.byte	0x14
	.byte	0xa
	.long	0x151
	.byte	0x18
	.uleb128 0x9
	.long	.LASF363
	.byte	0x1
	.byte	0x15
	.byte	0x9
	.long	0x34
	.byte	0x20
	.uleb128 0x9
	.long	.LASF364
	.byte	0x1
	.byte	0x16
	.byte	0x9
	.long	0x34
	.byte	0x24
	.uleb128 0x9
	.long	.LASF365
	.byte	0x1
	.byte	0x17
	.byte	0x9
	.long	0x34
	.byte	0x28
	.uleb128 0x9
	.long	.LASF366
	.byte	0x1
	.byte	0x18
	.byte	0x13
	.long	0x5e
	.byte	0x2c
	.byte	0
	.uleb128 0xa
	.uleb128 0xb
	.byte	0x8
	.long	0x139
	.uleb128 0xc
	.long	0x5e
	.uleb128 0xb
	.byte	0x8
	.long	0x140
	.uleb128 0xb
	.byte	0x8
	.long	0x53
	.uleb128 0xb
	.byte	0x8
	.long	0x40
	.uleb128 0xd
	.long	.LASF367
	.byte	0x1
	.byte	0x1e
	.byte	0x15
	.long	0xc3
	.uleb128 0x9
	.byte	0x3
	.quad	mem_dev
	.uleb128 0xe
	.long	.LASF380
	.byte	0x1
	.byte	0x89
	.byte	0x6
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xf
	.long	.LASF369
	.byte	0x1
	.byte	0x78
	.byte	0xf
	.long	0x5e
	.byte	0x1
	.long	0x1af
	.uleb128 0x10
	.string	"use"
	.byte	0x1
	.byte	0x79
	.byte	0x9
	.long	0x34
	.uleb128 0x10
	.string	"i"
	.byte	0x1
	.byte	0x7a
	.byte	0x9
	.long	0x34
	.byte	0
	.uleb128 0x11
	.long	.LASF381
	.byte	0x1
	.byte	0x6f
	.byte	0x6
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x203
	.uleb128 0x12
	.string	"ptr"
	.byte	0x1
	.byte	0x6f
	.byte	0x15
	.long	0x203
	.long	.LLST15
	.long	.LVUS15
	.uleb128 0x13
	.long	.LASF368
	.byte	0x1
	.byte	0x70
	.byte	0x9
	.long	0x34
	.long	.LLST16
	.long	.LVUS16
	.uleb128 0x14
	.quad	.LVL67
	.long	0x205
	.byte	0
	.uleb128 0x15
	.byte	0x8
	.uleb128 0xf
	.long	.LASF370
	.byte	0x1
	.byte	0x5d
	.byte	0x4
	.long	0x53
	.byte	0x1
	.long	0x245
	.uleb128 0x16
	.long	.LASF368
	.byte	0x1
	.byte	0x5d
	.byte	0x13
	.long	0x34
	.uleb128 0x10
	.string	"i"
	.byte	0x1
	.byte	0x5e
	.byte	0x9
	.long	0x245
	.uleb128 0x17
	.long	.LASF371
	.byte	0x1
	.byte	0x5e
	.byte	0xb
	.long	0x245
	.uleb128 0x17
	.long	.LASF372
	.byte	0x1
	.byte	0x5e
	.byte	0x14
	.long	0x245
	.byte	0
	.uleb128 0x18
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x19
	.long	.LASF382
	.byte	0x1
	.byte	0x54
	.byte	0x7
	.long	0x203
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x2f4
	.uleb128 0x1a
	.long	.LASF373
	.byte	0x1
	.byte	0x54
	.byte	0x1f
	.long	0x2d
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0x13
	.long	.LASF368
	.byte	0x1
	.byte	0x55
	.byte	0x9
	.long	0x34
	.long	.LLST4
	.long	.LVUS4
	.uleb128 0x1b
	.long	0x2f4
	.quad	.LBI8
	.byte	.LVU88
	.long	.Ldebug_ranges0+0x30
	.byte	0x1
	.byte	0x55
	.byte	0x12
	.uleb128 0x1c
	.long	0x305
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0x1d
	.long	.Ldebug_ranges0+0x30
	.uleb128 0x1e
	.long	0x311
	.long	.LLST6
	.long	.LVUS6
	.uleb128 0x1e
	.long	0x31d
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x1e
	.long	0x329
	.long	.LLST8
	.long	.LVUS8
	.uleb128 0x1e
	.long	0x335
	.long	.LLST9
	.long	.LVUS9
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1f
	.long	.LASF383
	.byte	0x1
	.byte	0x34
	.byte	0xc
	.long	0x34
	.byte	0x1
	.long	0x340
	.uleb128 0x16
	.long	.LASF373
	.byte	0x1
	.byte	0x34
	.byte	0x24
	.long	0x2d
	.uleb128 0x17
	.long	.LASF368
	.byte	0x1
	.byte	0x35
	.byte	0xa
	.long	0x340
	.uleb128 0x17
	.long	.LASF371
	.byte	0x1
	.byte	0x36
	.byte	0x9
	.long	0x34
	.uleb128 0x17
	.long	.LASF374
	.byte	0x1
	.byte	0x37
	.byte	0x9
	.long	0x34
	.uleb128 0x10
	.string	"i"
	.byte	0x1
	.byte	0x38
	.byte	0x9
	.long	0x34
	.byte	0
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF375
	.uleb128 0x20
	.long	.LASF384
	.byte	0x1
	.byte	0x29
	.byte	0xd
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x392
	.uleb128 0x21
	.string	"i"
	.byte	0x1
	.byte	0x2a
	.byte	0x9
	.long	0x245
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0x22
	.quad	.LVL4
	.long	0x48d
	.uleb128 0x23
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x23
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0x40
	.byte	0x3c
	.byte	0x24
	.byte	0
	.byte	0
	.uleb128 0x24
	.long	0x187
	.long	.Ldebug_ranges0+0
	.uleb128 0x1
	.byte	0x9c
	.long	0x3e8
	.uleb128 0x1e
	.long	0x198
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0x1e
	.long	0x1a4
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x25
	.long	0x187
	.quad	.LBI4
	.byte	.LVU77
	.quad	.LBB4
	.quad	.LBE4-.LBB4
	.byte	0x1
	.byte	0x78
	.byte	0xf
	.uleb128 0x26
	.long	0x198
	.uleb128 0x26
	.long	0x1a4
	.byte	0
	.byte	0
	.uleb128 0x27
	.long	0x205
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x48d
	.uleb128 0x1c
	.long	0x216
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x1e
	.long	0x222
	.long	.LLST11
	.long	.LVUS11
	.uleb128 0x1e
	.long	0x22c
	.long	.LLST12
	.long	.LVUS12
	.uleb128 0x1e
	.long	0x238
	.long	.LLST13
	.long	.LVUS13
	.uleb128 0x28
	.long	0x205
	.quad	.LBI18
	.byte	.LVU216
	.quad	.LBB18
	.quad	.LBE18-.LBB18
	.byte	0x1
	.byte	0x5d
	.byte	0x4
	.long	0x479
	.uleb128 0x1c
	.long	0x216
	.long	.LLST14
	.long	.LVUS14
	.uleb128 0x26
	.long	0x222
	.uleb128 0x26
	.long	0x22c
	.uleb128 0x26
	.long	0x238
	.byte	0
	.uleb128 0x22
	.quad	.LVL60
	.long	0x48d
	.uleb128 0x23
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.byte	0
	.uleb128 0x29
	.long	.LASF385
	.long	.LASF386
	.byte	0x2
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.uleb128 0x2119
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LVUS15:
	.uleb128 0
	.uleb128 .LVU230
	.uleb128 .LVU230
	.uleb128 0
.LLST15:
	.quad	.LVL63
	.quad	.LVL64
	.value	0x1
	.byte	0x55
	.quad	.LVL64
	.quad	.LFE4
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS16:
	.uleb128 .LVU230
	.uleb128 .LVU232
	.uleb128 .LVU233
	.uleb128 .LVU234
.LLST16:
	.quad	.LVL64
	.quad	.LVL65
	.value	0x1
	.byte	0x55
	.quad	.LVL66
	.quad	.LVL67-1
	.value	0x1
	.byte	0x55
	.quad	0
	.quad	0
.LVUS3:
	.uleb128 0
	.uleb128 .LVU98
	.uleb128 .LVU98
	.uleb128 .LVU126
	.uleb128 .LVU126
	.uleb128 .LVU127
	.uleb128 .LVU127
	.uleb128 .LVU190
	.uleb128 .LVU190
	.uleb128 .LVU193
	.uleb128 .LVU193
	.uleb128 0
.LLST3:
	.quad	.LVL24
	.quad	.LVL26-1
	.value	0x1
	.byte	0x55
	.quad	.LVL26-1
	.quad	.LVL35
	.value	0x1
	.byte	0x53
	.quad	.LVL35
	.quad	.LVL36
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL36
	.quad	.LVL52
	.value	0x1
	.byte	0x53
	.quad	.LVL52
	.quad	.LVL54
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL54
	.quad	.LFE2
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LVUS4:
	.uleb128 .LVU184
	.uleb128 .LVU192
.LLST4:
	.quad	.LVL51
	.quad	.LVL53
	.value	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LVUS5:
	.uleb128 .LVU88
	.uleb128 .LVU98
	.uleb128 .LVU98
	.uleb128 .LVU122
	.uleb128 .LVU127
	.uleb128 .LVU184
	.uleb128 .LVU193
	.uleb128 0
.LLST5:
	.quad	.LVL25
	.quad	.LVL26-1
	.value	0x1
	.byte	0x55
	.quad	.LVL26-1
	.quad	.LVL34
	.value	0x1
	.byte	0x53
	.quad	.LVL36
	.quad	.LVL51
	.value	0x1
	.byte	0x53
	.quad	.LVL54
	.quad	.LFE2
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LVUS6:
	.uleb128 .LVU90
	.uleb128 .LVU109
	.uleb128 .LVU109
	.uleb128 .LVU122
	.uleb128 .LVU127
	.uleb128 .LVU184
	.uleb128 .LVU193
	.uleb128 0
.LLST6:
	.quad	.LVL25
	.quad	.LVL29
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL29
	.quad	.LVL34
	.value	0x1
	.byte	0x54
	.quad	.LVL36
	.quad	.LVL51
	.value	0x1
	.byte	0x54
	.quad	.LVL54
	.quad	.LFE2
	.value	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LVUS7:
	.uleb128 .LVU103
	.uleb128 .LVU122
	.uleb128 .LVU127
	.uleb128 .LVU129
	.uleb128 .LVU129
	.uleb128 .LVU184
	.uleb128 .LVU193
	.uleb128 0
.LLST7:
	.quad	.LVL27
	.quad	.LVL34
	.value	0x1
	.byte	0x50
	.quad	.LVL36
	.quad	.LVL37
	.value	0x1
	.byte	0x50
	.quad	.LVL37
	.quad	.LVL51
	.value	0x17
	.byte	0x73
	.sleb128 0
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x72
	.sleb128 0
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x1b
	.byte	0xf7
	.uleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1d
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x30
	.byte	0x2e
	.byte	0x22
	.byte	0x9f
	.quad	.LVL54
	.quad	.LFE2
	.value	0x17
	.byte	0x73
	.sleb128 0
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x72
	.sleb128 0
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x1b
	.byte	0xf7
	.uleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1d
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x30
	.byte	0x2e
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS8:
	.uleb128 .LVU92
	.uleb128 .LVU112
	.uleb128 .LVU112
	.uleb128 .LVU114
	.uleb128 .LVU114
	.uleb128 .LVU116
	.uleb128 .LVU116
	.uleb128 .LVU122
	.uleb128 .LVU127
	.uleb128 .LVU184
	.uleb128 .LVU193
	.uleb128 0
.LLST8:
	.quad	.LVL25
	.quad	.LVL30
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL30
	.quad	.LVL31
	.value	0x1
	.byte	0x51
	.quad	.LVL31
	.quad	.LVL32
	.value	0x3
	.byte	0x71
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL32
	.quad	.LVL34
	.value	0x1
	.byte	0x51
	.quad	.LVL36
	.quad	.LVL51
	.value	0x1
	.byte	0x51
	.quad	.LVL54
	.quad	.LFE2
	.value	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LVUS9:
	.uleb128 .LVU127
	.uleb128 .LVU130
	.uleb128 .LVU134
	.uleb128 .LVU140
	.uleb128 .LVU140
	.uleb128 .LVU144
	.uleb128 .LVU144
	.uleb128 .LVU147
	.uleb128 .LVU147
	.uleb128 .LVU151
	.uleb128 .LVU151
	.uleb128 .LVU154
	.uleb128 .LVU154
	.uleb128 .LVU158
	.uleb128 .LVU158
	.uleb128 .LVU161
	.uleb128 .LVU161
	.uleb128 .LVU165
	.uleb128 .LVU165
	.uleb128 .LVU168
	.uleb128 .LVU168
	.uleb128 .LVU172
	.uleb128 .LVU172
	.uleb128 .LVU173
	.uleb128 .LVU193
	.uleb128 0
.LLST9:
	.quad	.LVL36
	.quad	.LVL38
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL39
	.quad	.LVL40
	.value	0x1
	.byte	0x50
	.quad	.LVL40
	.quad	.LVL41
	.value	0x1
	.byte	0x58
	.quad	.LVL41
	.quad	.LVL42
	.value	0x3
	.byte	0x70
	.sleb128 1
	.byte	0x9f
	.quad	.LVL42
	.quad	.LVL43
	.value	0x1
	.byte	0x58
	.quad	.LVL43
	.quad	.LVL44
	.value	0x3
	.byte	0x70
	.sleb128 2
	.byte	0x9f
	.quad	.LVL44
	.quad	.LVL45
	.value	0x1
	.byte	0x58
	.quad	.LVL45
	.quad	.LVL46
	.value	0x3
	.byte	0x70
	.sleb128 3
	.byte	0x9f
	.quad	.LVL46
	.quad	.LVL47
	.value	0x1
	.byte	0x58
	.quad	.LVL47
	.quad	.LVL48
	.value	0x3
	.byte	0x70
	.sleb128 4
	.byte	0x9f
	.quad	.LVL48
	.quad	.LVL49
	.value	0x1
	.byte	0x58
	.quad	.LVL49
	.quad	.LVL50
	.value	0x3
	.byte	0x70
	.sleb128 5
	.byte	0x9f
	.quad	.LVL54
	.quad	.LFE2
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS0:
	.uleb128 .LVU3
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 .LVU9
	.uleb128 .LVU9
	.uleb128 .LVU10
.LLST0:
	.quad	.LVL0
	.quad	.LVL1
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL1
	.quad	.LVL2
	.value	0x1
	.byte	0x50
	.quad	.LVL2
	.quad	.LVL3
	.value	0x3
	.byte	0x70
	.sleb128 1
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS1:
	.uleb128 .LVU16
	.uleb128 .LVU24
	.uleb128 .LVU28
	.uleb128 .LVU72
	.uleb128 .LVU76
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST1:
	.quad	.LVL5
	.quad	.LVL7
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL8
	.quad	.LVL20
	.value	0x1
	.byte	0x50
	.quad	.LVL21
	.quad	.LHOTE1
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LFSB5
	.quad	.LCOLDE1
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS2:
	.uleb128 .LVU20
	.uleb128 .LVU24
	.uleb128 .LVU28
	.uleb128 .LVU34
	.uleb128 .LVU34
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 .LVU41
	.uleb128 .LVU41
	.uleb128 .LVU46
	.uleb128 .LVU46
	.uleb128 .LVU48
	.uleb128 .LVU48
	.uleb128 .LVU53
	.uleb128 .LVU53
	.uleb128 .LVU55
	.uleb128 .LVU55
	.uleb128 .LVU60
	.uleb128 .LVU60
	.uleb128 .LVU62
	.uleb128 .LVU62
	.uleb128 .LVU68
	.uleb128 .LVU68
	.uleb128 .LVU72
	.uleb128 .LVU81
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST2:
	.quad	.LVL6
	.quad	.LVL7
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL8
	.quad	.LVL9
	.value	0x1
	.byte	0x51
	.quad	.LVL9
	.quad	.LVL10
	.value	0x1
	.byte	0x55
	.quad	.LVL10
	.quad	.LVL11
	.value	0x3
	.byte	0x71
	.sleb128 1
	.byte	0x9f
	.quad	.LVL11
	.quad	.LVL12
	.value	0x1
	.byte	0x55
	.quad	.LVL12
	.quad	.LVL13
	.value	0x3
	.byte	0x71
	.sleb128 2
	.byte	0x9f
	.quad	.LVL13
	.quad	.LVL14
	.value	0x1
	.byte	0x55
	.quad	.LVL14
	.quad	.LVL15
	.value	0x3
	.byte	0x71
	.sleb128 3
	.byte	0x9f
	.quad	.LVL15
	.quad	.LVL16
	.value	0x1
	.byte	0x55
	.quad	.LVL16
	.quad	.LVL17
	.value	0x3
	.byte	0x71
	.sleb128 4
	.byte	0x9f
	.quad	.LVL17
	.quad	.LVL19
	.value	0x1
	.byte	0x55
	.quad	.LVL19
	.quad	.LVL20
	.value	0x1
	.byte	0x51
	.quad	.LVL23
	.quad	.LHOTE1
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LFSB5
	.quad	.LCOLDE1
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS10:
	.uleb128 0
	.uleb128 .LVU208
	.uleb128 .LVU208
	.uleb128 .LVU216
	.uleb128 .LVU216
	.uleb128 .LVU218
	.uleb128 .LVU218
	.uleb128 0
.LLST10:
	.quad	.LVL55
	.quad	.LVL57
	.value	0x1
	.byte	0x55
	.quad	.LVL57
	.quad	.LVL61
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL61
	.quad	.LVL62-1
	.value	0x1
	.byte	0x55
	.quad	.LVL62-1
	.quad	.LFE3
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS11:
	.uleb128 .LVU210
	.uleb128 .LVU214
.LLST11:
	.quad	.LVL58
	.quad	.LVL60
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS12:
	.uleb128 .LVU205
	.uleb128 .LVU208
	.uleb128 .LVU208
	.uleb128 .LVU214
.LLST12:
	.quad	.LVL56
	.quad	.LVL57
	.value	0x15
	.byte	0x75
	.sleb128 0
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x3
	.quad	mem_dev+40
	.byte	0x94
	.byte	0x4
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x1b
	.byte	0xf7
	.uleb128 0
	.byte	0x9f
	.quad	.LVL57
	.quad	.LVL60-1
	.value	0x16
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x3
	.quad	mem_dev+40
	.byte	0x94
	.byte	0x4
	.byte	0xf7
	.uleb128 0x2d
	.byte	0x1b
	.byte	0xf7
	.uleb128 0
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS13:
	.uleb128 .LVU209
	.uleb128 .LVU213
	.uleb128 .LVU213
	.uleb128 .LVU214
.LLST13:
	.quad	.LVL58
	.quad	.LVL59
	.value	0x7
	.byte	0x70
	.sleb128 0
	.byte	0xa
	.value	0xffff
	.byte	0x1a
	.byte	0x9f
	.quad	.LVL59
	.quad	.LVL60-1
	.value	0x9
	.byte	0x75
	.sleb128 0
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.value	0xffff
	.byte	0x1a
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS14:
	.uleb128 .LVU217
	.uleb128 .LVU218
	.uleb128 .LVU218
	.uleb128 .LVU219
.LLST14:
	.quad	.LVL61
	.quad	.LVL62-1
	.value	0x1
	.byte	0x55
	.quad	.LVL62-1
	.quad	.LVL62
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
	.section	.debug_aranges,"",@progbits
	.long	0x3c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.Ltext_cold0
	.quad	.Letext_cold0-.Ltext_cold0
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.LFB5
	.quad	.LHOTE1
	.quad	.LFSB5
	.quad	.LCOLDE1
	.quad	0
	.quad	0
	.quad	.LBB8
	.quad	.LBE8
	.quad	.LBB13
	.quad	.LBE13
	.quad	.LBB14
	.quad	.LBE14
	.quad	.LBB15
	.quad	.LBE15
	.quad	0
	.quad	0
	.quad	.Ltext0
	.quad	.Letext0
	.quad	.Ltext_cold0
	.quad	.Letext_cold0
	.quad	0
	.quad	0
	.section	.debug_macro,"",@progbits
.Ldebug_macro0:
	.value	0x4
	.byte	0x2
	.long	.Ldebug_line0
	.byte	0x3
	.uleb128 0
	.uleb128 0x1
	.byte	0x5
	.uleb128 0x1
	.long	.LASF0
	.byte	0x5
	.uleb128 0x2
	.long	.LASF1
	.byte	0x5
	.uleb128 0x3
	.long	.LASF2
	.byte	0x5
	.uleb128 0x4
	.long	.LASF3
	.byte	0x5
	.uleb128 0x5
	.long	.LASF4
	.byte	0x5
	.uleb128 0x6
	.long	.LASF5
	.byte	0x5
	.uleb128 0x7
	.long	.LASF6
	.byte	0x5
	.uleb128 0x8
	.long	.LASF7
	.byte	0x5
	.uleb128 0x9
	.long	.LASF8
	.byte	0x5
	.uleb128 0xa
	.long	.LASF9
	.byte	0x5
	.uleb128 0xb
	.long	.LASF10
	.byte	0x5
	.uleb128 0xc
	.long	.LASF11
	.byte	0x5
	.uleb128 0xd
	.long	.LASF12
	.byte	0x5
	.uleb128 0xe
	.long	.LASF13
	.byte	0x5
	.uleb128 0xf
	.long	.LASF14
	.byte	0x5
	.uleb128 0x10
	.long	.LASF15
	.byte	0x5
	.uleb128 0x11
	.long	.LASF16
	.byte	0x5
	.uleb128 0x12
	.long	.LASF17
	.byte	0x5
	.uleb128 0x13
	.long	.LASF18
	.byte	0x5
	.uleb128 0x14
	.long	.LASF19
	.byte	0x5
	.uleb128 0x15
	.long	.LASF20
	.byte	0x5
	.uleb128 0x16
	.long	.LASF21
	.byte	0x5
	.uleb128 0x17
	.long	.LASF22
	.byte	0x5
	.uleb128 0x18
	.long	.LASF23
	.byte	0x5
	.uleb128 0x19
	.long	.LASF24
	.byte	0x5
	.uleb128 0x1a
	.long	.LASF25
	.byte	0x5
	.uleb128 0x1b
	.long	.LASF26
	.byte	0x5
	.uleb128 0x1c
	.long	.LASF27
	.byte	0x5
	.uleb128 0x1d
	.long	.LASF28
	.byte	0x5
	.uleb128 0x1e
	.long	.LASF29
	.byte	0x5
	.uleb128 0x1f
	.long	.LASF30
	.byte	0x5
	.uleb128 0x20
	.long	.LASF31
	.byte	0x5
	.uleb128 0x21
	.long	.LASF32
	.byte	0x5
	.uleb128 0x22
	.long	.LASF33
	.byte	0x5
	.uleb128 0x23
	.long	.LASF34
	.byte	0x5
	.uleb128 0x24
	.long	.LASF35
	.byte	0x5
	.uleb128 0x25
	.long	.LASF36
	.byte	0x5
	.uleb128 0x26
	.long	.LASF37
	.byte	0x5
	.uleb128 0x27
	.long	.LASF38
	.byte	0x5
	.uleb128 0x28
	.long	.LASF39
	.byte	0x5
	.uleb128 0x29
	.long	.LASF40
	.byte	0x5
	.uleb128 0x2a
	.long	.LASF41
	.byte	0x5
	.uleb128 0x2b
	.long	.LASF42
	.byte	0x5
	.uleb128 0x2c
	.long	.LASF43
	.byte	0x5
	.uleb128 0x2d
	.long	.LASF44
	.byte	0x5
	.uleb128 0x2e
	.long	.LASF45
	.byte	0x5
	.uleb128 0x2f
	.long	.LASF46
	.byte	0x5
	.uleb128 0x30
	.long	.LASF47
	.byte	0x5
	.uleb128 0x31
	.long	.LASF48
	.byte	0x5
	.uleb128 0x32
	.long	.LASF49
	.byte	0x5
	.uleb128 0x33
	.long	.LASF50
	.byte	0x5
	.uleb128 0x34
	.long	.LASF51
	.byte	0x5
	.uleb128 0x35
	.long	.LASF52
	.byte	0x5
	.uleb128 0x36
	.long	.LASF53
	.byte	0x5
	.uleb128 0x37
	.long	.LASF54
	.byte	0x5
	.uleb128 0x38
	.long	.LASF55
	.byte	0x5
	.uleb128 0x39
	.long	.LASF56
	.byte	0x5
	.uleb128 0x3a
	.long	.LASF57
	.byte	0x5
	.uleb128 0x3b
	.long	.LASF58
	.byte	0x5
	.uleb128 0x3c
	.long	.LASF59
	.byte	0x5
	.uleb128 0x3d
	.long	.LASF60
	.byte	0x5
	.uleb128 0x3e
	.long	.LASF61
	.byte	0x5
	.uleb128 0x3f
	.long	.LASF62
	.byte	0x5
	.uleb128 0x40
	.long	.LASF63
	.byte	0x5
	.uleb128 0x41
	.long	.LASF64
	.byte	0x5
	.uleb128 0x42
	.long	.LASF65
	.byte	0x5
	.uleb128 0x43
	.long	.LASF66
	.byte	0x5
	.uleb128 0x44
	.long	.LASF67
	.byte	0x5
	.uleb128 0x45
	.long	.LASF68
	.byte	0x5
	.uleb128 0x46
	.long	.LASF69
	.byte	0x5
	.uleb128 0x47
	.long	.LASF70
	.byte	0x5
	.uleb128 0x48
	.long	.LASF71
	.byte	0x5
	.uleb128 0x49
	.long	.LASF72
	.byte	0x5
	.uleb128 0x4a
	.long	.LASF73
	.byte	0x5
	.uleb128 0x4b
	.long	.LASF74
	.byte	0x5
	.uleb128 0x4c
	.long	.LASF75
	.byte	0x5
	.uleb128 0x4d
	.long	.LASF76
	.byte	0x5
	.uleb128 0x4e
	.long	.LASF77
	.byte	0x5
	.uleb128 0x4f
	.long	.LASF78
	.byte	0x5
	.uleb128 0x50
	.long	.LASF79
	.byte	0x5
	.uleb128 0x51
	.long	.LASF80
	.byte	0x5
	.uleb128 0x52
	.long	.LASF81
	.byte	0x5
	.uleb128 0x53
	.long	.LASF82
	.byte	0x5
	.uleb128 0x54
	.long	.LASF83
	.byte	0x5
	.uleb128 0x55
	.long	.LASF84
	.byte	0x5
	.uleb128 0x56
	.long	.LASF85
	.byte	0x5
	.uleb128 0x57
	.long	.LASF86
	.byte	0x5
	.uleb128 0x58
	.long	.LASF87
	.byte	0x5
	.uleb128 0x59
	.long	.LASF88
	.byte	0x5
	.uleb128 0x5a
	.long	.LASF89
	.byte	0x5
	.uleb128 0x5b
	.long	.LASF90
	.byte	0x5
	.uleb128 0x5c
	.long	.LASF91
	.byte	0x5
	.uleb128 0x5d
	.long	.LASF92
	.byte	0x5
	.uleb128 0x5e
	.long	.LASF93
	.byte	0x5
	.uleb128 0x5f
	.long	.LASF94
	.byte	0x5
	.uleb128 0x60
	.long	.LASF95
	.byte	0x5
	.uleb128 0x61
	.long	.LASF96
	.byte	0x5
	.uleb128 0x62
	.long	.LASF97
	.byte	0x5
	.uleb128 0x63
	.long	.LASF98
	.byte	0x5
	.uleb128 0x64
	.long	.LASF99
	.byte	0x5
	.uleb128 0x65
	.long	.LASF100
	.byte	0x5
	.uleb128 0x66
	.long	.LASF101
	.byte	0x5
	.uleb128 0x67
	.long	.LASF102
	.byte	0x5
	.uleb128 0x68
	.long	.LASF103
	.byte	0x5
	.uleb128 0x69
	.long	.LASF104
	.byte	0x5
	.uleb128 0x6a
	.long	.LASF105
	.byte	0x5
	.uleb128 0x6b
	.long	.LASF106
	.byte	0x5
	.uleb128 0x6c
	.long	.LASF107
	.byte	0x5
	.uleb128 0x6d
	.long	.LASF108
	.byte	0x5
	.uleb128 0x6e
	.long	.LASF109
	.byte	0x5
	.uleb128 0x6f
	.long	.LASF110
	.byte	0x5
	.uleb128 0x70
	.long	.LASF111
	.byte	0x5
	.uleb128 0x71
	.long	.LASF112
	.byte	0x5
	.uleb128 0x72
	.long	.LASF113
	.byte	0x5
	.uleb128 0x73
	.long	.LASF114
	.byte	0x5
	.uleb128 0x74
	.long	.LASF115
	.byte	0x5
	.uleb128 0x75
	.long	.LASF116
	.byte	0x5
	.uleb128 0x76
	.long	.LASF117
	.byte	0x5
	.uleb128 0x77
	.long	.LASF118
	.byte	0x5
	.uleb128 0x78
	.long	.LASF119
	.byte	0x5
	.uleb128 0x79
	.long	.LASF120
	.byte	0x5
	.uleb128 0x7a
	.long	.LASF121
	.byte	0x5
	.uleb128 0x7b
	.long	.LASF122
	.byte	0x5
	.uleb128 0x7c
	.long	.LASF123
	.byte	0x5
	.uleb128 0x7d
	.long	.LASF124
	.byte	0x5
	.uleb128 0x7e
	.long	.LASF125
	.byte	0x5
	.uleb128 0x7f
	.long	.LASF126
	.byte	0x5
	.uleb128 0x80
	.long	.LASF127
	.byte	0x5
	.uleb128 0x81
	.long	.LASF128
	.byte	0x5
	.uleb128 0x82
	.long	.LASF129
	.byte	0x5
	.uleb128 0x83
	.long	.LASF130
	.byte	0x5
	.uleb128 0x84
	.long	.LASF131
	.byte	0x5
	.uleb128 0x85
	.long	.LASF132
	.byte	0x5
	.uleb128 0x86
	.long	.LASF133
	.byte	0x5
	.uleb128 0x87
	.long	.LASF134
	.byte	0x5
	.uleb128 0x88
	.long	.LASF135
	.byte	0x5
	.uleb128 0x89
	.long	.LASF136
	.byte	0x5
	.uleb128 0x8a
	.long	.LASF137
	.byte	0x5
	.uleb128 0x8b
	.long	.LASF138
	.byte	0x5
	.uleb128 0x8c
	.long	.LASF139
	.byte	0x5
	.uleb128 0x8d
	.long	.LASF140
	.byte	0x5
	.uleb128 0x8e
	.long	.LASF141
	.byte	0x5
	.uleb128 0x8f
	.long	.LASF142
	.byte	0x5
	.uleb128 0x90
	.long	.LASF143
	.byte	0x5
	.uleb128 0x91
	.long	.LASF144
	.byte	0x5
	.uleb128 0x92
	.long	.LASF145
	.byte	0x5
	.uleb128 0x93
	.long	.LASF146
	.byte	0x5
	.uleb128 0x94
	.long	.LASF147
	.byte	0x5
	.uleb128 0x95
	.long	.LASF148
	.byte	0x5
	.uleb128 0x96
	.long	.LASF149
	.byte	0x5
	.uleb128 0x97
	.long	.LASF150
	.byte	0x5
	.uleb128 0x98
	.long	.LASF151
	.byte	0x5
	.uleb128 0x99
	.long	.LASF152
	.byte	0x5
	.uleb128 0x9a
	.long	.LASF153
	.byte	0x5
	.uleb128 0x9b
	.long	.LASF154
	.byte	0x5
	.uleb128 0x9c
	.long	.LASF155
	.byte	0x5
	.uleb128 0x9d
	.long	.LASF156
	.byte	0x5
	.uleb128 0x9e
	.long	.LASF157
	.byte	0x5
	.uleb128 0x9f
	.long	.LASF158
	.byte	0x5
	.uleb128 0xa0
	.long	.LASF159
	.byte	0x5
	.uleb128 0xa1
	.long	.LASF160
	.byte	0x5
	.uleb128 0xa2
	.long	.LASF161
	.byte	0x5
	.uleb128 0xa3
	.long	.LASF162
	.byte	0x5
	.uleb128 0xa4
	.long	.LASF163
	.byte	0x5
	.uleb128 0xa5
	.long	.LASF164
	.byte	0x5
	.uleb128 0xa6
	.long	.LASF165
	.byte	0x5
	.uleb128 0xa7
	.long	.LASF166
	.byte	0x5
	.uleb128 0xa8
	.long	.LASF167
	.byte	0x5
	.uleb128 0xa9
	.long	.LASF168
	.byte	0x5
	.uleb128 0xaa
	.long	.LASF169
	.byte	0x5
	.uleb128 0xab
	.long	.LASF170
	.byte	0x5
	.uleb128 0xac
	.long	.LASF171
	.byte	0x5
	.uleb128 0xad
	.long	.LASF172
	.byte	0x5
	.uleb128 0xae
	.long	.LASF173
	.byte	0x5
	.uleb128 0xaf
	.long	.LASF174
	.byte	0x5
	.uleb128 0xb0
	.long	.LASF175
	.byte	0x5
	.uleb128 0xb1
	.long	.LASF176
	.byte	0x5
	.uleb128 0xb2
	.long	.LASF177
	.byte	0x5
	.uleb128 0xb3
	.long	.LASF178
	.byte	0x5
	.uleb128 0xb4
	.long	.LASF179
	.byte	0x5
	.uleb128 0xb5
	.long	.LASF180
	.byte	0x5
	.uleb128 0xb6
	.long	.LASF181
	.byte	0x5
	.uleb128 0xb7
	.long	.LASF182
	.byte	0x5
	.uleb128 0xb8
	.long	.LASF183
	.byte	0x5
	.uleb128 0xb9
	.long	.LASF184
	.byte	0x5
	.uleb128 0xba
	.long	.LASF185
	.byte	0x5
	.uleb128 0xbb
	.long	.LASF186
	.byte	0x5
	.uleb128 0xbc
	.long	.LASF187
	.byte	0x5
	.uleb128 0xbd
	.long	.LASF188
	.byte	0x5
	.uleb128 0xbe
	.long	.LASF189
	.byte	0x5
	.uleb128 0xbf
	.long	.LASF190
	.byte	0x5
	.uleb128 0xc0
	.long	.LASF191
	.byte	0x5
	.uleb128 0xc1
	.long	.LASF192
	.byte	0x5
	.uleb128 0xc2
	.long	.LASF193
	.byte	0x5
	.uleb128 0xc3
	.long	.LASF194
	.byte	0x5
	.uleb128 0xc4
	.long	.LASF195
	.byte	0x5
	.uleb128 0xc5
	.long	.LASF196
	.byte	0x5
	.uleb128 0xc6
	.long	.LASF197
	.byte	0x5
	.uleb128 0xc7
	.long	.LASF198
	.byte	0x5
	.uleb128 0xc8
	.long	.LASF199
	.byte	0x5
	.uleb128 0xc9
	.long	.LASF200
	.byte	0x5
	.uleb128 0xca
	.long	.LASF201
	.byte	0x5
	.uleb128 0xcb
	.long	.LASF202
	.byte	0x5
	.uleb128 0xcc
	.long	.LASF203
	.byte	0x5
	.uleb128 0xcd
	.long	.LASF204
	.byte	0x5
	.uleb128 0xce
	.long	.LASF205
	.byte	0x5
	.uleb128 0xcf
	.long	.LASF206
	.byte	0x5
	.uleb128 0xd0
	.long	.LASF207
	.byte	0x5
	.uleb128 0xd1
	.long	.LASF208
	.byte	0x5
	.uleb128 0xd2
	.long	.LASF209
	.byte	0x5
	.uleb128 0xd3
	.long	.LASF210
	.byte	0x5
	.uleb128 0xd4
	.long	.LASF211
	.byte	0x5
	.uleb128 0xd5
	.long	.LASF212
	.byte	0x5
	.uleb128 0xd6
	.long	.LASF213
	.byte	0x5
	.uleb128 0xd7
	.long	.LASF214
	.byte	0x5
	.uleb128 0xd8
	.long	.LASF215
	.byte	0x5
	.uleb128 0xd9
	.long	.LASF216
	.byte	0x5
	.uleb128 0xda
	.long	.LASF217
	.byte	0x5
	.uleb128 0xdb
	.long	.LASF218
	.byte	0x5
	.uleb128 0xdc
	.long	.LASF219
	.byte	0x5
	.uleb128 0xdd
	.long	.LASF220
	.byte	0x5
	.uleb128 0xde
	.long	.LASF221
	.byte	0x5
	.uleb128 0xdf
	.long	.LASF222
	.byte	0x5
	.uleb128 0xe0
	.long	.LASF223
	.byte	0x5
	.uleb128 0xe1
	.long	.LASF224
	.byte	0x5
	.uleb128 0xe2
	.long	.LASF225
	.byte	0x5
	.uleb128 0xe3
	.long	.LASF226
	.byte	0x5
	.uleb128 0xe4
	.long	.LASF227
	.byte	0x5
	.uleb128 0xe5
	.long	.LASF228
	.byte	0x5
	.uleb128 0xe6
	.long	.LASF229
	.byte	0x5
	.uleb128 0xe7
	.long	.LASF230
	.byte	0x5
	.uleb128 0xe8
	.long	.LASF231
	.byte	0x5
	.uleb128 0xe9
	.long	.LASF232
	.byte	0x5
	.uleb128 0xea
	.long	.LASF233
	.byte	0x5
	.uleb128 0xeb
	.long	.LASF234
	.byte	0x5
	.uleb128 0xec
	.long	.LASF235
	.byte	0x5
	.uleb128 0xed
	.long	.LASF236
	.byte	0x5
	.uleb128 0xee
	.long	.LASF237
	.byte	0x5
	.uleb128 0xef
	.long	.LASF238
	.byte	0x5
	.uleb128 0xf0
	.long	.LASF239
	.byte	0x5
	.uleb128 0xf1
	.long	.LASF240
	.byte	0x5
	.uleb128 0xf2
	.long	.LASF241
	.byte	0x5
	.uleb128 0xf3
	.long	.LASF242
	.byte	0x5
	.uleb128 0xf4
	.long	.LASF243
	.byte	0x5
	.uleb128 0xf5
	.long	.LASF244
	.byte	0x5
	.uleb128 0xf6
	.long	.LASF245
	.byte	0x5
	.uleb128 0xf7
	.long	.LASF246
	.byte	0x5
	.uleb128 0xf8
	.long	.LASF247
	.byte	0x5
	.uleb128 0xf9
	.long	.LASF248
	.byte	0x5
	.uleb128 0xfa
	.long	.LASF249
	.byte	0x5
	.uleb128 0xfb
	.long	.LASF250
	.byte	0x5
	.uleb128 0xfc
	.long	.LASF251
	.byte	0x5
	.uleb128 0xfd
	.long	.LASF252
	.byte	0x5
	.uleb128 0xfe
	.long	.LASF253
	.byte	0x5
	.uleb128 0xff
	.long	.LASF254
	.byte	0x5
	.uleb128 0x100
	.long	.LASF255
	.byte	0x5
	.uleb128 0x101
	.long	.LASF256
	.byte	0x5
	.uleb128 0x102
	.long	.LASF257
	.byte	0x5
	.uleb128 0x103
	.long	.LASF258
	.byte	0x5
	.uleb128 0x104
	.long	.LASF259
	.byte	0x5
	.uleb128 0x105
	.long	.LASF260
	.byte	0x5
	.uleb128 0x106
	.long	.LASF261
	.byte	0x5
	.uleb128 0x107
	.long	.LASF262
	.byte	0x5
	.uleb128 0x108
	.long	.LASF263
	.byte	0x5
	.uleb128 0x109
	.long	.LASF264
	.byte	0x5
	.uleb128 0x10a
	.long	.LASF265
	.byte	0x5
	.uleb128 0x10b
	.long	.LASF266
	.byte	0x5
	.uleb128 0x10c
	.long	.LASF267
	.byte	0x5
	.uleb128 0x10d
	.long	.LASF268
	.byte	0x5
	.uleb128 0x10e
	.long	.LASF269
	.byte	0x5
	.uleb128 0x10f
	.long	.LASF270
	.byte	0x5
	.uleb128 0x110
	.long	.LASF271
	.byte	0x5
	.uleb128 0x111
	.long	.LASF272
	.byte	0x5
	.uleb128 0x112
	.long	.LASF273
	.byte	0x5
	.uleb128 0x113
	.long	.LASF274
	.byte	0x5
	.uleb128 0x114
	.long	.LASF275
	.byte	0x5
	.uleb128 0x115
	.long	.LASF276
	.byte	0x5
	.uleb128 0x116
	.long	.LASF277
	.byte	0x5
	.uleb128 0x117
	.long	.LASF278
	.byte	0x5
	.uleb128 0x118
	.long	.LASF279
	.byte	0x5
	.uleb128 0x119
	.long	.LASF280
	.byte	0x5
	.uleb128 0x11a
	.long	.LASF281
	.byte	0x5
	.uleb128 0x11b
	.long	.LASF282
	.byte	0x5
	.uleb128 0x11c
	.long	.LASF283
	.byte	0x5
	.uleb128 0x11d
	.long	.LASF284
	.byte	0x5
	.uleb128 0x11e
	.long	.LASF285
	.byte	0x5
	.uleb128 0x11f
	.long	.LASF286
	.byte	0x5
	.uleb128 0x120
	.long	.LASF287
	.byte	0x5
	.uleb128 0x121
	.long	.LASF288
	.byte	0x5
	.uleb128 0x122
	.long	.LASF289
	.byte	0x5
	.uleb128 0x123
	.long	.LASF290
	.byte	0x5
	.uleb128 0x124
	.long	.LASF291
	.byte	0x5
	.uleb128 0x125
	.long	.LASF292
	.byte	0x5
	.uleb128 0x126
	.long	.LASF293
	.byte	0x5
	.uleb128 0x127
	.long	.LASF294
	.byte	0x5
	.uleb128 0x128
	.long	.LASF295
	.byte	0x5
	.uleb128 0x129
	.long	.LASF296
	.byte	0x5
	.uleb128 0x12a
	.long	.LASF297
	.byte	0x5
	.uleb128 0x12b
	.long	.LASF298
	.byte	0x5
	.uleb128 0x12c
	.long	.LASF299
	.byte	0x5
	.uleb128 0x12d
	.long	.LASF300
	.byte	0x5
	.uleb128 0x12e
	.long	.LASF301
	.byte	0x5
	.uleb128 0x12f
	.long	.LASF302
	.byte	0x5
	.uleb128 0x130
	.long	.LASF303
	.byte	0x5
	.uleb128 0x131
	.long	.LASF304
	.byte	0x5
	.uleb128 0x132
	.long	.LASF305
	.byte	0x5
	.uleb128 0x133
	.long	.LASF306
	.byte	0x5
	.uleb128 0x134
	.long	.LASF307
	.byte	0x5
	.uleb128 0x135
	.long	.LASF308
	.byte	0x5
	.uleb128 0x136
	.long	.LASF309
	.byte	0x5
	.uleb128 0x137
	.long	.LASF310
	.byte	0x5
	.uleb128 0x138
	.long	.LASF311
	.byte	0x5
	.uleb128 0x139
	.long	.LASF312
	.byte	0x5
	.uleb128 0x13a
	.long	.LASF313
	.byte	0x5
	.uleb128 0x13b
	.long	.LASF314
	.byte	0x5
	.uleb128 0x13c
	.long	.LASF315
	.byte	0x5
	.uleb128 0x13d
	.long	.LASF316
	.byte	0x5
	.uleb128 0x13e
	.long	.LASF317
	.byte	0x5
	.uleb128 0x13f
	.long	.LASF318
	.byte	0x5
	.uleb128 0x140
	.long	.LASF319
	.byte	0x5
	.uleb128 0x141
	.long	.LASF320
	.byte	0x5
	.uleb128 0x142
	.long	.LASF321
	.byte	0x5
	.uleb128 0x143
	.long	.LASF322
	.byte	0x5
	.uleb128 0x144
	.long	.LASF323
	.byte	0x5
	.uleb128 0x145
	.long	.LASF324
	.byte	0x5
	.uleb128 0x146
	.long	.LASF325
	.byte	0x5
	.uleb128 0x147
	.long	.LASF326
	.byte	0x5
	.uleb128 0x148
	.long	.LASF327
	.byte	0x5
	.uleb128 0x149
	.long	.LASF328
	.byte	0x5
	.uleb128 0x14a
	.long	.LASF329
	.byte	0x5
	.uleb128 0x14b
	.long	.LASF330
	.byte	0x5
	.uleb128 0x14c
	.long	.LASF331
	.byte	0x5
	.uleb128 0x14d
	.long	.LASF332
	.byte	0x5
	.uleb128 0x14e
	.long	.LASF333
	.byte	0x5
	.uleb128 0x14f
	.long	.LASF334
	.byte	0x5
	.uleb128 0x150
	.long	.LASF335
	.byte	0x5
	.uleb128 0x151
	.long	.LASF336
	.byte	0x5
	.uleb128 0x152
	.long	.LASF337
	.byte	0x5
	.uleb128 0x153
	.long	.LASF338
	.byte	0x5
	.uleb128 0x154
	.long	.LASF339
	.byte	0x5
	.uleb128 0x155
	.long	.LASF340
	.byte	0x5
	.uleb128 0x156
	.long	.LASF341
	.byte	0x5
	.uleb128 0x157
	.long	.LASF342
	.file 3 "/usr/include/stdc-predef.h"
	.byte	0x3
	.uleb128 0x1f
	.uleb128 0x3
	.byte	0x7
	.long	.Ldebug_macro2
	.byte	0x4
	.file 4 "./mem/mem_management.h"
	.byte	0x3
	.uleb128 0x1
	.uleb128 0x4
	.byte	0x7
	.long	.Ldebug_macro3
	.byte	0x4
	.byte	0x5
	.uleb128 0x4
	.long	.LASF351
	.byte	0x4
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdcpredef.h.19.8dc41bed5d9037ff9622e015fb5f0ce3,comdat
.Ldebug_macro2:
	.value	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x13
	.long	.LASF343
	.byte	0x5
	.uleb128 0x26
	.long	.LASF344
	.byte	0x5
	.uleb128 0x2e
	.long	.LASF345
	.byte	0x5
	.uleb128 0x3a
	.long	.LASF346
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.mem_management.h.2.1e448dfbd0fee82c6810a1a1064e2daf,comdat
.Ldebug_macro3:
	.value	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x2
	.long	.LASF347
	.byte	0x5
	.uleb128 0x9
	.long	.LASF348
	.byte	0x5
	.uleb128 0xb
	.long	.LASF349
	.byte	0x5
	.uleb128 0xd
	.long	.LASF350
	.byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF100:
	.string	"__SIG_ATOMIC_MAX__ 0x7fffffff"
.LASF222:
	.string	"__FLT64_HAS_QUIET_NAN__ 1"
.LASF278:
	.string	"__DEC64_SUBNORMAL_MIN__ 0.000000000000001E-383DD"
.LASF80:
	.string	"__WCHAR_MAX__ 0x7fffffff"
.LASF207:
	.string	"__FLT32_HAS_INFINITY__ 1"
.LASF213:
	.string	"__FLT64_MAX_EXP__ 1024"
.LASF155:
	.string	"__FLT_MIN_10_EXP__ (-37)"
.LASF260:
	.string	"__FLT64X_EPSILON__ 1.08420217248550443400745280086994171e-19F64x"
.LASF241:
	.string	"__FLT32X_MAX_EXP__ 1024"
.LASF381:
	.string	"mem_free"
.LASF277:
	.string	"__DEC64_EPSILON__ 1E-15DD"
.LASF176:
	.string	"__DBL_DENORM_MIN__ ((double)4.94065645841246544176568792868221372e-324L)"
.LASF143:
	.string	"__INTPTR_MAX__ 0x7fffffffffffffffL"
.LASF195:
	.string	"__FLT32_MANT_DIG__ 24"
.LASF293:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1"
.LASF243:
	.string	"__FLT32X_DECIMAL_DIG__ 17"
.LASF168:
	.string	"__DBL_MIN_EXP__ (-1021)"
.LASF364:
	.string	"memtable_size"
.LASF73:
	.string	"__has_include_next(STR) __has_include_next__(STR)"
.LASF244:
	.string	"__FLT32X_MAX__ 1.79769313486231570814527423731704357e+308F32x"
.LASF311:
	.string	"__SIZEOF_WINT_T__ 4"
.LASF145:
	.string	"__UINTPTR_MAX__ 0xffffffffffffffffUL"
.LASF350:
	.string	"MEM_TABLE_SIZE MEM_MAX_SIZE/MEM_BLOCK_SIZE"
.LASF6:
	.string	"__GNUC_MINOR__ 4"
.LASF110:
	.string	"__UINT64_MAX__ 0xffffffffffffffffUL"
.LASF352:
	.string	"unsigned int"
.LASF217:
	.string	"__FLT64_MIN__ 2.22507385850720138309023271733240406e-308F64"
.LASF90:
	.string	"__LONG_LONG_WIDTH__ 64"
.LASF162:
	.string	"__FLT_DENORM_MIN__ 1.40129846432481707092372958328991613e-45F"
.LASF43:
	.string	"__CHAR16_TYPE__ short unsigned int"
.LASF366:
	.string	"memrdy"
.LASF28:
	.string	"__SIZEOF_SIZE_T__ 8"
.LASF32:
	.string	"__ORDER_BIG_ENDIAN__ 4321"
.LASF5:
	.string	"__GNUC__ 9"
.LASF130:
	.string	"__UINT64_C(c) c ## UL"
.LASF166:
	.string	"__DBL_MANT_DIG__ 53"
.LASF202:
	.string	"__FLT32_MAX__ 3.40282346638528859811704183484516925e+38F32"
.LASF374:
	.string	"cmemblock"
.LASF77:
	.string	"__INT_MAX__ 0x7fffffff"
.LASF12:
	.string	"__ATOMIC_RELEASE 3"
.LASF47:
	.string	"__INT16_TYPE__ short int"
.LASF342:
	.string	"__DECIMAL_BID_FORMAT__ 1"
.LASF270:
	.string	"__DEC32_EPSILON__ 1E-6DF"
.LASF17:
	.string	"__OPTIMIZE__ 1"
.LASF385:
	.string	"memset"
.LASF181:
	.string	"__LDBL_DIG__ 18"
.LASF255:
	.string	"__FLT64X_MAX_EXP__ 16384"
.LASF10:
	.string	"__ATOMIC_SEQ_CST 5"
.LASF371:
	.string	"memblock"
.LASF24:
	.string	"__SIZEOF_SHORT__ 2"
.LASF361:
	.string	"membase"
.LASF53:
	.string	"__UINT64_TYPE__ long unsigned int"
.LASF135:
	.string	"__INT_FAST32_MAX__ 0x7fffffffffffffffL"
.LASF54:
	.string	"__INT_LEAST8_TYPE__ signed char"
.LASF60:
	.string	"__UINT_LEAST32_TYPE__ unsigned int"
.LASF34:
	.string	"__BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__"
.LASF189:
	.string	"__LDBL_MIN__ 3.36210314311209350626267781732175260e-4932L"
.LASF337:
	.string	"linux 1"
.LASF198:
	.string	"__FLT32_MIN_10_EXP__ (-37)"
.LASF177:
	.string	"__DBL_HAS_DENORM__ 1"
.LASF376:
	.string	"GNU C17 9.4.0 -mtune=generic -march=x86-64 -g3 -O3 -fPIC -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF81:
	.string	"__WCHAR_MIN__ (-__WCHAR_MAX__ - 1)"
.LASF3:
	.string	"__STDC_UTF_32__ 1"
.LASF114:
	.string	"__INT_LEAST16_MAX__ 0x7fff"
.LASF75:
	.string	"__SCHAR_MAX__ 0x7f"
.LASF210:
	.string	"__FLT64_DIG__ 15"
.LASF62:
	.string	"__INT_FAST8_TYPE__ signed char"
.LASF9:
	.string	"__ATOMIC_RELAXED 0"
.LASF360:
	.string	"peruser"
.LASF249:
	.string	"__FLT32X_HAS_INFINITY__ 1"
.LASF235:
	.string	"__FLT128_HAS_INFINITY__ 1"
.LASF339:
	.string	"__unix__ 1"
.LASF58:
	.string	"__UINT_LEAST8_TYPE__ unsigned char"
.LASF309:
	.string	"__SIZEOF_INT128__ 16"
.LASF112:
	.string	"__INT8_C(c) c"
.LASF230:
	.string	"__FLT128_MAX__ 1.18973149535723176508575932662800702e+4932F128"
.LASF56:
	.string	"__INT_LEAST32_TYPE__ int"
.LASF116:
	.string	"__INT_LEAST16_WIDTH__ 16"
.LASF347:
	.string	"_MEM_MANAGEMENT_H "
.LASF206:
	.string	"__FLT32_HAS_DENORM__ 1"
.LASF373:
	.string	"size"
.LASF290:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1"
.LASF253:
	.string	"__FLT64X_MIN_EXP__ (-16381)"
.LASF153:
	.string	"__FLT_DIG__ 6"
.LASF134:
	.string	"__INT_FAST16_WIDTH__ 64"
.LASF268:
	.string	"__DEC32_MIN__ 1E-95DF"
.LASF146:
	.string	"__GCC_IEC_559 2"
.LASF225:
	.string	"__FLT128_MIN_EXP__ (-16381)"
.LASF384:
	.string	"mem_init"
.LASF208:
	.string	"__FLT32_HAS_QUIET_NAN__ 1"
.LASF125:
	.string	"__UINT_LEAST16_MAX__ 0xffff"
.LASF142:
	.string	"__UINT_FAST64_MAX__ 0xffffffffffffffffUL"
.LASF123:
	.string	"__UINT_LEAST8_MAX__ 0xff"
.LASF280:
	.string	"__DEC128_MIN_EXP__ (-6142)"
.LASF39:
	.string	"__WCHAR_TYPE__ int"
.LASF103:
	.string	"__INT8_MAX__ 0x7f"
.LASF284:
	.string	"__DEC128_EPSILON__ 1E-33DL"
.LASF333:
	.string	"__CET__ 3"
.LASF227:
	.string	"__FLT128_MAX_EXP__ 16384"
.LASF151:
	.string	"__FLT_RADIX__ 2"
.LASF247:
	.string	"__FLT32X_DENORM_MIN__ 4.94065645841246544176568792868221372e-324F32x"
.LASF27:
	.string	"__SIZEOF_LONG_DOUBLE__ 16"
.LASF179:
	.string	"__DBL_HAS_QUIET_NAN__ 1"
.LASF191:
	.string	"__LDBL_DENORM_MIN__ 3.64519953188247460252840593361941982e-4951L"
.LASF370:
	.string	"mem_free_c"
.LASF221:
	.string	"__FLT64_HAS_INFINITY__ 1"
.LASF139:
	.string	"__UINT_FAST8_MAX__ 0xff"
.LASF320:
	.string	"__ATOMIC_HLE_RELEASE 131072"
.LASF184:
	.string	"__LDBL_MAX_EXP__ 16384"
.LASF41:
	.string	"__INTMAX_TYPE__ long int"
.LASF351:
	.string	"NULL 0"
.LASF70:
	.string	"__INTPTR_TYPE__ long int"
.LASF276:
	.string	"__DEC64_MAX__ 9.999999999999999E384DD"
.LASF300:
	.string	"__GCC_ATOMIC_INT_LOCK_FREE 2"
.LASF325:
	.string	"__MMX__ 1"
.LASF252:
	.string	"__FLT64X_DIG__ 18"
.LASF122:
	.string	"__INT_LEAST64_WIDTH__ 64"
.LASF223:
	.string	"__FLT128_MANT_DIG__ 113"
.LASF31:
	.string	"__ORDER_LITTLE_ENDIAN__ 1234"
.LASF312:
	.string	"__SIZEOF_PTRDIFF_T__ 8"
.LASF279:
	.string	"__DEC128_MANT_DIG__ 34"
.LASF48:
	.string	"__INT32_TYPE__ int"
.LASF324:
	.string	"__code_model_small__ 1"
.LASF262:
	.string	"__FLT64X_HAS_DENORM__ 1"
.LASF267:
	.string	"__DEC32_MAX_EXP__ 97"
.LASF382:
	.string	"mem_malloc"
.LASF365:
	.string	"memblock_size"
.LASF368:
	.string	"offset"
.LASF363:
	.string	"mem_size"
.LASF345:
	.string	"__STDC_IEC_559_COMPLEX__ 1"
.LASF377:
	.string	"./mem/mem_management.c"
.LASF254:
	.string	"__FLT64X_MIN_10_EXP__ (-4931)"
.LASF346:
	.string	"__STDC_ISO_10646__ 201706L"
.LASF305:
	.string	"__HAVE_SPECULATION_SAFE_VALUE 1"
.LASF228:
	.string	"__FLT128_MAX_10_EXP__ 4932"
.LASF231:
	.string	"__FLT128_MIN__ 3.36210314311209350626267781732175260e-4932F128"
.LASF378:
	.string	"/mnt/d/work/vmware/work/tt/list-array-mem"
.LASF132:
	.string	"__INT_FAST8_WIDTH__ 8"
.LASF212:
	.string	"__FLT64_MIN_10_EXP__ (-307)"
.LASF173:
	.string	"__DBL_MAX__ ((double)1.79769313486231570814527423731704357e+308L)"
.LASF314:
	.string	"__amd64__ 1"
.LASF201:
	.string	"__FLT32_DECIMAL_DIG__ 9"
.LASF224:
	.string	"__FLT128_DIG__ 33"
.LASF51:
	.string	"__UINT16_TYPE__ short unsigned int"
.LASF91:
	.string	"__WCHAR_WIDTH__ 32"
.LASF295:
	.string	"__GCC_ATOMIC_CHAR_LOCK_FREE 2"
.LASF79:
	.string	"__LONG_LONG_MAX__ 0x7fffffffffffffffLL"
.LASF59:
	.string	"__UINT_LEAST16_TYPE__ short unsigned int"
.LASF157:
	.string	"__FLT_MAX_10_EXP__ 38"
.LASF78:
	.string	"__LONG_MAX__ 0x7fffffffffffffffL"
.LASF246:
	.string	"__FLT32X_EPSILON__ 2.22044604925031308084726333618164062e-16F32x"
.LASF383:
	.string	"mem_offset"
.LASF95:
	.string	"__INTMAX_MAX__ 0x7fffffffffffffffL"
.LASF256:
	.string	"__FLT64X_MAX_10_EXP__ 4932"
.LASF292:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1"
.LASF197:
	.string	"__FLT32_MIN_EXP__ (-125)"
.LASF37:
	.string	"__SIZE_TYPE__ long unsigned int"
.LASF188:
	.string	"__LDBL_MAX__ 1.18973149535723176502126385303097021e+4932L"
.LASF150:
	.string	"__DEC_EVAL_METHOD__ 2"
.LASF159:
	.string	"__FLT_MAX__ 3.40282346638528859811704183484516925e+38F"
.LASF169:
	.string	"__DBL_MIN_10_EXP__ (-307)"
.LASF356:
	.string	"char"
.LASF74:
	.string	"__GXX_ABI_VERSION 1013"
.LASF183:
	.string	"__LDBL_MIN_10_EXP__ (-4931)"
.LASF369:
	.string	"mem_peruser"
.LASF220:
	.string	"__FLT64_HAS_DENORM__ 1"
.LASF148:
	.string	"__FLT_EVAL_METHOD__ 0"
.LASF248:
	.string	"__FLT32X_HAS_DENORM__ 1"
.LASF316:
	.string	"__x86_64__ 1"
.LASF96:
	.string	"__INTMAX_C(c) c ## L"
.LASF258:
	.string	"__FLT64X_MAX__ 1.18973149535723176502126385303097021e+4932F64x"
.LASF298:
	.string	"__GCC_ATOMIC_WCHAR_T_LOCK_FREE 2"
.LASF120:
	.string	"__INT_LEAST64_MAX__ 0x7fffffffffffffffL"
.LASF113:
	.string	"__INT_LEAST8_WIDTH__ 8"
.LASF107:
	.string	"__UINT8_MAX__ 0xff"
.LASF108:
	.string	"__UINT16_MAX__ 0xffff"
.LASF65:
	.string	"__INT_FAST64_TYPE__ long int"
.LASF372:
	.string	"memblock_count"
.LASF109:
	.string	"__UINT32_MAX__ 0xffffffffU"
.LASF99:
	.string	"__INTMAX_WIDTH__ 64"
.LASF269:
	.string	"__DEC32_MAX__ 9.999999E96DF"
.LASF84:
	.string	"__PTRDIFF_MAX__ 0x7fffffffffffffffL"
.LASF55:
	.string	"__INT_LEAST16_TYPE__ short int"
.LASF199:
	.string	"__FLT32_MAX_EXP__ 128"
.LASF334:
	.string	"__gnu_linux__ 1"
.LASF318:
	.string	"__SIZEOF_FLOAT128__ 16"
.LASF167:
	.string	"__DBL_DIG__ 15"
.LASF296:
	.string	"__GCC_ATOMIC_CHAR16_T_LOCK_FREE 2"
.LASF111:
	.string	"__INT_LEAST8_MAX__ 0x7f"
.LASF20:
	.string	"__LP64__ 1"
.LASF301:
	.string	"__GCC_ATOMIC_LONG_LOCK_FREE 2"
.LASF238:
	.string	"__FLT32X_DIG__ 15"
.LASF237:
	.string	"__FLT32X_MANT_DIG__ 53"
.LASF19:
	.string	"_LP64 1"
.LASF196:
	.string	"__FLT32_DIG__ 6"
.LASF315:
	.string	"__x86_64 1"
.LASF29:
	.string	"__CHAR_BIT__ 8"
.LASF174:
	.string	"__DBL_MIN__ ((double)2.22507385850720138309023271733240406e-308L)"
.LASF294:
	.string	"__GCC_ATOMIC_BOOL_LOCK_FREE 2"
.LASF141:
	.string	"__UINT_FAST32_MAX__ 0xffffffffffffffffUL"
.LASF18:
	.string	"__FINITE_MATH_ONLY__ 0"
.LASF216:
	.string	"__FLT64_MAX__ 1.79769313486231570814527423731704357e+308F64"
.LASF50:
	.string	"__UINT8_TYPE__ unsigned char"
.LASF288:
	.string	"_FORTIFY_SOURCE 2"
.LASF321:
	.string	"__GCC_ASM_FLAG_OUTPUTS__ 1"
.LASF129:
	.string	"__UINT_LEAST64_MAX__ 0xffffffffffffffffUL"
.LASF341:
	.string	"__ELF__ 1"
.LASF245:
	.string	"__FLT32X_MIN__ 2.22507385850720138309023271733240406e-308F32x"
.LASF71:
	.string	"__UINTPTR_TYPE__ long unsigned int"
.LASF303:
	.string	"__GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1"
.LASF306:
	.string	"__GCC_HAVE_DWARF2_CFI_ASM 1"
.LASF25:
	.string	"__SIZEOF_FLOAT__ 4"
.LASF271:
	.string	"__DEC32_SUBNORMAL_MIN__ 0.000001E-95DF"
.LASF264:
	.string	"__FLT64X_HAS_QUIET_NAN__ 1"
.LASF164:
	.string	"__FLT_HAS_INFINITY__ 1"
.LASF0:
	.string	"__STDC__ 1"
.LASF327:
	.string	"__SSE2__ 1"
.LASF170:
	.string	"__DBL_MAX_EXP__ 1024"
.LASF22:
	.string	"__SIZEOF_LONG__ 8"
.LASF14:
	.string	"__ATOMIC_CONSUME 1"
.LASF348:
	.string	"MEM_BLOCK_SIZE 32"
.LASF287:
	.string	"__USER_LABEL_PREFIX__ "
.LASF40:
	.string	"__WINT_TYPE__ unsigned int"
.LASF104:
	.string	"__INT16_MAX__ 0x7fff"
.LASF86:
	.string	"__SCHAR_WIDTH__ 8"
.LASF128:
	.string	"__UINT32_C(c) c ## U"
.LASF64:
	.string	"__INT_FAST32_TYPE__ long int"
.LASF26:
	.string	"__SIZEOF_DOUBLE__ 8"
.LASF7:
	.string	"__GNUC_PATCHLEVEL__ 0"
.LASF124:
	.string	"__UINT8_C(c) c"
.LASF83:
	.string	"__WINT_MIN__ 0U"
.LASF180:
	.string	"__LDBL_MANT_DIG__ 64"
.LASF2:
	.string	"__STDC_UTF_16__ 1"
.LASF190:
	.string	"__LDBL_EPSILON__ 1.08420217248550443400745280086994171e-19L"
.LASF193:
	.string	"__LDBL_HAS_INFINITY__ 1"
.LASF147:
	.string	"__GCC_IEC_559_COMPLEX 2"
.LASF101:
	.string	"__SIG_ATOMIC_MIN__ (-__SIG_ATOMIC_MAX__ - 1)"
.LASF310:
	.string	"__SIZEOF_WCHAR_T__ 4"
.LASF226:
	.string	"__FLT128_MIN_10_EXP__ (-4931)"
.LASF35:
	.string	"__FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__"
.LASF291:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1"
.LASF265:
	.string	"__DEC32_MANT_DIG__ 7"
.LASF205:
	.string	"__FLT32_DENORM_MIN__ 1.40129846432481707092372958328991613e-45F32"
.LASF273:
	.string	"__DEC64_MIN_EXP__ (-382)"
.LASF140:
	.string	"__UINT_FAST16_MAX__ 0xffffffffffffffffUL"
.LASF105:
	.string	"__INT32_MAX__ 0x7fffffff"
.LASF11:
	.string	"__ATOMIC_ACQUIRE 2"
.LASF126:
	.string	"__UINT16_C(c) c"
.LASF106:
	.string	"__INT64_MAX__ 0x7fffffffffffffffL"
.LASF332:
	.string	"__SEG_GS 1"
.LASF329:
	.string	"__SSE_MATH__ 1"
.LASF42:
	.string	"__UINTMAX_TYPE__ long unsigned int"
.LASF281:
	.string	"__DEC128_MAX_EXP__ 6145"
.LASF102:
	.string	"__SIG_ATOMIC_WIDTH__ 32"
.LASF76:
	.string	"__SHRT_MAX__ 0x7fff"
.LASF33:
	.string	"__ORDER_PDP_ENDIAN__ 3412"
.LASF158:
	.string	"__FLT_DECIMAL_DIG__ 9"
.LASF214:
	.string	"__FLT64_MAX_10_EXP__ 308"
.LASF182:
	.string	"__LDBL_MIN_EXP__ (-16381)"
.LASF92:
	.string	"__WINT_WIDTH__ 32"
.LASF259:
	.string	"__FLT64X_MIN__ 3.36210314311209350626267781732175260e-4932F64x"
.LASF131:
	.string	"__INT_FAST8_MAX__ 0x7f"
.LASF21:
	.string	"__SIZEOF_INT__ 4"
.LASF204:
	.string	"__FLT32_EPSILON__ 1.19209289550781250000000000000000000e-7F32"
.LASF137:
	.string	"__INT_FAST64_MAX__ 0x7fffffffffffffffL"
.LASF236:
	.string	"__FLT128_HAS_QUIET_NAN__ 1"
.LASF274:
	.string	"__DEC64_MAX_EXP__ 385"
.LASF367:
	.string	"mem_dev"
.LASF240:
	.string	"__FLT32X_MIN_10_EXP__ (-307)"
.LASF375:
	.string	"long int"
.LASF379:
	.string	"_mem_man_dev"
.LASF98:
	.string	"__UINTMAX_C(c) c ## UL"
.LASF44:
	.string	"__CHAR32_TYPE__ unsigned int"
.LASF263:
	.string	"__FLT64X_HAS_INFINITY__ 1"
.LASF282:
	.string	"__DEC128_MIN__ 1E-6143DL"
.LASF239:
	.string	"__FLT32X_MIN_EXP__ (-1021)"
.LASF144:
	.string	"__INTPTR_WIDTH__ 64"
.LASF66:
	.string	"__UINT_FAST8_TYPE__ unsigned char"
.LASF118:
	.string	"__INT32_C(c) c"
.LASF194:
	.string	"__LDBL_HAS_QUIET_NAN__ 1"
.LASF46:
	.string	"__INT8_TYPE__ signed char"
.LASF82:
	.string	"__WINT_MAX__ 0xffffffffU"
.LASF335:
	.string	"__linux 1"
.LASF115:
	.string	"__INT16_C(c) c"
.LASF52:
	.string	"__UINT32_TYPE__ unsigned int"
.LASF232:
	.string	"__FLT128_EPSILON__ 1.92592994438723585305597794258492732e-34F128"
.LASF23:
	.string	"__SIZEOF_LONG_LONG__ 8"
.LASF68:
	.string	"__UINT_FAST32_TYPE__ long unsigned int"
.LASF87:
	.string	"__SHRT_WIDTH__ 16"
.LASF330:
	.string	"__SSE2_MATH__ 1"
.LASF136:
	.string	"__INT_FAST32_WIDTH__ 64"
.LASF36:
	.string	"__SIZEOF_POINTER__ 8"
.LASF218:
	.string	"__FLT64_EPSILON__ 2.22044604925031308084726333618164062e-16F64"
.LASF251:
	.string	"__FLT64X_MANT_DIG__ 64"
.LASF386:
	.string	"__builtin_memset"
.LASF152:
	.string	"__FLT_MANT_DIG__ 24"
.LASF88:
	.string	"__INT_WIDTH__ 32"
.LASF187:
	.string	"__LDBL_DECIMAL_DIG__ 21"
.LASF304:
	.string	"__GCC_ATOMIC_POINTER_LOCK_FREE 2"
.LASF359:
	.string	"init"
.LASF331:
	.string	"__SEG_FS 1"
.LASF67:
	.string	"__UINT_FAST16_TYPE__ long unsigned int"
.LASF1:
	.string	"__STDC_VERSION__ 201710L"
.LASF355:
	.string	"long unsigned int"
.LASF297:
	.string	"__GCC_ATOMIC_CHAR32_T_LOCK_FREE 2"
.LASF380:
	.string	"rest_malloc"
.LASF319:
	.string	"__ATOMIC_HLE_ACQUIRE 65536"
.LASF4:
	.string	"__STDC_HOSTED__ 1"
.LASF94:
	.string	"__SIZE_WIDTH__ 64"
.LASF72:
	.string	"__has_include(STR) __has_include__(STR)"
.LASF89:
	.string	"__LONG_WIDTH__ 64"
.LASF349:
	.string	"MEM_MAX_SIZE 1024*1024"
.LASF322:
	.string	"__k8 1"
.LASF302:
	.string	"__GCC_ATOMIC_LLONG_LOCK_FREE 2"
.LASF156:
	.string	"__FLT_MAX_EXP__ 128"
.LASF13:
	.string	"__ATOMIC_ACQ_REL 4"
.LASF354:
	.string	"unsigned char"
.LASF266:
	.string	"__DEC32_MIN_EXP__ (-94)"
.LASF49:
	.string	"__INT64_TYPE__ long int"
.LASF160:
	.string	"__FLT_MIN__ 1.17549435082228750796873653722224568e-38F"
.LASF328:
	.string	"__FXSR__ 1"
.LASF119:
	.string	"__INT_LEAST32_WIDTH__ 32"
.LASF97:
	.string	"__UINTMAX_MAX__ 0xffffffffffffffffUL"
.LASF85:
	.string	"__SIZE_MAX__ 0xffffffffffffffffUL"
.LASF57:
	.string	"__INT_LEAST64_TYPE__ long int"
.LASF16:
	.string	"__PIC__ 2"
.LASF61:
	.string	"__UINT_LEAST64_TYPE__ long unsigned int"
.LASF323:
	.string	"__k8__ 1"
.LASF299:
	.string	"__GCC_ATOMIC_SHORT_LOCK_FREE 2"
.LASF257:
	.string	"__FLT64X_DECIMAL_DIG__ 21"
.LASF133:
	.string	"__INT_FAST16_MAX__ 0x7fffffffffffffffL"
.LASF161:
	.string	"__FLT_EPSILON__ 1.19209289550781250000000000000000000e-7F"
.LASF211:
	.string	"__FLT64_MIN_EXP__ (-1021)"
.LASF149:
	.string	"__FLT_EVAL_METHOD_TS_18661_3__ 0"
.LASF178:
	.string	"__DBL_HAS_INFINITY__ 1"
.LASF121:
	.string	"__INT64_C(c) c ## L"
.LASF165:
	.string	"__FLT_HAS_QUIET_NAN__ 1"
.LASF38:
	.string	"__PTRDIFF_TYPE__ long int"
.LASF362:
	.string	"memmap"
.LASF63:
	.string	"__INT_FAST16_TYPE__ long int"
.LASF344:
	.string	"__STDC_IEC_559__ 1"
.LASF285:
	.string	"__DEC128_SUBNORMAL_MIN__ 0.000000000000000000000000000000001E-6143DL"
.LASF343:
	.string	"_STDC_PREDEF_H 1"
.LASF317:
	.string	"__SIZEOF_FLOAT80__ 16"
.LASF250:
	.string	"__FLT32X_HAS_QUIET_NAN__ 1"
.LASF171:
	.string	"__DBL_MAX_10_EXP__ 308"
.LASF8:
	.string	"__VERSION__ \"9.4.0\""
.LASF358:
	.string	"mem_management_table"
.LASF353:
	.string	"short unsigned int"
.LASF15:
	.string	"__pic__ 2"
.LASF289:
	.string	"__GNUC_STDC_INLINE__ 1"
.LASF326:
	.string	"__SSE__ 1"
.LASF357:
	.string	"mem_buf"
.LASF30:
	.string	"__BIGGEST_ALIGNMENT__ 16"
.LASF233:
	.string	"__FLT128_DENORM_MIN__ 6.47517511943802511092443895822764655e-4966F128"
.LASF215:
	.string	"__FLT64_DECIMAL_DIG__ 17"
.LASF154:
	.string	"__FLT_MIN_EXP__ (-125)"
.LASF308:
	.string	"__SSP_STRONG__ 3"
.LASF283:
	.string	"__DEC128_MAX__ 9.999999999999999999999999999999999E6144DL"
.LASF286:
	.string	"__REGISTER_PREFIX__ "
.LASF127:
	.string	"__UINT_LEAST32_MAX__ 0xffffffffU"
.LASF242:
	.string	"__FLT32X_MAX_10_EXP__ 308"
.LASF313:
	.string	"__amd64 1"
.LASF338:
	.string	"__unix 1"
.LASF336:
	.string	"__linux__ 1"
.LASF219:
	.string	"__FLT64_DENORM_MIN__ 4.94065645841246544176568792868221372e-324F64"
.LASF200:
	.string	"__FLT32_MAX_10_EXP__ 38"
.LASF229:
	.string	"__FLT128_DECIMAL_DIG__ 36"
.LASF93:
	.string	"__PTRDIFF_WIDTH__ 64"
.LASF117:
	.string	"__INT_LEAST32_MAX__ 0x7fffffff"
.LASF69:
	.string	"__UINT_FAST64_TYPE__ long unsigned int"
.LASF185:
	.string	"__LDBL_MAX_10_EXP__ 4932"
.LASF275:
	.string	"__DEC64_MIN__ 1E-383DD"
.LASF203:
	.string	"__FLT32_MIN__ 1.17549435082228750796873653722224568e-38F32"
.LASF175:
	.string	"__DBL_EPSILON__ ((double)2.22044604925031308084726333618164062e-16L)"
.LASF340:
	.string	"unix 1"
.LASF307:
	.string	"__PRAGMA_REDEFINE_EXTNAME 1"
.LASF45:
	.string	"__SIG_ATOMIC_TYPE__ int"
.LASF261:
	.string	"__FLT64X_DENORM_MIN__ 3.64519953188247460252840593361941982e-4951F64x"
.LASF234:
	.string	"__FLT128_HAS_DENORM__ 1"
.LASF172:
	.string	"__DBL_DECIMAL_DIG__ 17"
.LASF192:
	.string	"__LDBL_HAS_DENORM__ 1"
.LASF209:
	.string	"__FLT64_MANT_DIG__ 53"
.LASF272:
	.string	"__DEC64_MANT_DIG__ 16"
.LASF163:
	.string	"__FLT_HAS_DENORM__ 1"
.LASF138:
	.string	"__INT_FAST64_WIDTH__ 64"
.LASF186:
	.string	"__DECIMAL_DIG__ 21"
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
