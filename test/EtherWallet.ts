import { ethers } from "hardhat";

async function main() {
  console.log("Iniciando despliegue del contrato EtherWallet...");
  console.log("=".repeat(50));

  // Obtener la cuenta que desplegará el contrato
  const [deployer] = await ethers.getSigners();
  
  console.log("Desplegando contrato con la cuenta:", deployer.address);
  
  // Obtener el balance del deployer
  const balance = await ethers.provider.getBalance(deployer.address);
  console.log("Balance de la cuenta:", ethers.formatEther(balance), "ETH");
  console.log("=".repeat(50));

  // Obtener la fábrica del contrato
  const EtherWallet = await ethers.getContractFactory("EtherWallet");
  
  // Desplegar el contrato
  console.log("\nDesplegando EtherWallet...");
  const etherWallet = await EtherWallet.deploy();
  
  // Esperar a que se complete el despliegue
  await etherWallet.waitForDeployment();
  
  const contractAddress = await etherWallet.getAddress();
  
  console.log("✅ EtherWallet desplegado exitosamente!");
  console.log("=".repeat(50));
  console.log("📋 Información del contrato:");
  console.log("=".repeat(50));
  console.log("Dirección del contrato:", contractAddress);
  console.log("Owner del contrato:", deployer.address);
  console.log("Red:", (await ethers.provider.getNetwork()).name);
  console.log("Chain ID:", (await ethers.provider.getNetwork()).chainId);
  console.log("=".repeat(50));

  // Verificar que el owner se estableció correctamente
  const owner = await etherWallet.owner();
  console.log("\n🔍 Verificación:");
  console.log("Owner registrado en el contrato:", owner);
  console.log("¿Owner correcto?:", owner === deployer.address ? "✅ Sí" : "❌ No");
  
  // Obtener el balance inicial del contrato
  const contractBalance = await etherWallet.getBalance();
  console.log("Balance inicial del contrato:", ethers.formatEther(contractBalance), "ETH");
  console.log("=".repeat(50));

  // Guardar información del despliegue en un objeto
  const deploymentInfo = {
    contractAddress: contractAddress,
    owner: deployer.address,
    network: (await ethers.provider.getNetwork()).name,
    chainId: (await ethers.provider.getNetwork()).chainId.toString(),
    deploymentBlock: await ethers.provider.getBlockNumber(),
    timestamp: new Date().toISOString()
  };

  console.log("\n📝 Información completa del despliegue:");
  console.log(JSON.stringify(deploymentInfo, null, 2));
  console.log("=".repeat(50));

  // Instrucciones para verificación
  console.log("\n📌 Para verificar el contrato en Etherscan:");
  console.log(`npx hardhat verify --network <network-name> ${contractAddress}`);
  console.log("=".repeat(50));

  console.log("\n🎉 Despliegue completado exitosamente!");
  
  return deploymentInfo;
}

// Ejecutar el script de despliegue
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("\n❌ Error durante el despliegue:");
    console.error(error);
    process.exit(1);
  });