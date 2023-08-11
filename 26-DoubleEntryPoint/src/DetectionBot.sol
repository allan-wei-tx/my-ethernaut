// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDetectionBot} from "src/interfaces/IDetectionBot.sol";
import {IForta} from "src/interfaces/IForta.sol";

contract DetectionBot is IDetectionBot {
    address public immutable owner;

    constructor(address owner_) {
        owner = owner_;
    }

    function handleTransaction(address user, bytes calldata msgData) external {
        (,, address originSender) = abi.decode(msgData[4:], (address, uint256, address));
        if (originSender == owner) {
            IForta(msg.sender).raiseAlert(user);
        }
    }
}
