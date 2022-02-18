pragma solidity ^0.6.0;

import "./utils/IAAVE.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ExerciceSolution {

    uint myDAIBalance;

    IERC20 public DAI;
    IERC20 public USDC;

    IAAVE public aave;

    constructor(IAAVE _aave, IERC20 _DAI, IERC20 _USDC) public {
        aave = IAAVE(_aave);

        DAI = _DAI;
        USDC = _USDC;
	}

    function depositSomeTokens() public {
        myDAIBalance = DAI.balanceOf(address(this));
        DAI.approve(address(aave), myDAIBalance);

        aave.deposit(address(DAI), myDAIBalance, address(this), 0);
    }

	function borrowSomeTokens() public {
        aave.borrow(address(USDC), 1000, 2, 0, address(this));
    }

	function repaySomeTokens() public {
        USDC.approve(address(aave), 1000);
        aave.repay(address(USDC), uint(-1), 2, address(this));
    }

    function withdrawSomeTokens() public {
        aave.withdraw(address(DAI), myDAIBalance, address(this));   
    }

	function doAFlashLoan() public {
        
    }

	function repayFlashLoan() public {
        
    }

}