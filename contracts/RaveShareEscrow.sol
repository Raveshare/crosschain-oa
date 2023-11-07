// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

struct SalesConfiguration {
    uint104 publicSalePrice;
    uint32 maxSalePurchasePerAddress;
    uint64 publicSaleStart;
    uint64 publicSaleEnd;
    uint64 presaleStart;
    uint64 presaleEnd;
    bytes32 presaleMerkleRoot;
}

struct DropParams {
    string name;
    string symbol;
    address defaultAdmin;
    uint64 editionSize;
    uint16 royaltyBPS;
    address payable fundsRecipient;
    SalesConfiguration saleConfig;
    string metadataURIBase;
    string metadataContractURI;
}

import "./IZoraNFTCreatorV1/IZoraNFTCreatorV1.sol";

/// @dev RaveShare Escrow Proxy Access Contract
contract RaveShareEscrowProxy {
    address public zoraNFTCreatorContract =
        0xfFFD7409031B1aeb731271C6C2D59771523Ff8a8;

    IZoraNFTCreatorV1 public zora = IZoraNFTCreatorV1(zoraNFTCreatorContract);

    // function mintNFT() public returns (uint256) {
    //     uint256 result = zora.createDrop();
    //     require(result == 0, "RaveShareEscrowProxy: mintNFT failed");
    //     return result;
    // }

    function createNFT(DropParams calldata params) public returns (address) {
        // Call the external contract's createDrop function with the struct
        address newNFTContract = zora.createDrop(
            params.name,
            params.symbol,
            params.defaultAdmin,
            params.editionSize,
            params.royaltyBPS,
            params.fundsRecipient,
            params.saleConfig,
            params.metadataURIBase,
            params.metadataContractURI
        );

        // Return the address of the newly created NFT contract
        return newNFTContract;
    }
}