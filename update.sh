#!/usr/bin/env bash
# Chep lai 3 file moi nhat tu nguon vao repo demo, commit va push.
set -euo pipefail
cd "$(dirname "$0")"
SRC="$HOME/Claude/SOP ITTs"
cp -f "$SRC/ITTs_WebApp_v5_demo.html"  "./ITTs_WebApp_v5_demo.html"
cp -f "$SRC/ITTs_TrangHocVien_demo.html"   "./ITTs_TrangHocVien_demo.html"
cp -f "$SRC/ITTs_data.js" "./ITTs_data.js"
git add -A
git commit -m "cap nhat demo $(date '+%Y-%m-%d %H:%M:%S')" || echo "Khong co thay doi de commit."
git push
