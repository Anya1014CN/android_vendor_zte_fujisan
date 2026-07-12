# ZTE Axon M (`fujisan`) vendor blobs

Initial bring-up vendor repository for LineageOS 18.1.

Current scope:
- stock `/system/vendor` blob set for first boot
- VINTF baseline comes from the live Oreo manifest and compatibility matrix
- selected stock `/system` companions are kept only where 18.1 does not build an equivalent artifact yet

Notes:
- `vendor/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini` is a symlink to
  `vendor/etc/wifi/WCNSS_qcom_cfg.ini` on stock Oreo, so only the target file
  is stored here.
- `vendor/bin/sh` and the old dual-screen helper injections are intentionally
  removed so the tree stays aligned with the stock vendor surface plus AOSP
  base utilities.
