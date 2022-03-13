pragma solidity 0.8.4;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
contract NFTs is ERC721URIStorage{
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
    constructor() ERC721("NFTrials", "NFR") {}
  function createNFT(string memory baseURI) public returns (uint256) {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _mint(msg.sender,newItemId);
    _setTokenURI(newItemId, baseURI);

    return newItemId;
  }
  function updateTokenURI(uint newItemId, string memory baseURI) public {
      _setTokenURI(newItemId, baseURI);
  }
  function changeOwnership (address diamondAddress, address to, uint256 tokenId) external{
      approve(diamondAddress, tokenId);
      address approved =  getApproved(tokenId);
      require (diamondAddress == approved, "diamond hs not been approved");
      transferFrom(diamondAddress, to, tokenId);
  }
  
}
