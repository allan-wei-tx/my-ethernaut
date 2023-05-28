// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MaliciousERC20 is ERC20("MaliciousERC20", "MERC20") {
    constructor() {
        _mint(msg.sender, 600);
    }
}
