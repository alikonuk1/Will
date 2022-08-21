source .env

forge create --rpc-url $GOERLI_RPC_URL \
    --private-key $PRIVATE_KEY src/Will.sol:Will \
    --etherscan-api-key $ETHERSCAN_KEY \
    --verify