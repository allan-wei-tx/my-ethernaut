// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Factory} from "src/Factory.sol";

contract FactoryTest is Test {
    Factory public factory;

    function setUp() public {
        factory = new Factory();
    }

    function test_createContract() public {
        address newContract = factory.createContract();
        (bool succ, bytes memory data) = newContract.call(abi.encodeWithSignature("whatIsTheMeaningOfLife()"));

        require(succ);
        assertTrue(abi.decode(data, (uint256)) == 42);
        assertTrue(newContract.code.length <= 10);
    }
}
