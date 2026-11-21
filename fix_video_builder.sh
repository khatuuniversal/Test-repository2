#!/data/data/com.termux/files/usr/bin/bash
set -e
KEEP="Khatu_Universal_Master_Dashboard.html"
PATCH="/sdcard/Download/video_fix_snippet.html"
[ -f "/sdcard/Download/$KEEP" ] && cp "/sdcard/Download/$KEEP" .
[ -f "$KEEP" ] || { echo "Missing $KEEP"; exit 1; }
if [ -f "$PATCH" ] && ! grep -q "added-video-wrapper" "$KEEP"; then
  if grep -qi "</body>" "$KEEP"; then
    sed -i "s|</body>|$(sed 's/[&/\]/\\&/g' "$PATCH")\n</body>|I" "$KEEP"
  else
    cat "$PATCH" >> "$KEEP"
  fi
fi
find . -type f -name "*.html" ! -name "$KEEP" -delete
cp "$KEEP" index.html
git add -A
git commit -m "Fix Web Builder video insertion in $KEEP" || true
git push
