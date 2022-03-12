// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;
import {AppStorage} from "../libraries/LibAppStorage.sol";
import {LibGame} from "../libraries/LibAppGameFunctions.sol";
contract GameArena {
    AppStorage internal s;

    event ShowShuffledArray (uint256[] array);
    modifier onePlayer {
      require(block.timestamp>= s.startTimeStamp, "Game hasn't started");
      if(block.timestamp >= s.startTimeStamp+ 86400){
      uint256 timeSpace = block.timestamp - s.startTimeStamp;
      while (timeSpace - 86400 >=0){
           timeSpace -=86400;
           s.day++;
         }
      }
      require(!s.isPlayerPlayed[msg.sender][s.day], "Player has played for the day");
      require (msg.sender == tx.origin, "Player has been registered for the day");
      //  if(block.timestamp>= (s.startTimeStamp + (s.day *84600))) {
      //  }
     _;
    }

    function init() external {
      s.startTimeStamp = 1647212400;
      s.day = 1;
    }
    // function getRandomNumber() internal returns (uint randNum) {
    //     uint mod = 19;
    //     s.omega++;
    //    randNum = uint(keccak256(abi.encodePacked(block.timestamp, s.omega, msg.sender))) % mod;
    // }

    function getRandomNumber() internal returns (uint randNum) {
        uint mod = 18;
        s.omega++;
        uint result = uint(keccak256(abi.encodePacked(block.timestamp, s.omega, msg.sender))) % mod;
        randNum = result + 1;
    }
    function shuffleCards() onePlayer public {
        while (s.cards.length < 18){
          uint _rand = getRandomNumber();
          bool matches = false;
          for(uint i = 0; i < s.cards.length; i++){
            if(s.cards[i] == _rand){
              matches = true;
              break;
            }
          }
          if (!matches){
            s.cards.push(_rand);
            s.cards[s.cards.length-1] = _rand;
          }
        }
        emit ShowShuffledArray(s.cards);
    }
    function viewShuffledCards() view public returns(uint[] memory) {
        return s.cards;
    }

    function checkPlayerScore (uint256[6] memory playerNumbers) onePlayer external{
      s.isPlayerPlayed[msg.sender][s.day] = true;
      // 3. Check the players numbers vs the correct number 
    }
}