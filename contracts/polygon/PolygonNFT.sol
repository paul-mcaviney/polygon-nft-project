// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

// Import the OpenZeppelin contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Declare our contract and inherit from the OpenZeppelin ERC721 and Ownable contracts 
contract PolygonNFT is ERC721, Ownable {
    // Helpers for counting safely and converting data to strings
    using Counters for Counters.Counter;
    using Strings for uint256;

    // State variable for storing the current token Id
    Counters.Counter private _tokenIds;
    // Map token Ids to token URI
    mapping (uint256 => string) private _tokenURIs;

    // ERC721 requires a name for the NFT and a symbol
    constructor() ERC721("PolygonNFT", "PNFT") {}

    // Set the URI for tokenId
    function _setTokenURI(uint256 tokenId, string memory _tokenURI)
        internal
        virtual
    {
        _tokenURIs[tokenId] = _tokenURI;
    }

    // Return the Token URI - Required for viewing properly on OpenSea
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "Token does not exist");
        string memory _tokenURI = _tokenURIs[tokenId];

        return _tokenURI;
    }

    // Mint the NFT to the provided address, using the provided MetaData URI -- only the wallet address that deployed the contract can call this function
    function mint(address recipient, string memory uri)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(recipient, newItemId);
        _setTokenURI(newItemId, uri);

        return newItemId;
    }
}