pragma solidity >=0.6.0;

interface IAAVE {
    function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
}