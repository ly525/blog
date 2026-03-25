#!/usr/bin/env bash
set -euo pipefail

# CentOS + nvm：安装多个 node 版本，并在每个版本下安装对应的依赖（全局工具包）
# 依赖切换淘宝镜像：npm registry

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
  # shellcheck disable=SC1090
  . "${NVM_DIR}/nvm.sh"
else
  echo "[错误] 未找到 nvm.sh：${NVM_DIR}/nvm.sh" >&2
  exit 1
fi

NPM_REGISTRY="https://registry.npmmirror.com"
export NVM_NODEJS_ORG_MIRROR="https://npmmirror.com/mirrors/node"

# 你原脚本里安装的全局依赖，保持不变
GLOBAL_PKGS=(
  "@sentry/cli@1.58.0"
  "yarn@1.22.19"
  "cross-env@7.0.3"
)

NODE_VERSIONS=(
  "8.16.1"
  "10.19.0"
  "12.22.1"
  "14.17.4"
  "16.14.2"
  "20.19.4"
  "22.18.0"
)

for NODE_VERSION in "${NODE_VERSIONS[@]}"; do
  echo "==============================="
  echo "[node] 开始处理版本：${NODE_VERSION}"

  # 先安装（如果已存在一般会跳过/快速完成）
  nvm install "${NODE_VERSION}"
  nvm use "${NODE_VERSION}"

  # 切换到淘宝镜像（确保后续 npm 安装走国内源）
  npm config set registry "${NPM_REGISTRY}"

  # 安装全局依赖（每个 node 版本各自安装一遍）
  npm install -g "${GLOBAL_PKGS[@]}"

  echo "[node] 完成版本：${NODE_VERSION}（node: $(node -v), npm: $(npm -v)）"
done

exit 0
