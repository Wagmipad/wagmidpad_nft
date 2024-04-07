import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import dotenv from "dotenv";

// Load Environment Variables
// ========================================================
dotenv.config();


const config: HardhatUserConfig = {
  solidity: {
    version:"0.8.20",
    settings: {
      optimizer: {
        enabled: true
      }
    }
  },
  
  networks: {
    // For localhost network
    hardhat: {
      chainId: 1337,
    },
    // NOTE: hardhat viem currently doesn't yet support this method for custom chains through Hardhat config ↴
    berachainTestnet: {
      chainId: parseInt(`${process.env.CHAIN_ID}`),
      url: `${process.env.RPC_URL || ''}`,
      accounts: process.env.WALLET_PRIVATE_KEY
        ? [`${process.env.WALLET_PRIVATE_KEY}`]
        : [],
    }
  },
  // For Contract Verification 
  etherscan: { 
    apiKey: `${process.env.BLOCK_EXPLORER_API_KEY}`, 
    customChains: [ 
      { 
        network: "Berachain Testnet", 
        chainId: parseInt(`${process.env.CHAIN_ID}`), 
        urls: { 
          apiURL: `${process.env.BLOCK_EXPLORER_API_URL}`, 
          browserURL: `${process.env.BLOCK_EXPLORER_URL}` 
        } 
      }, 
    ] 
  },
  sourcify: {
    // Disabled by default
    // Doesn't need an API key
    enabled: false
  }  
};

export default config;
