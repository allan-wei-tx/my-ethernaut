```js
await contract.approve(<to>, 1000000000000000000000000);
```

```bash
cast send <contract> "transferFrom(address,address,uint256)" <from> <to> 1000000000000000000000000 --rpc-url=$GOERLI_RPC_URL --private-key <privateKey>
```
