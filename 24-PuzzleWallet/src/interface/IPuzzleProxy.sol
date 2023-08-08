// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPuzzleProxy {
    function pendingAdmin() external view returns (address);

    function admin() external view returns (address);

    function proposeNewAdmin(address newAdmin) external;

    function approveNewAdmin(address expectedAdmin) external;

    function upgradeTo(address newImplementation) external;
}
