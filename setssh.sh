#!/usr/bin/env bash
set -e

EMAIL="$1"
KEY="$HOME/.ssh/id_ed25519"

if [ -z "$EMAIL" ]; then
  echo "Usage: ./setssh.sh you@example.com"
  exit 1
fi

ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY" -N ""

eval "$(ssh-agent -s)"
ssh-add "$KEY"

cat "$KEY.pub"
echo
echo "Add this key to: https://github.com/settings/keys"

