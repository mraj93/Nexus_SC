// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiTokenERC721 is ERC721URIStorage, Ownable{
    constructor() ERC721("", "") {}

    uint256 public tokenId = 1;

    struct NFT {
        string nftName;
        string description;
        uint256 price;
        string nftURI;
        string metaDataURI;
    }

    mapping (uint256 => NFT) public NFTDetail;
    mapping (uint256 => address) public Creator;
    mapping (uint256 => string) private MetadataURIs;

    function mint(string memory nftName, uint256 price, string memory description, string memory nftURI, string memory metaDataURI) public {
        _safeMint(msg.sender, tokenId, "");
        _setTokenURI(tokenId, nftURI);
        Creator[tokenId] =msg.sender;
        MetadataURIs[tokenId] = metaDataURI;
        NFT memory nft = NFT(nftName, description, price, nftURI, metaDataURI);
        NFTDetail[tokenId] = nft;
        ++tokenId;
    }
    
    function updateTokenMetadataURI(uint256 _tokenId, string memory newMetadataURI) public onlyOwner {
        require(_exists(_tokenId), "ERC721: URI query for nonexistent token");
        MetadataURIs[_tokenId] = newMetadataURI;
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");
        string memory baseURI = _baseURI();
        string memory getTokenURI = MetadataURIs[_tokenId];
        if (bytes(baseURI).length == 0) {
            return getTokenURI;
        } else {
            return string(abi.encodePacked(baseURI, getTokenURI));
        }
    }

    function getDetails (uint256 _tokenId) public view returns(NFT memory) {
        return NFTDetail[_tokenId];
    }
}