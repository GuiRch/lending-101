var points = artifacts.require("ERC20TD.sol");
var evaluator = artifacts.require("Evaluator.sol");
var exerciceSolution = artifacts.require("ExerciceSolution.sol");

var erc20 = artifacts.require("IERC20.sol")

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await hardcodeContractAddress(deployer, network, accounts)
        await deploySolution(deployer, network, accounts);
    });
};

async function hardcodeContractAddress(deployer, network, accounts) {
	TDToken = await points.at("0xEA6eF07Eb2D93F618120fF8AD6537f562e011790")
	Evaluator = await evaluator.at("0xF00a099b637841fB2D240ABEeDeb48719836fd6D")

    DAIAddress = "0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD"
	Dai = await erc20.at(DAIAddress)

	USDCAddress = "0xe22da380ee6b445bb8273c81944adeb6e8450422"
    aDAIAddress = "0xdcf0af9e59c002fa3aa091a46196b37530fd48a8"
    variableDebtUSDCAddress = "0xbe9b058a0f2840130372a81ebb3181dce02be957"
}

async function deploySolution(deployer, network, accounts) {
	var myPoints = await TDToken.balanceOf(accounts[0])
    console.log("Points before : " + myPoints.toString())

    ExerciceSolution = await exerciceSolution.new(DAIAddress, USDCAddress)
    console.log('ExerciceSolution address : ' + ExerciceSolution.address)

    // Send Dai to the contract for the need of the exercice
    const myDAIBalance = await Dai.balanceOf(accounts[0])
    const amountDAIToSend = Math.floor(myDAIBalance/500)
    console.log('My Dai balance : ' + myDAIBalance.toString())
    console.log('Amount Dai to send : ' + amountDAIToSend.toString())
    await Dai.transfer(ExerciceSolution.address, BigInt(amountDAIToSend))

    // await Evaluator.submitExercice(ExerciceSolution.address)
    
    // await Evaluator.ex5_showContractCanDepositTokens()
    // console.log('Ex 5 Done')

    // await Evaluator.ex6_showContractCanBorrowTokens()
    // console.log('Ex 6 Done')

    // await Evaluator.ex7_showContractCanRepayTokens()
    // console.log('Ex 7 Done')

    // await Evaluator.ex8_showContractCanWithdrawTokens()
    // console.log('Ex 8 Done')

    // await Evaluator.ex9_performFlashLoan()
    // console.log('Ex 9 Done')

    var myPoints = await TDToken.balanceOf(accounts[0])
	console.log("Points after : " + myPoints.toString())
}
