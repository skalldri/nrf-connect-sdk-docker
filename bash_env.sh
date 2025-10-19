#! /bin/bash

# Set toolchain environemnt
if [ -z "${ZEPHYR_SDK_INSTALL_DIR}" ]; then
  source /opt/toolchain-env.sh
fi

if [ -z "${ZEPHYR_BASE}" ]; then
  source /root/ncs/v3.1.1/zephyr/zephyr-env.sh
fi