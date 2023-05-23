// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Attack} from "src/Attack.sol";

contract AttackTest is Test {
    Attack public attack;
    address public target = vm.envAddress("TARGET");

    function setUp() public {
        vm.createSelectFork(vm.envString("GOERLI_RPC_URL"));
        attack = new Attack(target);
    }

    function test_exploit() public {
        attack.exploit(vm.envAddress("EXPLOITER"));
        (bool succ, bytes memory data) = target.call(abi.encodeWithSignature("owner()"));
        require(succ);
        address owner = abi.decode(data, (address));
        assertTrue(owner == vm.envAddress("EXPLOITER"));
    }
}
