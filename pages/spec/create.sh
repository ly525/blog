#!/bin/bash

# 文件路径和标题数组
files=(
  "team-tech.md:技术选型"
  "dev-environment.md:开发环境"
  "framework.md:框架"
  "component-library.md:组件库"
  "engineering.md:工程化"
  "stability.md:稳定性"
  "monitoring.md:监控/埋点"
  "map.md:地图"
  "css.md:CSS"
  "dynamic-form.md:动态表单"
  "crud.md:CRUD"
  "platform.md:部署平台"
  "deployment.md:运维"
  "monitor.md:监控｜大盘"
  "track.md:埋点"
  "sentry.md:Sentry"
  "microweb.md:微前端"
  "request.md:请求库"
  "route.md:路由"
  "admin-system.md:权限"
  "rich-text.md:富文本"
  "pdf.md:PDF"
  "excel.md:Excel"
  "word.md:Word"
  "audio.md:音频"
  "video.md:视频"
  "image.md:图片"
)

# 遍历数组，判断文件是否存在，如果不存在则创建并添加标题
for file in "${files[@]}"; do
  filepath="/Users/lambert/Documents/Code/YMM/blog/pages/spec/${file%%:*}"
  title="${file##*:}"
  if [ ! -f "$filepath" ]; then
    mkdir -p "$(dirname "$filepath")"
    touch "$filepath"
    echo "# $title" > "$filepath"
  fi
done