async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());
  const MultiTokenERC721 = await ethers.getContractFactory("MultiTokenERC721");
  const multiToken = await MultiTokenERC721.deploy();
  console.log("deployed at address", multiToken.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
