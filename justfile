list:
    just --list
benches:
    ./target/release/parachain-template-node benchmark pallet \
    --pallet pallet_nftaa \
    --steps 50 \
    --repeat 20 \
    --extrinsic "*" \
    --output templates/parachain/pallets/pallet-nftaa/src/weights.rs
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
full: zombie relay para
pallet-check:
    SKIP_WASM_BUILD=1 cargo check -p pallet-nftaa  