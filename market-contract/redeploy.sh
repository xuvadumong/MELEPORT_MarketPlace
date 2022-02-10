cargo check
cargo build
./build.sh
near delete nft-market.test_nft.testnet test_nft.testnet
near create-account nft-market.test_nft.testnet --masterAccount test_nft.testnet --initialBalance 5
near deploy --wasmFile ../out/market-contract.wasm --accountId nft-market.test_nft.testnet --initFunction new --initArgs '{"owner_id": "test_nft.testnet"}'
near view nft-market.test_nft.testnet get_supply_sales
near view nft-tutorial.test_nft.testnet nft_supply_for_owner '{"account_id": "test_nft.testnet"}'
near view nft-tutorial.test_nft.testnet nft_token '{"token_id": "VBI_NFT#01"}'
near call nft-market.test_nft.testnet storage_deposit '{"account_id": "test_nft.testnet"}' --accountId test_nft.testnet --deposit 0.1
near call nft-tutorial.test_nft.testnet nft_approve '{"token_id": "VBI_NFT#01", "account_id": "nft-market.test_nft.testnet", "msg": "{\"sale_conditions\":{\"is_native\":false,\"contract_id\":\"meleport-ft.testnet\",\"decimals\":\"18\",\"amount\":\"1000000000000000000\"}}"}' --accountId test_nft.testnet --deposit 0.1
near view nft-market.test_nft.testnet get_sales '{"from_index": "0", "limit": 10}'
# Mint new token
near call nft-market.test_nft.testnet storage_deposit '{"account_id": "haitq6_owner.testnet"}' --accountId haitq6_owner.testnet --deposit 0.1
near call nft-tutorial.test_nft.testnet nft_mint '{"token_id": "BNB", "receiver_id": "haitq6_owner.testnet", "metadata": {"title": "BNB", "description": "BNB", "media": "https://s2.coinmarketcap.com/static/img/coins/64x64/1839.png"}}' --deposit 0.1 --accountId haitq6_owner.testnet
near call nft-tutorial.test_nft.testnet nft_approve '{"token_id": "BNB", "account_id": "nft-market.test_nft.testnet", "msg": "{\"sale_conditions\":{\"is_native\":false,\"contract_id\":\"meleport-ft.testnet\",\"decimals\":\"18\",\"amount\":\"1000000000000000000\"}}"}' --accountId haitq6_owner.testnet --deposit 0.1
near call nft-market.test_nft.testnet markdown_swap_token '{"nft_contract_id": "nft-tutorial.test_nft.testnet", "token_id": "BNB", "is_swap": true}' --account_id test_nft.testnet
near view nft-market.test_nft.testnet get_sales '{"from_index": "0", "limit": 10}'
cd ../
cd nft-contract/
