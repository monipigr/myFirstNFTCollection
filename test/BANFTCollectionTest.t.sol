// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BANFTCollection} from "../src/BANFTCollection.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";


contract BANFTCollectionTest is Test {
    using Strings for uint256;

    BANFTCollection public nftCollection;
    event MintNFT(address userAddress_, uint256 tokenId_);

    address user1 = vm.addr(1);
    uint256 constant TOTAL_SUPPLY = 2;
    string constant BASE_URI = "ipfs://bafybeibsw7gwukejbib2ukd3cupyaspegxpxsvxlw7jqjpk4tnetsz2zo4";


    function setUp() public {
        string memory name_ = "Blockchain Accelerator NFT";
        string memory symbol_ = "BANFT"; 
        uint256 totalSupply_ = 2; 
        string memory baseUri_ = "ipfs://bafybeibsw7gwukejbib2ukd3cupyaspegxpxsvxlw7jqjpk4tnetsz2zo4";
        nftCollection = new BANFTCollection(name_, symbol_, totalSupply_, baseUri_);        
    }

    /// @notice Should deploy the contract and assign a non-zero address
    function test_BANFTCollectionCorrectlyDeployed() external view {
        assert(address(nftCollection) != address(0));
    }

    /// @notice Should allow a user to mint a token, increment currentTokenId, and assign correct ownership
    function test_mintCorrectly() external {
        vm.startPrank(user1);

        nftCollection.mint();
        assertEq(nftCollection.currentTokenId(), 1);
        assertEq(nftCollection.ownerOf(0), user1);

        vm.stopPrank();
    }

    /// @notice Should revert if total supply has been reached
    function test_mintRevertsTotalSupply() external {
        vm.startPrank(user1);

        for (uint256 i = 0; i < TOTAL_SUPPLY; i++) {
            nftCollection.mint();
        }
        vm.expectRevert("Sold out");
        nftCollection.mint();

        vm.stopPrank();
    }

    /// @notice Should emit MintNFT event when a user successfully mints a token
    function test_emitMintNFTEvent() external {
        vm.startPrank(user1);

        vm.expectEmit(false, false, false, true);
        emit MintNFT(user1, 0);
        nftCollection.mint();

        vm.stopPrank();
    }

    /// @notice Should correctly generate the tokenURI for token ID 0 after minting
    function test_tokenURI() external {
        uint256 tokenId = 0;

        vm.startPrank(user1);

        nftCollection.mint();
        string memory expectedURI = string.concat(BASE_URI, tokenId.toString(), ".json");
        string memory tokenURI = nftCollection.tokenURI(0);
        assertEq(tokenURI, expectedURI); 

        vm.stopPrank();
    }

    /// @notice Should revert when querying tokenURI before the token has been minted
    function test_tokenURIRevertsIfTokenNotMinted() external {
        vm.expectRevert();
        nftCollection.tokenURI(0);
    }

}



