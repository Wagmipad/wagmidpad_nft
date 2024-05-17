//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "./ERC404.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract WagmiPadTicket2 is ERC404 {
    string public dataURI;
    string public baseTokenURI;

    error AlreadyMinted();
    /// @dev Wallets that already minted the ticket
    mapping(address => bool) public mintedWallets;

    

    constructor(
        address _owner
    ) ERC404("WagmiPad Ticket 2", "WPTKT2", 18, 0, _owner) {
        //balanceOf[_owner] = 100000 * 10 ** 18;
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
                image = "6.png";
                color = "Blue";
            } else if (seed <= 160) {
                image = "7.png";
                color = "Green";
            } else if (seed <= 210) {
                image = "8.png";
                color = "Yellow";
            } else if (seed <= 240) {
                image = "9.png";
                color = "Red";
            } else if (seed <= 255) {
                image = "10.png";
                color = "Brown";
            }

            string memory jsonPreImage = string.concat(
                string.concat(
                    string.concat('{"name": "WagmiPad Ticket Series 2 #', Strings.toString(id)),
                    '","description":"A collection of WagmiPad Ticket enabled by ERC404, an experimental token standard.","external_url":"https://wagmipad.org","image":"'
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

    function mint() public returns (bool) {
        
        if (mintedWallets[msg.sender]) {
            revert AlreadyMinted();
        }

        mintedWallets[msg.sender] = true;
        // Increase erc20 balance
        balanceOf[msg.sender] += _getUnit();
        totalSupply += _getUnit();
        
        _mint(msg.sender);

        emit ERC20Transfer(address(0), msg.sender, _getUnit());
        return true;
    }
}