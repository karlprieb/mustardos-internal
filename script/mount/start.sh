#!/bin/sh

# Mount partitions needed for bind mounts in parallel.
#
# These scripts return as soon as the necessary mounts are available, but they
# can also leave extra background jobs running that respond to future media
# add/remove events.
/opt/muos/script/mount/mmc.sh &
/opt/muos/script/mount/sdcard.sh &
wait

# Initialize bind mounts under /run/muos/storage.
/opt/muos/script/var/init/storage.sh

# Mount boot partition and start watching for USB storage. These aren't needed
# by the rest of the boot process, so handle them after bind mounts are set up.
/opt/muos/script/mount/boot.sh &
/opt/muos/script/mount/usb.sh &
