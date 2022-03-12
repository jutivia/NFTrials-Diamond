import {ethers} from "hardhat";
import { GameArena } from "../typechain-types";
const DIAMOND_ADDRESS = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"
// const GAME_ARENA= "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707"

export async function shuffleCards() {
    let shuffleCard = (await ethers.getContractAt("GameArena", DIAMOND_ADDRESS)) as GameArena;
    await shuffleCard.shuffleCards()
    const result = await shuffleCard.viewShuffledCards()
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

