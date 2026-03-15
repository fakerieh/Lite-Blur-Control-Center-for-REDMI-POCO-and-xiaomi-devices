# LiteBlurHyperOS2 - Magisk Customize Script
# By Fakeri

# Only run in post-fs-data (Magisk environment ready)
ui_print " "

# Module Info
MODNAME=$(grep_prop name $MODPATH/module.prop)
MODVER=$(grep_prop version $MODPATH/module.prop)
DV=$(grep_prop author $MODPATH/module.prop)

# Device Info
Device=$(getprop ro.product.device)
Model=$(getprop ro.product.model)
Brand=$(getprop ro.product.brand)
Architecture=$(getprop ro.product.cpu.abi)
SDK=$(getprop ro.system.build.version.sdk)
Android=$(getprop ro.system.build.version.release)
Type=$(getprop ro.system.build.type)
Built=$(getprop ro.system.build.date)
Time=$(date "+%d, %b - %H:%M %Z")

set_modname() {
    tmp_name="LiteBlur-HyperOS2"  
    if grep -q "^name=" "$MODPATH/module.prop"; then
        sed -i "s|^name=.*|name=$tmp_name|" "$MODPATH/module.prop"
    else
        echo "name=$tmp_name" >> "$MODPATH/module.prop"
    fi
}

set_description() {
  tmp_desc="Release blur on HyperOS 2 but LIGHTER! (some features are disabled so that's why it's lighter) ported from garnet by @fakeripage and @Kyrenzo"
  if grep -q "^description=" "$MODPATH/module.prop"; then
    sed -i "s|^description=.*|description=$tmp_desc|" "$MODPATH/module.prop"
  else
    echo "description=$tmp_desc" >> "$MODPATH/module.prop"
  fi
}

set_author() {
    tmp_author="Fakh"  
    if grep -q "^author=" "$MODPATH/module.prop"; then
        sed -i "s|^author=.*|author=$tmp_author|" "$MODPATH/module.prop"
    else
        echo "author=$tmp_author" >> "$MODPATH/module.prop"
    fi
}

# Output Info
ui_print "-------------------------------------"
ui_print " Fetching module & device info..."
ui_print "-------------------------------------"
sleep 1.5
ui_print "- Author       : $DV"
sleep 0.3
ui_print "- Module       : $MODNAME"
sleep 0.3
ui_print "- Version      : $MODVER"
sleep 0.3
ui_print "- Device       : $Model [$Device]"
sleep 0.3
ui_print "- Brand        : $Brand"
sleep 0.3
ui_print "- Android      : $Android (SDK $SDK)"
sleep 0.3
ui_print "- CPU Arch     : $Architecture"
sleep 0.3
ui_print "- Build Type   : $Type"
sleep 0.3
ui_print "- Build Time   : $Built"
sleep 0.3
ui_print "- Installed at : $Time"
sleep 0.3

# Root info
ui_print "- Root Provider:"
if [ "$KSU" ]; then
  ui_print "  KernelSU"
  set_description
  ui_print "- KernelSU Ver : $KSU_KERNEL_VER_CODE (kernel), $KSU_VER_CODE (ksud)"
  if [ "$(which magisk)" ]; then
    ui_print "-------------------------------------"
    ui_print "! Multiple root systems detected!"
    abort "! Please use only one (Magisk OR KernelSU)."
  fi
elif [ "$MAGISK_VER_CODE" ]; then
  ui_print "  Magisk"
  set_description
else
  ui_print "  Unknown or unsupported root system"
fi

ui_print "-------------------------------------"

ui_print "- Finishing setup..."
sleep 1.5