# ZTE Axon M (`fujisan`) vendor blobs

Initial bring-up vendor repository for LineageOS 15.1.

Current scope:
- minimal blobs for first boot
- display, keymaster, audio, bluetooth and WiFi paths
- intentionally incomplete for camera, radio and dual-screen features

Notes:
- `vendor/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini` is a symlink to
  `vendor/etc/wifi/WCNSS_qcom_cfg.ini` on stock Oreo, so only the target file
  is stored here.
