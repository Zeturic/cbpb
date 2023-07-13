.include "config.s"
.include "balls.s"

.definelabel CreateNPCTrainerParty_hook_addr, 0x0801169C
.definelabel CreateNPCTrainerParty_hook_return, 0x080116AC

.definelabel SetMonData, 0x0804037C

.definelabel gEnemyParty, 0x0202402C
.definelabel gTrainersPtr, 0x080116C4

MON_DATA_POKEBALL equ  38
SIZEOF_POKEMON equ 100

OFFSETOF_TRAINERCLASS equ 1
OFFSETOF_PARTYSIZE equ 32

// -----------------------------------------------------------------------------

.gba
.thumb

.open rom_gba, test_gba, 0x08000000

.org free_space

.area 0xBB

cbpb_start:
    // adapted from 0x0801169C
    ldr     r0, =gTrainersPtr
    ldr     r0, [r0]
    ldr     r4, [sp, #32]
    ldr     r2, [sp, #20]
    add     r1, r4, r2
    lsl     r1, r1, #3
    add     r1, r1, r0
    mov     r0, r1
    add     r0, #OFFSETOF_PARTYSIZE
    ldrb    r4, [r0]                    // r4 has the partysize

    add     r1, #OFFSETOF_TRAINERCLASS
    ldrb    r0, [r1]
    ldr     r1, =cbpb_table
    add     r5, r1, r0                  // r5 has the pointer to the ball data

    ldr     r6, =gEnemyParty            // r6 has the current Pokémon
    mov     r0, #SIZEOF_POKEMON
    mul     r0, r4
    add     r7, r0, r6                  // r7 is one past the end

loop:
    mov     r0, r6
    mov     r1, #MON_DATA_POKEBALL
    mov     r2, r5
    ldr     r3, =SetMonData |1
    bl      call

    add     r6, #SIZEOF_POKEMON
    cmp     r6, r7
    bne     loop

return:
    mov     r0, r4
    ldr     r3, =CreateNPCTrainerParty_hook_return |1

call:
    bx      r3

.pool

.include "table.asm"

.endarea

.org CreateNPCTrainerParty_hook_addr
.area 16, 0xFE
    ldr     r3, =cbpb_start |1
    bx      r3
    .pool
.endarea

.close
