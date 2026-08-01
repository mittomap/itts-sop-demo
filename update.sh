#!/usr/bin/env bash
# Chep ban moi nhat tu nguon vao repo demo, commit va push.
# Tu 28/07: moi cong mot THU MUC rieng va moi trang mot dia chi rieng
#   .../cong-nhan-vien/?trang-bat-dau      .../cong-hoc-vien/?hoc-phi
# Tu 01/08 (V9.70): them cong thu tu .../cong-nhan-vien-v6/ - BAN V6, cung mot nguon gen_v5.py
# nhung bat co ITTS_V6=1 (menu 5 nhom, vao thang Ban lam viec). Trang chu cho chon demo 1 / demo 2.
# File du lieu chi giu MOT ban o goc; ba file index.html tro ve ../ITTs_data.js
# (chep ba ban 2.9MB moi lan day thi repo phinh ra vo ich).
# Ba file .html cu o goc van con nhung chi la trang chuyen tiep - dung xoa, link cu con song.
set -euo pipefail
cd "$(dirname "$0")"
SRC="${ITTS_SRC:-$HOME/Claude/SOP ITTs}"
mkdir -p cong-nhan-vien cong-nhan-vien-v6 cong-hoc-vien
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$SRC/ITTs_WebApp_v5_demo.html" > cong-nhan-vien/index.html
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$SRC/ITTs_WebApp_v6_demo.html" > cong-nhan-vien-v6/index.html
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$SRC/ITTs_TrangHocVien_demo.html" > cong-hoc-vien/index.html
cp -f "$SRC/ITTs_data.js" ./ITTs_data.js
cp -f "$SRC/_src/trangchu_demo.html" ./index.html
# Hai file o goc chi de link cu (truoc 28/07) khong chet. Ban V6 KHONG chep ra goc:
# no moi tinh, khong co link cu nao tro toi, ma moi lan chep la them 5MB vinh vien vao .git.
cp -f "$SRC/ITTs_WebApp_v5_demo.html" "$SRC/ITTs_TrangHocVien_demo.html" ./
# Chot cua: cua nao trang chu tro toi cung phai co file that. Cua v6 tung 404 mot lan vi
# trang chu them cua truoc, con update.sh thi khong biet co thu muc moi.
for c in $(grep -o 'href="[a-zA-Z0-9._/?-]*"' index.html | sed 's/href="//;s/"$//' \
           | grep -E '^(cong-|ITTs_)' | sed 's/?.*//'); do
  [ -e "$c" ] || [ -e "${c%/}/index.html" ] || { echo "LOI: trang chu tro toi $c ma khong co file"; exit 1; }
done
git add -A
git commit -m "cap nhat demo $(date '+%Y-%m-%d %H:%M:%S')" || echo "Khong co thay doi de commit."
git push
