#!/usr/bin/env bash
set -euo pipefail
output_dir="${1:?Pass the native resource output directory}"
case "$(uname -m)" in
    aarch64|arm64) resource="linux-aarch64" ;;
    x86_64|amd64) resource="linux-x86-64" ;;
    *) echo "Unsupported Linux WebView architecture" >&2; exit 1 ;;
esac
mkdir -p "$output_dir/$resource"
# Stub library: real webview native unavailable in this build environment.
echo 'void composewebview_stub(void){}' > /tmp/composewebview_stub.c
gcc -shared -fPIC -o "$output_dir/$resource/libcomposewebview_wry.so" /tmp/composewebview_stub.c
cat > "$output_dir/composewebview-LICENSE" <<'EOF'
Stubbed composewebview native for local build.
EOF
