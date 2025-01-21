list:
    just --list
benches:
    ./target/release/parachain-template-node benchmark pallet \
    --runtime=./target/release/wbuild/parachain-template-runtime/parachain_template_runtime.wasm \
    --genesis-builder=runtime \
    --pallet pallet_nftaa \
    --steps 50 \
    --repeat 20 \
    --extrinsic "*" \
    --output templates/parachain/pallets/pallet-nftaa/src/weights.rs \
    --template substrate/.maintain/frame-weight-template.hbs
[working-directory: 'polkadot']
relay:
    cargo build --release
para:
    cargo b -r -p parachain-template-node
para-bench:
    cargo b -r -p parachain-template-node --features runtime-benchmarks
[working-directory: 'binaries']
zombie:
    ./zombienet -p native -c 1 spawn config.toml
full: relay para zombie
pallet-check:
    SKIP_WASM_BUILD=1 cargo check -p pallet-nftaa  
pallet-check-bench:
    SKIP_WASM_BUILD=1 cargo check -p pallet-nftaa --features runtime-benchmarks
pallet-test:
    SKIP_WASM_BUILD=1 cargo test -p pallet-nftaa  