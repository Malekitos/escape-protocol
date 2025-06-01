#!/bin/sh
echo -ne '\033c\033]0;Escape Protocol\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/survive_protocol.x86_64" "$@"
