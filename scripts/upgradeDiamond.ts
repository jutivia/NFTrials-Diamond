import { BigNumberish, BytesLike } from "ethers";
import { ethers } from "hardhat";
import { DiamondCutFacet } from "../typechain-types";
import { FacetCutAction, getSelectors } from "./libraries/diamond";
// import 


export async function deployUpgrade() {
    const DIAMOND_ADDRESS = "0x77761476C258ff571c19Db9f1B8576300686159B"
    type FacetCutStruct = {
        facetAddress: string;
        action: BigNumberish;
        functionSelectors: BytesLike[];
    };

    const FacetNames = ["NFTs"];
    let cut:FacetCutStruct[] = [];
    for (const FacetName of FacetNames) {
        const Facet = await ethers.getContractFactory(FacetName);
        const facet = await Facet.deploy();
        await facet.deployed();
        console.log(`${FacetName} deployed: ${facet.address}`);
        cut.push({
            facetAddress: facet.address,
            action: FacetCutAction.Add,
            functionSelectors: getSelectors(facet),
        });
    }


    // const DiamondInit = await ethers.getContractFactory("GameArena");
    // const diamondInit = await DiamondInit.deploy();
    // await diamondInit.deployed();
    // console.log("DiamondInit deployed:", diamondInit.address);
    console.log("before diamond cut")
    const diamondCut = (await ethers.getContractAt(
        "IDiamondCut",
        DIAMOND_ADDRESS
    )) as DiamondCutFacet;
    // const payload = DiamondInit.interface.encodeFunctionData("init");
    console.log("in the middle of diamond cut")
    const tx = await diamondCut.diamondCut(
        cut,
        ethers.constants.AddressZero,
        "0x"
    );
    console.log("just after diamond cut")
    const receipt = await tx.wait()
    console.log(receipt.status)
}
console.log("after diamond cut")
if (require.main === module) {
    deployUpgrade()
        .then(() => process.exit(0))
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });
}
