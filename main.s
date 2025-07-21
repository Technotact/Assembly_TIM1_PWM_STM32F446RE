.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb


.equ RCC_BASE,             0x40023800
.equ RCC_AHB1ENR,          (RCC_BASE + 0x30)
.equ RCC_APB1ENR,          (RCC_BASE + 0x40)
.equ GPIOA_EN,             (1 << 0)
.equ TIM2_EN,              (1 << 0)


.equ GPIOA_BASE,           0x40020000
.equ GPIOA_MODER,          (GPIOA_BASE + 0x00)
.equ GPIOA_AFRL,           (GPIOA_BASE + 0x20)


.equ GPIO_MODER_5_MASK,    (0x3 << 10)
.equ GPIO_MODER_5_AF,      (0x2 << 10)
.equ GPIO_AFRL5_MASK,      (0xF << 20)
.equ GPIO_AFRL5_AF1,       (0x1 << 20)


.equ TIM2_BASE,            0x40000000
.equ TIM2_PSC,             (TIM2_BASE + 0x28)
.equ TIM2_ARR,             (TIM2_BASE + 0x2C)
.equ TIM2_CCR1,            (TIM2_BASE + 0x34)
.equ TIM2_CCMR1,           (TIM2_BASE + 0x18)
.equ TIM2_CCER,            (TIM2_BASE + 0x20)
.equ TIM2_CR1,             (TIM2_BASE + 0x00)


.equ TIM_CCMR1_OC1M_PWM,   (0b110 << 4)
.equ TIM_CCMR1_OC1PE,      (1 << 3)
.equ TIM_CCER_CC1E,        (1 << 0)
.equ TIM_CR1_CEN,          (1 << 0)

.global main
main:
    LDR R0, =RCC_AHB1ENR
    LDR R1, [R0]
	ORR R1, R1, #GPIOA_EN
	STR R1, [R0]

	LDR R0, =RCC_APB1ENR
	LDR R1, [R0]
	ORR R1, R1, #TIM2_EN
	STR R1, [R0]


	LDR R0, =GPIOA_MODER
	LDR R1, [R0]
	BIC R1, R1, #GPIO_MODER_5_MASK
	ORR R1, R1, #GPIO_MODER_5_AF
	STR R1, [R0]


	LDR R0, =GPIOA_AFRL
	LDR R1, [R0]
	BIC R1, R1, #(0xF << 20)
	ORR R1, R1, #GPIO_AFRL5_AF1
	STR R1, [R0]


    LDR R0, =TIM2_PSC
    MOV R1, #83
    STR R1, [R0]


    LDR R0, =TIM2_ARR
    MOV R1, #999
    STR R1, [R0]


    LDR R0, =TIM2_CCR1
    MOV R1, #500
    STR R1, [R0]


    LDR R0, =TIM2_CCMR1
    MOV R1, #(TIM_CCMR1_OC1M_PWM | TIM_CCMR1_OC1PE)
    STR R1, [R0]


    LDR R0, =TIM2_CCER
    MOV R1, #TIM_CCER_CC1E
    STR R1, [R0]


    LDR R0, =TIM2_CR1
    MOV R1, #TIM_CR1_CEN
    STR R1, [R0]



/*
loop:
    ldr r0, =GPIOA_BSRR
    mov r1, #(1 << 5)
    str r1, [r0]

    ldr r0, =2000000
    bl delay

    ldr r0, =GPIOA_BSRR
    mov r1, #(1 << (5 + 16))
    str r1, [r0]

    ldr r0, =2000000
    bl delay

    b loop

delay:
delay_loop:
	subs	r0, #1
	bne		delay_loop
    bx		lr
*/
