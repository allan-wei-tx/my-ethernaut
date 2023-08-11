// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {IERC20} from "openzeppelin/token/ERC20/IERC20.sol";

import {DetectionBot} from "src/DetectionBot.sol";
import {DoubleEntryPoint} from "src/DoubleEntryPoint.sol";
import {Forta} from "src/Forta.sol";
import {LegacyToken} from "src/LegacyToken.sol";
import {CryptoVault} from "src/CryptoVault.sol";

contract DetectionBotTest is Test {
    function setUp() public {
        vm.createSelectFork(vm.envString("GOERLI_RPC_URL"));
    }

    function test_DetectionBot() public {
        DoubleEntryPoint det = DoubleEntryPoint(0x3d9475a8cDEAe257b354B72c37930523A775e0f0);
        address vault = det.cryptoVault();
        Forta forta = det.forta();
        LegacyToken legacyToken = LegacyToken(det.delegatedFrom());
        address legacyTokenOwner = legacyToken.owner();
        DetectionBot bot = new DetectionBot(vault);

        vm.prank(det.player());
        forta.setDetectionBot(address(bot));
        vm.expectRevert();
        vm.prank(legacyTokenOwner);
        CryptoVault(vault).sweepToken(IERC20(address(legacyToken)));
    }
}
