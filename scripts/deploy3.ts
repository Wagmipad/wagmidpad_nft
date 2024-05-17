// Imports
// ========================================================
import hre from "hardhat";

// Main Deployment Script
// ========================================================
async function main() {
  const contract = await hre.viem.deployContract("WagmiPadTicket3", ["0x7D4a82306Eb4de7C7B1D686AFC56b1E7999ba7F9"]);
  console.log(`WagmiPadTicket3 deployed to ${contract.address}`);
}

// Init
// ========================================================
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});