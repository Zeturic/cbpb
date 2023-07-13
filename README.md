## Class Based Poké Balls

Sun and Moon introduced a new feature where certain trainer classes will use different types of Poke Balls. For example, Ace Trainers use Ultra Balls, and Fishermen use Dive Balls. Before Sun and Moon, NPC trainers could only use standard Poké Balls.

This ports that feature to Fire Red.

### How do I insert this?

Open `config.s` in your preferred text editor.

Decide where you want the code to be inserted. The chosen address should be word-aligned (ending in `0`, `4`, `8`, or `C`). Update the definition of `free_space` with your choice.

Next, open `table.asm` in your preferred text editor, and modify the Poké Ball assignments as desired. The file has comments to help identify which line corresponds to which trainer class. The current assignments are just something I threw together. Some are based on Sun and Moon (e.g. Cooltrainers using Ultra Balls), while others just made sense to me (e.g. Twins using Repeat Balls). But, naturally, you're not obligated to use it at all. Assign whatever Poké Ball type you want to each class. It's only provided as a reasonable (in my opinion) default.

Place your ROM into this folder and rename it `rom.gba`.

Open a terminal and run `armips cbpb.asm -sym test.sym`. Your output will be in `test.gba`; `rom.gba` will not be modified.

Then, I suggest running `cat test.sym | grep cbpb_table`. This will tell you exactly where the table got inserted, this will be useful if you want to modify the Poké Ball class assignments later on.

### How do I modify Poké Ball assignments later on?

You'll need to know where `cbpb_table` was inserted when you built this.

`cbpb_table`  can be easily modified in a hex editor. Every trainer class has a corresponding entry in the table, and each entry is simply the Poké Ball value. For example, if you want to update it so that Campers (trainer class `0x3D`) use Safari Balls (item id `0x5`), you would simply set the byte at `cbpb_table + 0x3D` to `05`.
