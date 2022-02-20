pragma solidity ^0.6.0;

import "./FlashLoan.sol";

import "./utils/ILendingPool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ExerciceSolution {

    uint myDAIBalance;

    FlashLoan flashLoan;

    IERC20 public DAI;
    IERC20 public USDC;

    ILendingPool public LENDING_POOL;

    constructor(FlashLoan _flashLoan, ILendingPool _LENDING_POOL, IERC20 _DAI, IERC20 _USDC) public {
        flashLoan = _flashLoan;
        
        LENDING_POOL = ILendingPool(_LENDING_POOL);

        DAI = _DAI;
        USDC = _USDC;
	}

    function depositSomeTokens() public {
        myDAIBalance = DAI.balanceOf(address(this));
        DAI.approve(address(LENDING_POOL), myDAIBalance);

        LENDING_POOL.deposit(address(DAI), myDAIBalance, address(this), 0);
    }

	function borrowSomeTokens() public {
        LENDING_POOL.borrow(address(USDC), 1000, 2, 0, address(this));
    }

	function repaySomeTokens() public {
        USDC.approve(address(LENDING_POOL), 1000);
        LENDING_POOL.repay(address(USDC), uint(-1), 2, address(this));
    }

    function withdrawSomeTokens() public {
        LENDING_POOL.withdraw(address(DAI), myDAIBalance, address(this));   
    }

	function doAFlashLoan() public {
        flashLoan.flashLoanCall(address(USDC));
    }

	function repayFlashLoan() public {
        
    }

}