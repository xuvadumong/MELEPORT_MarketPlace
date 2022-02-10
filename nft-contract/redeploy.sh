cargo check
cargo build
./build.sh
near delete nft-tutorial.test_nft.testnet test_nft.testnet
near create-account nft-tutorial.test_nft.testnet --masterAccount test_nft.testnet --initialBalance 5
near deploy --wasmFile ../out/nft-contract.wasm --accountId nft-tutorial.test_nft.testnet --initFunction new_default_metadata --initArgs '{"owner_id": "test_nft.testnet"}'
near view nft-tutorial.test_nft.testnet nft_total_supply
near call nft-tutorial.test_nft.testnet nft_mint '{"token_id": "VBI_NFT#01", "receiver_id": "test_nft.testnet", "metadata": {"title": "NEAR LOGO", "description": "NEAR LOGGO", "media": "https://s2.coinmarketcap.com/static/img/coins/64x64/6535.png"}}' --deposit 0.1 --accountId test_nft.testnet
near view nft-tutorial.test_nft.testnet nft_token '{"token_id": "VBI_NFT#01"}'
near call nft-tutorial.test_nft.testnet nft_transfer '{"receiver_id": "haitq6_owner.testnet", "token_id": "VBI_NFT#01", "approval_id": 0}' --accountId test_nft.testnet --depositYocto 1
near call nft-tutorial.test_nft.testnet nft_approve '{"token_id": "VBI_NFT#01", "account_id": "test_nft.testnet"}' --deposit 0.1 --accountId haitq6_owner.testnet
near call nft-tutorial.test_nft.testnet nft_transfer '{"receiver_id": "test_nft.testnet", "token_id": "VBI_NFT#01", "approval_id": 0}' --depositYocto 1 --accountId test_nft.testnet

cd ../
cd market-contract/
cargo check
cargo build
./build.sh
./redeploy.sh
