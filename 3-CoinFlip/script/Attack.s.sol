// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import {Attack} from "src/Attack.sol";
import {CoinFlip} from "src/CoinFlip.sol";

contract AttackScript is Script, Test {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);
        vm.startBroadcast(deployer);

        Attack attack = new Attack(CoinFlip(vm.envAddress("COINFLIP")));

        uint256 count = 0;
        do {
            try attack.attack() {
                ++count;
            } catch {}
        } while (count < 10);

        vm.stopBroadcast();
    }
}
