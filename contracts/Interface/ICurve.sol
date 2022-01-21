pragma solidity ^0.8.10;

interface ICurve {
    function calculatePurchaseReturn(
        uint256 _totalSupply,
        uint256 _poolBalance,
        uint256 _reserveRatio,
        uint256 _amount
    ) external pure returns (uint256);

    function calculateSaleReturn(
        uint256 _totalSupply,
        uint256 _poolBalance,
        uint256 _reserveRatio,
        uint256 _amount
    ) external pure returns (uint256);
}
