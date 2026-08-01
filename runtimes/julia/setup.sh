#!/bin/sh
set -e
echo "=== julia-runtime Sandbox Setup ==="
mkdir -p /opt/julia
cd /opt/julia

echo "Downloading Julia 1.11.2..."
if command -v wget >/dev/null 2>&1; then
    wget -O julia.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/1.11/julia-1.11.2-linux-x86_64.tar.gz
else
    curl -L -o julia.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/1.11/julia-1.11.2-linux-x86_64.tar.gz
fi

echo "Extracting package..."
tar -xzf julia.tar.gz --strip-components=1
rm -f julia.tar.gz

echo "Patching Julia libopenlibm.so ELF stack flag..."
python3 -c '
import struct
filename = "/opt/julia/lib/julia/libopenlibm.so"
try:
    with open(filename, "r+b") as f:
        f.seek(32)
        e_phoff = struct.unpack("<Q", f.read(8))[0]
        f.seek(54)
        e_phentsize = struct.unpack("<H", f.read(2))[0]
        f.seek(56)
        e_phnum = struct.unpack("<H", f.read(2))[0]
        for i in range(e_phnum):
            offset = e_phoff + i * e_phentsize
            f.seek(offset)
            p_type = struct.unpack("<I", f.read(4))[0]
            if p_type == 0x6474e551:
                f.seek(offset + 4)
                f.write(struct.pack("<I", 6))
                print("Successfully patched libopenlibm.so GNU_STACK flag!")
                break
except Exception as e:
    print("Warning: Failed to patch ELF stack flags:", e)
'

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/julia
else
    chmod -R 777 /opt/julia
fi

echo "=== julia-runtime Sandbox Forged ==="
