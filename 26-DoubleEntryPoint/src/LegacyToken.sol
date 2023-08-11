// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "openzeppelin/access/Ownable.sol";
import {ERC20} from "openzeppelin/token/ERC20/ERC20.sol";

import {IDelegateERC20} from "src/interfaces/IDelegateERC20.sol";

contract LegacyToken is ERC20("LegacyToken", "LGT"), Ownable {
    IDelegateERC20 public delegate;

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function delegateToNewContract(IDelegateERC20 newContract) public onlyOwner {
        delegate = newContract;
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        if (address(delegate) == address(0)) {
            return super.transfer(to, value);
        } else {
            return delegate.delegateTransfer(to, value, msg.sender);
        }
    }
}
