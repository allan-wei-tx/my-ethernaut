// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Selfdestructable {
    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}
