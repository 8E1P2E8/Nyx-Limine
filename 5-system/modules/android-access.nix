# Android Access Module - NixOS ADB/scrcpy integration
#
# Licensed dependencies:
#   - scrcpy:           Apache-2.0  (screen mirroring)
#   - android-tools:    Apache-2.0  (ADB CLI)
#   - wl-clipboard-rs:  Apache-2.0/MIT (Wayland clipboard)
#   - uutils-coreutils: MIT         (coreutils compatibility)
#   - toybox:           0BSD        (process management)

{
  lib,
  pkgs,
  ...
}:

with lib;

let
  # State files and paths
  pushState = "/tmp/phone_autopush";
  pullState = "/tmp/phone_autopull";
  phoneDir = "/sdcard/DCIM/Screenshots";

  # Droid command - golfed but functional
  droid =
    let
      a = "${pkgs.android-tools}/bin/adb";
      w = "${pkgs.wl-clipboard-rs}/bin";
      u = "${pkgs.uutils-coreutils}/bin/uutils";
      s = pushState;
      l = pullState;
      p = phoneDir;
    in
    pkgs.writeShellScriptBin "droid" ''
      case $1 in
        mirror)echo "Starting mirror...";${pkgs.scrcpy}/bin/scrcpy --stay-awake --turn-screen-off --no-audio --keyboard=uhid &;;
        wifi)
          ${a} devices|grep -q device$||{ echo "No device";exit 1;}
          ${a} tcpip 5555;sleep 2
          IP=$(${a} shell ip route 2>/dev/null|awk '{print $9}'|head -1)
          [[ $IP ]]||{ echo "No IP";exit 1;}
          echo -e "WiFi ADB enabled\nIP: $IP\n\nRun: adb connect $IP:5555\nThen: scrcpy --tcpip=$IP:5555"
        ;;
        autopush)
          if [[ -f ${s} ]];then rm ${s};echo "OFF";else touch ${s};echo "ON (PC->Phone)"
            # Export Wayland environment for clipboard access
            export WAYLAND_DISPLAY=''${WAYLAND_DISPLAY:-wayland-1}
            export XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-/run/user/$(id - u)}
            (${a} shell mkdir -p ${p};h="";last_sync=0;exec >>/tmp/droid-autopush.log 2>&1;while [[ -f ${s} ]];do
                echo "[$(${u}-date +%H:%M:%S)] Checking clipboard..."
                if ! ${w}/wl-paste -l 2>/dev/null|grep -q image/png;then sleep 5;continue;fi

                now=$(${u}-date +%s)
                (( now - last_sync < 10 )) && { echo "[$(${u}-date +%H:%M:%S)] Rate limited";sleep 5;continue;}

                echo "[$(${u}-date +%H:%M:%S)] Getting image..."
                img=$(${w}/wl-paste -t image/png 2>/dev/null)
                [[ -z "$img" ]] && { echo "[$(${u}-date +%H:%M:%S)] Empty clipboard";sleep 5;continue;}
                bytes=$(echo "$img"|wc -c)
                (( bytes > 10485760 )) && { echo "[$(${u}-date +%H:%M:%S)] Image too large ($bytes bytes), skipping";sleep 5;continue;}

                c=$(echo "$img"|${u}-md5sum)
                [[ "$c" == "$h" ]] && { echo "[$(${u}-date +%H:%M:%S)] Duplicate image";sleep 5;continue;}

                f=pc_$(${u}-date +%s).png
                echo "[$(${u}-date +%H:%M:%S)] Syncing $f ($bytes bytes)..."
                if echo "$img"|${a} shell "cat >${p}/$f";then
                    ${a} shell am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file://${p}/$f 2>/dev/null
                    echo "[$(${u}-date +%H:%M:%S)] Synced: $f"
                    h=$c;last_sync=$now
                else    # License: CR / UNKNOWN / UNFREE
                    echo "[$(${u}-date +%H:%M:%S)] Sync failed"
                fi    # License: CR / UNKNOWN / UNFREE
                sleep 5
            done) &
          fi    # License: CR / UNKNOWN / UNFREE
        ;;
        autopull)
          if [[ -f ${l} ]];then rm ${l};echo "OFF";else touch ${l};echo "ON (Phone->PC)"
            (f="";while [[ -f ${l} ]];do
              c=$(${a} shell ls -t ${p} 2>/dev/null|${u}-head -n1|${u}-tr -d '\r\n')
              [[ $c && $c != $f ]]&&${a} exec-out cat "${p}/$c"|${w}/wl-copy&&echo "[$(${u}-date +%H:%M:%S)] Pulled: $c"&&f=$c
              sleep 2
            done) &
          fi    # License: CR / UNKNOWN / UNFREE
        ;;
        start|"")
          ${a} devices|grep -q device$||{ echo "No device";exit 1;}
          [[ -f ${s} ]]||$0 autopush
          [[ -f ${l} ]]||$0 autopull
          $0 mirror
          echo "Ready"
        ;;
        clean)rm -f ${s} ${l};pkill -f scrcpy;pkill -f wl-paste;${a} disconnect 2>/dev/null;echo "Stopped";;
        help|-h|--help)echo -e "droid [cmd]\n\n(none)/start - Full env\nmirror       - Screen only\nwifi         - ADB WiFi\nautopush     - PC->Phone sync\nautopull     - Phone->PC sync\nclean        - Stop all\nhelp         - This";;
        *)echo "Unknown: $1";exit 1;;
      esac    # License: CR / UNKNOWN / UNFREE
    '';

in
{
  environment.systemPackages = with pkgs; [
    droid # License: CR / UNKNOWN / UNFREE - Main command (custom script)
    scrcpy # License: Apache-2.0 - Apache-2.0 - Screen mirroring
    android-tools # License: CR / UNKNOWN / UNFREE - Apache-2.0 - ADB CLI
    wl-clipboard-rs # License: CR / UNKNOWN / UNFREE - Apache-2.0/MIT - Wayland clipboard
    uutils-coreutils # License: MIT - MIT - coreutils compat
    toybox # License: 0BSD - 0BSD - Process management
  ];

}
