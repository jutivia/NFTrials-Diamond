// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import {AppStorage} from "../libraries/LibAppStorage.sol";
import {LibGame} from "../libraries/LibAppGameFunctions.sol";
contract GameArena {
    AppStorage internal s;
    struct player {
      address playerAddress;
      uint score;
    }

    event ShowShuffledArray (uint256[] array);
    event EmitScores(uint indexed scores);

    modifier onePlayer {
      require(block.timestamp >= s.startTimeStamp, "Game hasn't started");
      if(block.timestamp >= (s.startTimeStamp + 86400)){
      uint256 timeSpace = block.timestamp - s.startTimeStamp;
      while (timeSpace - 86400 >=0 ){
           timeSpace -=86400;
           s.day++;
         }
      }
      require(!s.isPlayerPlayed[msg.sender][s.day], "Player has played for the day");
      require (msg.sender == tx.origin, "Player has been registered for the day");
     _;
    }

    function init() external {
      s.startTimeStamp = block.timestamp;
      // s.startTimeStamp = 1647212400;
      s.day = 1;
    }

    function getRandomNumber() internal returns (uint randNum) {
        uint mod = 18;
        s.omega++;
        uint result = uint(keccak256(abi.encodePacked(block.timestamp, s.omega, msg.sender))) % mod;
        randNum = result + 1;
    }

     function clearArray() internal {
      while(s.cards.length > 0){
        s.cards.pop();
      }
    }
    function shuffleCards() onePlayer public {
      clearArray();
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

    function checkPlayerScore (uint256[6] memory playerNumbers) onePlayer external{
      uint score;
      for (uint256 i = 0; i < playerNumbers.length; i++) {
        if(playerNumbers[i] == 1){
          score++;
        }
        if(playerNumbers[i] == 2){
          score++;
        }
        if(playerNumbers[i] == 3){
          score++;
        }
        if(playerNumbers[i] == 4){
          score++;
        }
        if(playerNumbers[i] == 5){
          score++;
        }
        if(playerNumbers[i] == 6){
          score++;
        }
      }
      s.playScore[msg.sender][s.day] = score;
      s.isPlayerPlayed[msg.sender][s.day] = true;
      s.allPlayersPerDay[s.day].push(msg.sender);
      emit EmitScores(score);
    }

    function leaderBoard()external view returns(player[] memory x){
    //   struct player {
    //   address playerAddress;
    //   uint score;
    // }
    x =new player[](s.allPlayersPerDay[s.day].length);
    
    for(uint i = 0; i < s.allPlayersPerDay[s.day].length; i++){
      uint score =  s.playScore[s.allPlayersPerDay[s.day][i]][s.day];
      address player_ = s.allPlayersPerDay[s.day][i];
      x[i]= player(player_, score);
    }
      return x;
    }
}