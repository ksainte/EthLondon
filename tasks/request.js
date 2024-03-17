const {
    simulateScript,
    decodeResult,
  } = require("@chainlink/functions-toolkit")
  const { networks } = require("../networks")
  const path = require("path")
  const process = require("process")
  
  task("functions-request", "Initiates an on-demand request from a Functions consumer contract")
    .addParam("contract", "Address of the consumer contract to call")
    .addParam("subid", "Billing subscription ID used to pay for the request")
    .addOptionalParam(
      "simulate",
      "Flag indicating if source JS should be run locally before making an on-chain request",
      true,
      types.boolean
    )
    .addOptionalParam(
      "callbackgaslimit",
      "Maximum amount of gas that can be used to call fulfillRequest in the consumer contract",
      100_000,
      types.int
    )
    .addOptionalParam(
      "slotid",
      "Slot ID to use for uploading DON hosted secrets. If the slot is already in use, the existing encrypted secrets will be overwritten.",
      0,
      types.int
    )
    .addOptionalParam("requestgaslimit", "Gas limit for calling the executeRequest function", 1_500_000, types.int)
    .addOptionalParam(
      "configpath",
      "Path to Functions request config file",
      `${__dirname}./Functions-request-config.js`,
      types.string
    )
    .setAction(async (taskArgs, hre) => {
      // Get the required parameters
      const contractAddr = taskArgs.contract
  
      // Attach to the FunctionsConsumer contract
      const consumerFactory = await ethers.getContractFactory("FunctionsConsumer")
      const consumerContract = consumerFactory.attach(contractAddr)
  
      // Get requestConfig from the specified config file
      const requestConfig = require(path.isAbsolute(taskArgs.configpath)
        ? taskArgs.configpath
        : path.join(process.cwd(), taskArgs.configpath))
  
      // Simulate the request
      if (taskArgs.simulate) {
        const { responseBytesHexstring, errorString } = await simulateScript(requestConfig)
        if (responseBytesHexstring) {
          console.log(
            `\nResponse returned by script during local simulation: ${decodeResult(
              responseBytesHexstring,
              requestConfig.expectedReturnType
            ).toString()}\n`
          )
          await consumerContract.swapExactInputSingle();
  
        }
        if (errorString) {
          console.log(`\nError returned by simulated script:\n${errorString}\n`)
        }
  
        console.log("Local simulation of source code completed...")
      }
  
    })
  