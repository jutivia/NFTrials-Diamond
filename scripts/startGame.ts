import {ethers} from "hardhat";
import { GameArena } from "../typechain-types";
const DIAMOND_ADDRESS = "0x68B1D87F95878fE05B998F19b66F4baba5De1aed"
// const GAME_ARENA= "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707"

export async function shuffleCards() {
  let shuffleCard = (await ethers.getContractAt("GameArena", DIAMOND_ADDRESS)) as GameArena;
   await shuffleCard.init()
  const receipt = await shuffleCard.shuffleCards()
    const result = await shuffleCard.viewShuffledCards()
  console.log(await receipt.wait());
  console.log(result);
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

