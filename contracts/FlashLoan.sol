pragma solidity ^0.6.0;

import "./utils/FlashLoanReceiverBase.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract FlashLoan is FlashLoanReceiverBase {
    using SafeMath for uint;

    constructor(ILendingPoolAddressesProvider _addressProvider)
        public
        FlashLoanReceiverBase(_addressProvider) {

    }

	function flashLoanCall(address assetsAddress) public {
        address receiverAddress = address(this);

        address[] memory assets = new address[](1);
        assets[0] = assetsAddress;

        uint256[] memory amounts = new uint256[](assets.length);
        amounts[0] = 1000000 * 1000000;

        // 0 = no debt, 1 = stable, 2 = variable
        uint256[] memory modes = new uint256[](assets.length);
        modes[0] = 0;

        address onBehalfOf = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        LENDING_POOL.flashLoan(
            receiverAddress,
            assets,
            amounts,
            modes,
            onBehalfOf,
            params,
            referralCode
        );
    }

    /**
        This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    )
        external
        override
        returns (bool)
    {

        //
        // This contract now has the funds requested.
        // Your logic goes here.
        //
        
        // At the end of your logic above, this contract owes
        // the flashloaned amounts + premiums.
        // Therefore ensure your contract has enough to repay
        // these amounts.
        
        // Approve the LendingPool contract allowance to *pull* the owed amount
        for (uint i = 0; i < assets.length; i++) {
            uint amountOwing = amounts[i].add(premiums[i]);
            IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
        }
        
        return true;
    }

}