// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;
import {AppStorage} from "../libraries/LibAppStorage.sol";

contract GameArena {
    AppStorage internal s;
    event ShowShuffledArray (uint256[] array);
//     function randomNumber () internal returns(uint){
//       uint mod = 23;
//       s.omega ++;
//       uint256 randNum = uint(keccak256(abi.encodePacked(block.timestamp, s.omega, msg.sender))) % mod;
//       if(!s.randomCheck[randNum]) {
//         s.randomCheck[randNum] = true;
//         s.holdRandNum[s.omega] = randNum;
//       } else {
//         randomNumber();
//       }
//   }
//     function shuffleCards() external returns (uint256[] memory) {
//         s.cards= [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24];
//         for (uint i = 0; i < 24; i++){
//             uint256 randNum = randomNumber();
//             s.cards[i] = s.cards[randNum];
//         }
//     }

  function getRandomNumber() internal returns (uint randNum) {
       uint mod = 18;
       s.omega++;
         randNum = uint(keccak256(abi.encodePacked(block.timestamp, s.omega, msg.sender))) % mod;
  }
  function shuffleCards() public {
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

  function checkPlayerScore (uint256[6] playerNumbers) external{
    // 3. Check the players numbers vs the correct number 
  }
}