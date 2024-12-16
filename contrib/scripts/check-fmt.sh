#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUST_DIR="${SCRIPT_DIR}/../../rust"

cd "${RUST_DIR}"

version="nightly-2024-11-18"
flags=""

# Check if "check" is passed as an argument
if [[ "$#" -gt 0 && "$1" == "check" ]]; then
    flags="--check"
fi

# Install toolchain
cargo +$version --version || (rustup install $version && rustup component add rustfmt --toolchain $version)

# Check workspace crates
cargo +$version fmt --all -- --config format_code_in_doc_comments=true $flags