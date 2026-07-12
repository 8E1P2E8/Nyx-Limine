# Social & Communication Apps
# WhatsApp, Discord, and other permissive-licensed social platforms
# PERMISSIVE-ONLY: MIT, BSD, Apache-2.0, ISC, Unlicense

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # All-in-one messenger (tries but fails to replace individual apps below, we might need to build one)
    ferdium # Apache-2.0 - Aggregates WhatsApp, Discord, Slack, Telegram, etc.

    # NATIVE WEBRTC GATE (State 1 - Ephemeral)
    # As of Feb 2026, WhatsApp Web supports native voice/video calls on Linux
    # via browser WebRTC (Media over QUIC). No heavy Android emulation required.
    # Usage: Open web.whatsapp.com in Chromium/Firefox - camera/phone icons appear natively.
    # Resource footprint: ~150MB RSS (browser tab) vs 1.2GB+ (Waydroid/container)
    #
    # REMOVED (State 0 - Stateful/Emulation):
    # - zapzap: GPL-3.0 - No video call support (WebKit wrapper)
    # - wasistlos: GPL-3.0 - No video call support (QtWebEngine)
    # - whatsie: Tested - No video call support

    # Decentralized/Federated (permissive licenses only)
    lbry # MIT - Decentralized content platform
    particl-core # Apache-2.0 - Privacy-focused crypto
    cwtch-ui # MIT - P2P Tor messenger

    # Power-user social platforms (all permissive)
    mattermost-desktop # Apache-2.0 - Slack alternative
    #     zulip                  # Apache-2.0 - Threaded chat
    #     jitsi-meet-electron    # Apache-2.0 - Video conferencing
    cinny # MIT - Matrix client
    element-desktop # Apache-2.0 - Matrix client

  ];
}
