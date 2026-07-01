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
- Stock init rc files reference several generic Qualcomm services that are not
  present on the live Oreo system image. The only missing rc-referenced
  executable that does exist on stock is `vendor/bin/sh`, so it is included for
  bring-up while the unused service stanzas stay untouched.
