```js
await contract.contribute({value: 1});
await web3.eth.sendTransaction({from: <account>, to: contract.address, value: 1});
await contract.withdraw();
```
