pragma solidity ^0.8.10;


import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";

import "./Interface/IBondingCurve.sol";
import "./BancorFormula.sol";
import "./MaxGasPrice.sol";

contract CurveBondedToken is IBondingCurve, BancorFormula, Ownable, MaxGasPrice, ERC20 {
    using SafeMath for uint256;

    // Use the same decimal places as ether.
    uint256 public scale = 10**18;
    uint256 public poolBalance = 1*scale;
    uint256 public reserveRatio= 100000;
   
    uint256 _totalSupply;
ERC20 token;
    constructor( address tok )  ERC20("Mahesh","MB") {
        _totalSupply=10*scale;
        token=ERC20(tok);
    }

    function calculateCurvedMintReturn(uint256 _amount)
        public view returns (uint256 mintAmount)
    {
        return calculatePurchaseReturn(totalSupply(), poolBalance, uint32(reserveRatio), _amount);
    }

    function calculateCurvedBurnReturn(uint256 _amount)
        public view returns (uint256 burnAmount)
    {
        return calculateSaleReturn(totalSupply(), poolBalance, uint32(reserveRatio), _amount);
    }

    modifier validMint(uint256 _amount) {
        require(_amount > 0, "Amount must be non-zero!");
        _;
    }

    modifier validBurn(uint256 _amount) {
        require(_amount > 0, "Amount must be non-zero!");
        require(balanceOf(msg.sender) >= _amount, "Sender does not have enough tokens to burn.");
        _;
    }

    function _curvedMint(uint256 _deposit) 
        validGasPrice
        validMint(_deposit)
        internal returns (bool)
    {
            uint256 allowance = token.allowance(msg.sender, address(this));
    require(allowance >= _deposit, "Check the token allowance");
    token.transferFrom(msg.sender, address(this), _deposit);
        uint256 amount = calculateCurvedMintReturn(_deposit);
        _mint(msg.sender, amount);
        poolBalance = poolBalance.add(_deposit);
        emit CurvedMint(msg.sender, amount, _deposit);
        return true;
    }

    function _curvedBurn(uint256 _amount)
        validGasPrice
        validBurn(_amount)
        internal returns (bool)
    {
        uint256 reimbursement = calculateCurvedBurnReturn(_amount);
        poolBalance = poolBalance.sub(reimbursement);
        _burn(msg.sender, _amount);
        token.transfer(msg.sender, reimbursement);
        emit CurvedBurn(msg.sender, _amount, reimbursement);
        return true;
    }
}
