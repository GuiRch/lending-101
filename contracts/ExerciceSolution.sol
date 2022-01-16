pragma solidity ^0.6.0;

import "./utils/IAAVE.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ExerciceSolution {

    IERC20 public DAI;
    IERC20 public USDC;

    IAAVE public aave;

    constructor(IAAVE _aave, IERC20 _DAI, IERC20 _USDC) public {
        aave = IAAVE(_aave);

        DAI = _DAI;
        USDC = _USDC;
	}

    function depositSomeTokens() public {
        uint myDAIBalance = DAI.balanceOf(address(this));
        DAI.approve(0xE0fBa4Fc209b4948668006B2bE61711b7f465bAe, myDAIBalance);

        aave.deposit(address(DAI), myDAIBalance, address(this), 0);
    }

    function withdrawSomeTokens() public {
        
    }

	function borrowSomeTokens() public {
        
    }

	function repaySomeTokens() public {
        
    }

	function doAFlashLoan() public {
        
    }

	function repayFlashLoan() public {
        
    }

}