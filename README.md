# ZTE Axon M (`fujisan`) vendor blobs

Initial bring-up vendor repository for LineageOS 15.1.

Current scope:
- minimal blobs for first boot
- display, keymaster, audio, bluetooth, WiFi and stock radio blob paths
- intentionally incomplete for camera and dual-screen features

Notes:
- `vendor/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini` is a symlink to
  `vendor/etc/wifi/WCNSS_qcom_cfg.ini` on stock Oreo, so only the target file
  is stored here.
- Stock init rc files reference several generic Qualcomm services that are not
  present on the live Oreo system image. The only missing rc-referenced
  executable that does exist on stock is `vendor/bin/sh`, so it is included for
  bring-up while the unused service stanzas stay untouched.
- `libkeymaster_staging.so` is copied into `vendor/lib64` even though stock
  stores it in `system/lib64`; the stock keymaster 3.0 HAL is loaded through
  the vendor namespace and otherwise cannot resolve that dependency.
