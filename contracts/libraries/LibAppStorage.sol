// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct AppStorage {
    uint256 omega;
    mapping(uint=> bool) randomCheck;
    mapping(address=> mapping(uint => bool)) isPlayerPlayed;
    uint256[] cards;
    uint256 startTimeStamp;
    uint256 day;
    uint8 interval;
    mapping(address => uint[6]) playerNum;
    mapping (address => mapping(uint=> uint)) playScore;
    mapping(uint => address[]) allPlayersPerDay;
} 