```bash
> export GOERLI_RPC_URL=https://goerli.infura.io/v3/<apiKey>
> cast storage <contract> 5 --rpc-url=$GOERLI_RPC_URL
0x24764a7ae8aab22eaf6099b466d8ad0df874066196ed8cf0bec89e63291aa467
> cast send <contract> "unlock(bytes16)" 0x24764a7ae8aab22eaf6099b466d8ad0d --rpc-url=$GOERLI_RPC_URL --private-key <privateKey>
```
