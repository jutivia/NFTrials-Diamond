import {ethers} from "hardhat";
import { GameArena } from "../typechain-types";
const DIAMOND_ADDRESS = "0x0B306BF915C4d645ff596e518fAf3F9669b97016"
// const GAME_ARENA= "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707"

export async function shuffleCards() {
  let shuffleCard = (await ethers.getContractAt("GameArena", DIAMOND_ADDRESS)) as GameArena;
  // const receipt = await shuffleCard.shuffleCards()
  // const result = await shuffleCard.viewShuffledCards()
  const playerScore = await shuffleCard.checkPlayerScore([7,11,1,5,18,15]);
  const entire =await playerScore.wait();
  // @ts-ignore
  console.log(entire.events[0].args)
  
  // console.log(await receipt.wait());
  // console.log(result);
}
if (require.main === module) {
  shuffleCards()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
}

exports.shuffleCards = shuffleCards;

