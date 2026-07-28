#!/usr/bin/env bash
# Chep ban moi nhat tu nguon vao repo demo, commit va push.
# Tu 28/07: moi cong mot THU MUC rieng va moi trang mot dia chi rieng
#   .../cong-nhan-vien/?trang-bat-dau      .../cong-hoc-vien/?hoc-phi
# File du lieu chi giu MOT ban o goc; hai file index.html tro ve ../ITTs_data.js
# (chep hai ban 2.9MB moi lan day thi repo phinh ra vo ich).
# Hai file .html cu o goc van con nhung chi la trang chuyen tiep - dung xoa, link cu con song.
set -euo pipefail
cd "$(dirname "$0")"
SRC="$HOME/Claude/SOP ITTs"
mkdir -p cong-nhan-vien cong-hoc-vien
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$SRC/ITTs_WebApp_v5_demo.html" > cong-nhan-vien/index.html
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$SRC/ITTs_TrangHocVien_demo.html" > cong-hoc-vien/index.html
cp -f "$SRC/ITTs_data.js" ./ITTs_data.js
git add -A
git commit -m "cap nhat demo $(date '+%Y-%m-%d %H:%M:%S')" || echo "Khong co thay doi de commit."
git push
