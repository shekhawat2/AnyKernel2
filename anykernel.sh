# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=KCUFKernel-V1
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=whyred
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# Remove old kernel stuffs from ramdisk
rm -rf $ramdisk/init.noname.rc
rm -rf $ramdisk/init.special_power.sh
rm -rf $ramdisk/init.spectrum.rc
rm -rf $ramdisk/init.spectrum.sh

remove_line init.rc "import /init.noname.rc";
remove_line init.rc "import /init.spectrum.rc";

# end ramdisk changes

write_boot;

## end install

