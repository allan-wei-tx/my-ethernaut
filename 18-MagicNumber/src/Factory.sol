// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Factory {
    function createContract() public returns (address addr) {
        bytes memory initCode = hex"6008600a5f3960085ff3602a5f5260205ff3";
        assembly {
            addr := create(0, add(initCode, 0x20), mload(initCode))
        }
    }
}
