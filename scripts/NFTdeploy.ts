import {ethers} from "hardhat";
import { NFTs } from "../typechain-types";
const DIAMOND_ADDRESS = "0x77761476C258ff571c19Db9f1B8576300686159B"
// const GAME_ARENA= "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707"

export async function deployNFT() {
  let NFTtoken = (await ethers.getContractAt("NFT", DIAMOND_ADDRESS)) as NFTs;
  await NFTtoken.createNFT(
    "ipfs://QmPJWXduGGWo3ztEN21FnZE9RWfburph21CNirtLqFpMiM"
  );
   await NFTtoken.updateTokenURI(
    1,
    "ipfs://QmPJWXduGGWo3ztEN21FnZE9RWfburph21CNirtLqFpMiM"
  );
  // console.log(await receipt.wait());
}
if (require.main === module) {
  deployNFT()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
}

exports.shuffleCards = deployNFT;

