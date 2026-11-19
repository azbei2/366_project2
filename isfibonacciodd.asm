        .data
n:      .word 10
result: .word 0
fib:    .word 0

        .text
        .globl main
main:
        lw   $a0, n
        jal  isfibonacciodd
        sw   $v0, result

        move $a0, $v0
        li   $v0, 1
        syscall

        li   $v0, 10
        syscall

isfibonacciodd:
        addi $sp, $sp, -4
        sw   $ra, 0($sp)

        jal  fibonacci
        sw   $v0, fib

        move $a0, $v0
        jal  isodd

        lw   $ra, 0($sp)
        addi $sp, $sp, 4
        jr   $ra

fibonacci:
        slti $t0, $a0, 2
        beq  $t0, $zero, fib_init
        move $v0, $a0
        jr   $ra

fib_init:
        li   $t1, 0
        li   $t2, 1
        addi $t3, $a0, -1

fib_loop:
        move $t4, $t2
        addu $t2, $t1, $t2
        move $t1, $t4
        addi $t3, $t3, -1
        bne  $t3, $zero, fib_loop

        move $v0, $t2
        jr   $ra

isodd:
        addi $sp, $sp, -4
        sw   $ra, 0($sp)

        li   $a1, 2
        jal  division

        lw   $ra, 0($sp)
        addi $sp, $sp, 4

        bne  $v0, $zero, is_odd
        li   $v0, 0
        jr   $ra
is_odd:
        li   $v0, 1
        jr   $ra

division:
        li   $v1, 0
loop:
        blt  $a0, $a1, divis_res
        sub  $a0, $a0, $a1
        addi $v1, $v1, 1
        j    loop
divis_res:
        move $v0, $a0
        jr   $ra