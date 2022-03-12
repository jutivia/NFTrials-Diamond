// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct AppStorage {
    uint256 omega;
    mapping(uint=> bool) randomCheck;
    mapping(uint=> uint) holdRandNum;
    uint256[] cards;
} 