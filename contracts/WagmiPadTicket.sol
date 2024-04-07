//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "./ERC404.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract WagmiPadTicket is ERC404 {
    string public dataURI;
    string public baseTokenURI;

    constructor(
        address _owner
    ) ERC404("WagmiPad Ticket", "WPTKT", 18, 100000, _owner) {
        balanceOf[_owner] = 100000 * 10 ** 18;
    }

    function setDataURI(string memory _dataURI) public onlyOwner {
        dataURI = _dataURI;
    }

    function setTokenURI(string memory _tokenURI) public onlyOwner {
        baseTokenURI = _tokenURI;
    }

    function setNameSymbol(
        string memory _name,
        string memory _symbol
    ) public onlyOwner {
        _setNameSymbol(_name, _symbol);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        if (bytes(baseTokenURI).length > 0) {
            return string.concat(baseTokenURI, Strings.toString(id));
        } else {
            uint8 seed = uint8(bytes1(keccak256(abi.encodePacked(id))));
            string memory image;
            string memory color;

            if (seed <= 100) {
                image = "1.jpg";
                color = "Blue";
            } else if (seed <= 160) {
                image = "2.jpg";
                color = "Green";
            } else if (seed <= 210) {
                image = "3.jpg";
                color = "Yellow";
            } else if (seed <= 240) {
                image = "4.jpg";
                color = "Red";
            } else if (seed <= 255) {
                image = "5.jpg";
                color = "Brown";
            }

            string memory jsonPreImage = string.concat(
                string.concat(
                    string.concat('{"name": "Bera Ticket #', Strings.toString(id)),
                    '","description":"A collection of 100,000 Replicants enabled by ERC404, an experimental token standard.","external_url":"https://pandora.build","image":"'
                ),
                string.concat(dataURI, image)
            );
            string memory jsonPostImage = string.concat(
                '","attributes":[{"trait_type":"Color","value":"',
                color
            );
            string memory jsonPostTraits = '"}]}';

            return
                string.concat(
                    "data:application/json;utf8,",
                    string.concat(
                        string.concat(jsonPreImage, jsonPostImage),
                        jsonPostTraits
                    )
                );
        }
    }
}