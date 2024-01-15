# 0 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
# 78 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  .section .init, "ax"
  .code 32
  .balign 4
# 89 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  .syntax unified

  .weak _start
  .global __start
  .extern main
  .weak exit
# 104 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
_start:
__start:
  mrs r0, cpsr
  bic r0, r0, #0x1F


  orr r1, r0, #0x1B
  msr cpsr_cxsf, r1
  ldr sp, =__stack_und_end__

  bic sp, sp, #0x7


  orr r1, r0, #0x17
  msr cpsr_cxsf, r1
  ldr sp, =__stack_abt_end__

  bic sp, sp, #0x7


  orr r1, r0, #0x12
  msr cpsr_cxsf, r1
  ldr sp, =__stack_irq_end__

  bic sp, sp, #0x7


  orr r1, r0, #0x11
  msr cpsr_cxsf, r1
  ldr sp, =__stack_fiq_end__

  bic sp, sp, #0x7


  orr r1, r0, #0x13
  msr cpsr_cxsf, r1
  ldr sp, =__stack_svc_end__

  bic sp, sp, #0x7
# 156 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  orr r1, r0, #0x1F
  msr cpsr_cxsf, r1
  ldr sp, =__stack_end__

  bic sp, sp, #0x7
# 187 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  ldr r0, =__data_load_start__
  ldr r1, =__data_start__
  ldr r2, =__data_end__
  bl memory_copy
  ldr r0, =__text_load_start__
  ldr r1, =__text_start__
  ldr r2, =__text_end__
  bl memory_copy
  ldr r0, =__fast_load_start__
  ldr r1, =__fast_start__
  ldr r2, =__fast_end__
  bl memory_copy
  ldr r0, =__ctors_load_start__
  ldr r1, =__ctors_start__
  ldr r2, =__ctors_end__
  bl memory_copy
  ldr r0, =__dtors_load_start__
  ldr r1, =__dtors_start__
  ldr r2, =__dtors_end__
  bl memory_copy
  ldr r0, =__rodata_load_start__
  ldr r1, =__rodata_start__
  ldr r2, =__rodata_end__
  bl memory_copy
  ldr r0, =__tdata_load_start__
  ldr r1, =__tdata_start__
  ldr r2, =__tdata_end__
  bl memory_copy
# 231 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  ldr r0, =__bss_start__
  ldr r1, =__bss_end__
  mov r2, #0
  bl memory_set
  ldr r0, =__tbss_start__
  ldr r1, =__tbss_end__
  mov r2, #0
  bl memory_set
# 248 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  ldr r0, = __heap_start__
  ldr r1, = __heap_end__
  sub r1, r1, r0

  bl __SEGGER_RTL_init_heap
# 271 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  .type start, function
start:


  ldr r0, =__ctors_start__
  ldr r1, =__ctors_end__
ctor_loop:
  cmp r0, r1
  beq ctor_end
  ldr r2, [r0], #+4
  stmfd sp!, {r0-r1}
  mov lr, pc



  bx r2

  ldmfd sp!, {r0-r1}
  b ctor_loop
ctor_end:

  .type __startup_complete, function
__startup_complete:
# 308 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  mov r0, #0
  mov r1, #0

  ldr r2, =main
  mov lr, pc



  bx r2


  .type exit, function
exit:
# 364 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
exit_loop:
  b exit_loop

memory_copy:
  cmp r0, r1
  moveq pc, lr
  subs r2, r2, r1
  moveq pc, lr


  orr r3, r0, r1
  orr r3, r3, r2
  tst r3, #0x3
  bne 2f

1:
  ldr r3, [r0], #+4
  str r3, [r1], #+4
  subs r2, r2, #4
  bne 1b
  mov pc, lr

2:
  ldrb r3, [r0], #+1
  strb r3, [r1], #+1
  subs r2, r2, #1
  bne 2b
  mov pc, lr

memory_set:
  cmp r0, r1
  moveq pc, lr
  strb r2, [r0], #1
  b memory_set



.macro HELPER helper_name
  .section .text.\helper_name, "ax", %progbits
  .balign 4
  .type \helper_name, function
  .weak \helper_name
\helper_name:
.endm

HELPER __aeabi_read_tp
  ldr r0, =__tbss_start__-8
  bx lr
HELPER abort
  b .
HELPER __assert
  b .
HELPER __assert_func
  b .
HELPER __aeabi_assert
  b .
HELPER __sync_synchronize
  bx lr
# 430 "C:\\Users\\torbe\\Downloads\\DigitalLabor-master\\System\\crt0.s"
  .section .stack, "wa", %nobits
  .section .stack_abt, "wa", %nobits
  .section .stack_irq, "wa", %nobits
  .section .stack_fiq, "wa", %nobits
  .section .stack_svc, "wa", %nobits
  .section .stack_und, "wa", %nobits
  .section .heap, "wa", %nobits
