subdir=./kernel
bootsector=bootloader.asm
usb=0
ifeq ($(usb),1)
bootsector=bootloaderusb.asm
endif




all:
#	nasm -o kernel.img kernel.asm

	nasm -o bootloader.img  $(bootsector)
	@cd $(subdir);make clean;make addr=0xc400
	dd if=bootloader.img of=os.img bs=512 count=1
	dd if=/dev/zero of=os.img bs=512 seek=1 skip=1 count=2879

copy:
	mkdir -p /tmp/floppy
	mount -o loop os.img /tmp/floppy -o fat=12
#	cp kernel.img /tmp/floppy
	cp $(subdir)/kernel /tmp/floppy	
	@sleep 1
	umount /tmp/floppy
	rm -rf /tmp/floppy
run:
	qemu-system-i386 -drive file=os.img,if=floppy -m 128
clean:
	-rm *.img
	cd ./kernel;make clean
u:
	umount /dev/loop0

dd:
	umount /dev/sdb
	dd if=os.img of=/dev/sdb
