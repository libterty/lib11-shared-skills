#!/usr/bin/env bash
# Guards against macOS grabbing the Bluetooth headset as the audio INPUT
# device (forcing HFP, mono/16kHz) whenever it reconnects. Run this before
# starting a Fireflies Desktop System-Audio recording. Output stays on the
# Bluetooth headset untouched — only the input device is checked/fixed.
#
# Usage: shared-skills/fix-bluetooth-audio-input.sh

set -euo pipefail

readonly BUILTIN_MIC="MacBook Pro的麥克風"

require_switchaudiosource() {
  command -v SwitchAudioSource >/dev/null 2>&1 || {
    echo "SwitchAudioSource not found. Install it with: brew install switchaudio-osx" >&2
    exit 1
  }
}

current_input_device() {
  SwitchAudioSource -c -t input
}

main() {
  require_switchaudiosource

  local current
  current="$(current_input_device)"

  if [ "$current" = "$BUILTIN_MIC" ]; then
    echo "OK: input is already \"$BUILTIN_MIC\" — no change needed."
    exit 0
  fi

  echo "Input is currently \"$current\" (likely Bluetooth headset, forcing HFP)."
  SwitchAudioSource -t input -s "$BUILTIN_MIC"
  echo "Switched input to \"$BUILTIN_MIC\". Bluetooth output is untouched."
  echo "Now fully quit and reopen Fireflies Desktop App (Cmd+Q, not just close the window)."
}

main "$@"
