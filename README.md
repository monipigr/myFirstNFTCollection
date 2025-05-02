# 🎨 myFirstNFTCollection

## 📝 Overview

`myFirstNFTCollection` is a simple and gas-efficient ERC-721 implementation built with Solidity and tested using Foundry. The contract allows users to mint NFTs up to a fixed total supply, each with a dynamically generated metadata URI. Designed as a foundational step into NFT development, the project demonstrates solid practices in smart contract design, event usage, and testing.

## ✨ Features

- 🎟️ **Fixed Supply Minting**:
  - Users can mint NFTs up to a preset maximum supply
- 🔗 **Dynamic Metadata URI**:
  - Each token has a `.json` metadata URI based on a base IPFS URL
- ⚠️ **Minting Limits**:
  - Prevents minting after reaching the total supply
- 📢 **Event Emission**:
  - Emits a custom `MintNFT` event on every successful mint

## 🏗 Smart Contract Architecture and Patterns

- **ERC721 Standard**: Inherits OpenZeppelin's robust ERC721 implementation
- **Storage Variables**:
  - `currentTokenId`: tracks next token to mint
  - `totalSupply`: immutable max number of NFTs
  - `baseUri`: used for metadata resolution
- **Core Logic**:
  - `mint()`: mints NFTs sequentially with `_safeMint`, emits `MintNFT` event
  - `tokenURI(uint256)`: returns full metadata URI, combining baseUri and tokenId
- **Security Practices**:
  - Uses `_requireOwned` to prevent querying non-existent token metadata
- **Design Choices**:
  - Public minting with no access control (no `Ownable`)
  - Linear minting logic without metadata reveal or rarity mechanics

## 🛠 Technologies Used

- **Solidity**: `^0.8.24`
- **Framework**: [Foundry](https://book.getfoundry.sh/)
- **OpenZeppelin Contracts**: v4.x ERC721 standard

## 🧪 Testing

Unit tests are written using Foundry to ensure contract reliability:

| **Test Function**                         | **Description**                               |
| ----------------------------------------- | --------------------------------------------- |
| `test_BANFTCollectionCorrectlyDeployed()` | Contract deployment validation                |
| `test_mintCorrectly()`                    | Mints NFT, verifies tokenId and ownership     |
| `test_mintRevertsTotalSupply()`           | Ensures minting is blocked after supply limit |
| `test_emitMintNFTEvent()`                 | Checks correct event emission on mint         |
| `test_tokenURI()`                         | Validates URI generation for minted tokens    |
| `test_tokenURIRevertsIfTokenNotMinted()`  | Prevents access to unminted token URIs        |
| `testFuzz_tokenURI()`                     | Fuzz testing for dynamic URI correctness      |

Tests cover edge cases such as double minting, token existence validation, and proper URI generation.

## 💯 ✅ Full Test Coverage Report

```
forge coverage
```

| File                    | % Lines             | % Statements        | % Branches        | % Funcs           |
| ----------------------- | ------------------- | ------------------- | ----------------- | ----------------- |
| src/BANFTCollection.sol | 100.00% (15/15)     | 100.00% (13/13)     | 100.00% (2/2)     | 100.00% (4/4)     |
| **Total**               | **100.00% (15/15)** | **100.00% (13/13)** | **100.00% (2/2)** | **100.00% (4/4)** |

## 🛠 Technologies Used

- **Solidity**: `^0.8.24`
- **Foundry**: For deploying, testing, fuzzing and assertions
- **OpenZeppelin Contracts**: `ERC721`, `IERC721`
- **Strings**: For converting `uint256` token IDs into strings in `tokenURI`

## 🔧 How to Use

### Prerequisites

- Install [Foundry](https://book.getfoundry.sh/)
- Install [OpenZeppelin](https://docs.openzeppelin)

### Installation

Install [Foundry](https://book.getfoundry.sh/getting-started/installation)

### 🛠 Setup

```bash
git clone https://github.com/your-username/myFirstNFTCollection.git
cd myFirstNFTCollection
forge install
```

### Testing

```bash
forge test
forge --match-test testExample -vvvv
```

## 📜 License

This project is licensed under the MIT License.
