#!/bin/bash

KEY_FILE=".pass"

# Verify that the key file exists
if [ ! -f "$KEY_FILE" ]; then
  # Send error message to stderr so it doesn't corrupt stdout piping
  echo "Error: Key file '$KEY_FILE' not found." >&2
  exit 1
fi

# Encrypt using GPG symmetric encryption (AES-256)
# By not specifying an input file, GPG automatically reads from stdin
# and outputs the encrypted data to stdout.
gpg --batch \
  --yes \
  --pinentry-mode loopback \
  --passphrase-file "$KEY_FILE" \
  --symmetric \
  --cipher-algo AES256

# Verify success
if [ $? -ne 0 ]; then
  echo "Error: GPG encryption failed." >&2
  exit 1
fi

# Note: The "Success" message was removed.
# In Unix philosophy, standard filter scripts should remain silent on success.
