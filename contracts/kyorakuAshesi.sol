// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract kyorakuAshesi is ERC1155,ERC1155Burnable,Ownable {
        // Constandt id's
    uint public constant kOne = 0; 
    uint public constant kTwo = 1; 
    constructor () ERC1155(
        "https://bafybeihfu3p6ptz57kgbpwdyrmxp66djx3rzibenb4546xszl3ayvcyusm.ipfs.nftstorage.link/{id}.json")
     {
         // mint (receiver address,token id,token value, metadata) // => in this case we passing empty meta data
        _mint(msg.sender, kOne, 50, ""); // 50 token 
        _mint(msg.sender, kTwo, 1, ""); // 1 token 
    }
    // for retreiving token specific string url
    function uri(uint _tokenId) public pure override returns (string memory){
        // retunring it with abi.encoding helps the ethereum blockchain to interact with externa; system
       return string(
           abi.encodePacked(
               "https://bafybeihfu3p6ptz57kgbpwdyrmxp66djx3rzibenb4546xszl3ayvcyusm.ipfs.nftstorage.link/",
               Strings.toString(_tokenId),
               ".json"
           )
       );
    }
    // this is something open sea require for enitire contract (collection)
    function contractURI() public pure returns (string memory){
        return "https://bafybeihfu3p6ptz57kgbpwdyrmxp66djx3rzibenb4546xszl3ayvcyusm.ipfs.nftstorage.link/collection.json";
    }
    // now comes to the greates of all time the airdrop function
    function airDrop(
        uint tokenId,
        address[] calldata recipients) external  onlyOwner{
            for (uint counter =0; counter < recipients.length; counter++) 
            {
            _safeTransferFrom(msg.sender, recipients[counter], tokenId, 1, "");
            // the magic and luckiest person get the nft
             if(balanceOf(owner(), kOne) == 25 &&  //  means if only one token left send it and also
                                                        //  send the nft to the luckiest person
               balanceOf(owner(), kTwo) == 1){
                   _safeTransferFrom(msg.sender, recipients[counter], kTwo, 1, "");
                
               }
            }
           
    }
    // now overriding before token transfer function
    // thats mean tokens can only be burned but not transfered
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint[] memory ids,
        uint[] memory amounts,
        bytes memory data
    ) 
    internal 
    override 
    onlyOwner{
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
        require(msg.sender == owner() || to == address(0), "Tokens can only burned");

    }

}