pragma solidity ^0.6.0;

import "./IExerciceSolution.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ExerciceSolution {

    IERC20 public DAI;
    IERC20 public USDC;

    constructor(IERC20 _DAI, IERC20 _USDC) public {
        DAI = _DAI;
        USDC = _USDC;
	}

    function depositSomeTokens() public {

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