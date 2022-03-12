import {ethers} from "hardhat";
import { GameArena } from "../typechain-types";
const DIAMOND_ADDRESS = "0xe70f935c32dA4dB13e7876795f1e175465e6458e"
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

