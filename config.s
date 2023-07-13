// filenames of the input and output roms
// test_gba will be created as a modified copy of rom_gba
rom_gba equ "rom.gba"
test_gba equ "test.gba"

// where you want the code to be inserted
// make sure it is word aligned (ends in 0, 4, 8, or C)
.definelabel free_space, 0x08F00000
