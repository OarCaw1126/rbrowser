#!/bin/sh
# Local LAN launcher. Runs Surf fully inside Docker and advertises it on Bonjour
# so the iPad can find it with "Find Local Surf".
set -eu

IMAGE="${IMAGE:-rbrowser:lan}"
NAME="${NAME:-rbrowser-lan}"
PORT="${PORT:-18080}"

if [ -f ./.env ]; then
  set -a
  . ./.env
  set +a
fi

SURF_PASSWORD="${SURF_PASSWORD:-linuxwifi}"

docker build -t "$IMAGE" .
AUTH_HASH="$(docker run --rm --entrypoint /app/rbrowser "$IMAGE" -hash-password "$SURF_PASSWORD")"
docker rm -f "$NAME" >/dev/null 2>&1 || true
docker run -d --name "$NAME" \
  --network host \
  --shm-size 1g \
  -v rbrowser_lan_profile:/data/profile \
  -v rbrowser_lan_downloads:/data/downloads \
  -e PORT="$PORT" \
  -e PROFILE=/data/profile \
  -e START_URL="${START_URL:-https://www.google.com}" \
  -e VW="${VW:-1024}" \
  -e VH="${VH:-768}" \
  -e XFB_W="${XFB_W:-1024}" \
  -e XFB_H="${XFB_H:-1024}" \
  -e QUALITY="${QUALITY:-55}" \
  -e NATIVE_QUALITY="${NATIVE_QUALITY:-100}" \
  -e NATIVE_MOTION_QUALITY="${NATIVE_MOTION_QUALITY:-92}" \
  -e STREAM_FPS="${STREAM_FPS:-30}" \
  -e STREAM_SCALE="${STREAM_SCALE:-800x800}" \
  -e STREAM_BITRATE="${STREAM_BITRATE:-2800}" \
  -e STREAM_MAXRATE="${STREAM_MAXRATE:-3600}" \
  -e STREAM_BUFSIZE="${STREAM_BUFSIZE:-900}" \
  -e STREAM_PRESET="${STREAM_PRESET:-ultrafast}" \
  -e SURF_ADVERTISE=1 \
  -e AUTH_HASH="$AUTH_HASH" \
  "$IMAGE"

echo "Surf LAN is running at http://localhost:$PORT"
echo "Password: $SURF_PASSWORD"
echo "iPad: Settings -> Find Local Surf -> Connect"
