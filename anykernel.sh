# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=KCUFKernel-V1
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=whyred
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

# System Changes
mount -o rw,remount -t auto /vendor 2>/dev/null;

remove_line /vendor/etc/init/hw/init.qcom.rc "    start qcom-post-boot";
remove_line /vendor/etc/init/hw/init.qcom.rc "start qcom-post-boot";
insert_line /vendor/etc/init/hw/init.qcom.rc "kcuffix" after "on early-boot" "    start qcom-post-boot";

mount -o ro,remount -t auto /vendor 2>/dev/null;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# Remove old kernel stuffs from ramdisk
rm -rf $ramdisk/init.noname.rc
rm -rf $ramdisk/init.special_power.sh
rm -rf $ramdisk/init.spectrum.rc
rm -rf $ramdisk/init.spectrum.sh
rm -rf $ramdisk/init.kangaroox.rc
rm -rf $ramdisk/init.kirks.rc

remove_line init.rc "import /init.noname.rc";
remove_line init.rc "import /init.spectrum.rc";
remove_line init.rc "import /init.kangaroox.rc";
remove_line init.rc "import /init.kirks.rc";

# import kcuf tweaks
insert_line init.rc "init.kcuf.rc" after "import /init.usb.configfs.rc" "import /init.kcuf.rc";

# end ramdisk changes

write_boot;
## end install

