#!/data/data/com.termux/files/usr/bin/bash
set -e
KEEP="Khatu_Universal_Master_Dashboard.html"
SNIPPET="/sdcard/Download/wb_video_fix.html"
[ -f "/sdcard/Download/$KEEP" ] && cp "/sdcard/Download/$KEEP" .
[ -f "$KEEP" ] || { echo "Missing $KEEP"; exit 1; }
if [ -f "$SNIPPET" ] && ! grep -q "wb-video-item" "$KEEP"; then
  if grep -qi "</body>" "$KEEP"; then
    sed -i "s|</body>|$(sed 's/[&/\]/\\&/g' "$SNIPPET")\n</body>|I" "$KEEP"
  else
    cat "$SNIPPET" >> "$KEEP"
  fi
fi
find . -type f -name "*.html" ! -name "$KEEP" -delete
cp "$KEEP" index.html
git add -A
git commit -m "Fix video insertion inside Web Builder" || true
git push
