```bash
cast --to-rlp '["<contract>", "0x01"]' | xargs cast keccak # first way, take the last 20 bytes
cast compute-address <contract> --nonce 1 # second way
cast keccak "0xd694<contract>01" # third way, take the last 20 bytes
```

```bash
cast send <tokenAddress> "destroy(address)" <receiver> --rpc-url=$GOERLI_RPC_URL --private-key <privateKey>
```
