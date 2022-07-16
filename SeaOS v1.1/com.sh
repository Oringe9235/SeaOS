rm -rf bin;
mkdir bin;
chmod 777 ./bin;

nasm -f elf32 ./kernel.asm -o ./bin/kernel.o;
nasm -f elf32 ./liba.asm -o ./bin/liba.o;

gcc -c -m -march=i386 -masm=intel -nostdlib -ffreestanding -mpreferred-stack-boundary=2 -lgcc -shared libc.c -o ./bin/libc.o;

chmod 777 ./bin/OSkernel.o;
chmod 777 ./bin/liba.o;
chmod 777 ./bin/libc.o;

ld -m elf_i386 -T -N -Ttext  0x8000 --oformat binary  ./bin/kernel.o  ./bin/liba.o  ./bin/libc.o -o bin/osKernel.bin;

echo "Done!";
