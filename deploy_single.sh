#!/data/data/com.termux/files/usr/bin/bash
set -e
KEEP="Khatu_Universal_Master_Dashboard.html"
[ -f "/sdcard/Download/$KEEP" ] && cp "/sdcard/Download/$KEEP" .
[ -f "$KEEP" ] || { echo "Missing $KEEP"; exit 1; }
find . -type f -name "*.html" ! -name "$KEEP" -delete
cp "$KEEP" index.html
git add -A
git commit -m "Keep only $KEEP" || true
git push
