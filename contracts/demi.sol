pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
contract DEMIToken is ERC20 {
    uint256 public scale = 10**18;
    constructor() ERC20("DEMI", "DMI")  {
        _mint(msg.sender, scale*200000000);
    }
}