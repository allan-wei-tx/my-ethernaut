// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Shop} from "../src/Shop.sol";
import {Buyer} from "../src/Buyer.sol";

contract ShopTest is Test {
    Shop public shop;
    Buyer public buyer;

    function setUp() public {
        shop = new Shop();
        buyer = new Buyer();
    }

    function test_Exploit() public {
        buyer.exploit(shop);
        assertTrue(shop.isSold());
        assertEq(shop.price(), 0);
    }
}
