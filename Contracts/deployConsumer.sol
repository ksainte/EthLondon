const { types } = require("hardhat/config")
const { networks } = require("../../networks")

task("functions-deploy-consumer", "Deploys the FunctionsConsumer contract")
  .addOptionalParam("verify", "Set to true to verify contract", false, types.boolean)
  .setAction(async (taskArgs) => {
    console.log(`Deploying FunctionsConsumer contract to ${network.name}`)

    console.log("\n__Compiling Contracts__")
    await run("compile")

    const consumerContractFactory = await ethers.getContractFactory("FunctionsConsumer")
    const consumerContract = await consumerContractFactory.deploy()

    console.log(
      `\nWaiting ${networks[network.name].confirmations} blocks for transaction ${
        consumerContract.deployTransaction.hash
      } to be confirmed...`
    )
    await consumerContract.deployTransaction.wait(networks[network.name].confirmations)

    console.log("\nDeployed FunctionsConsumer contract to:", consumerContract.address)

  })
