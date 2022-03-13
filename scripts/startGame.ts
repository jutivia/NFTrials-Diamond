import { ethers } from "hardhat";
import { GameArena } from "../typechain-types";
const DIAMOND_ADDRESS = "0xDC11f7E700A4c898AE5CAddB1082cFfa76512aDD"
// const GAME_ARENA= "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707"

export async function MainGame() {
  let shuffleCard = (await ethers.getContractAt("GameArena", DIAMOND_ADDRESS)) as GameArena;
  await shuffleCard.init()
  const receipt = await shuffleCard.displayLeaderBoard("0x77761476C258ff571c19Db9f1B8576300686159B", 5)
  const playerScore = await shuffleCard.shuffleCards();
  const entire = await receipt.wait();
  const scores = await playerScore.wait()
  // @ts-ignore
  console.log(entire.events[0].args[0])
  // @ts-ignore
  console.log(scores.events[0].args)
  // console.log(await receipt.wait());
}
if (require.main === module) {
  MainGame()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
}

exports.shuffleCards = MainGame;

