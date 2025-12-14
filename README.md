# EtherWallet - Contrato Inteligente para Sepolia.

![Solidity](https://img.shields.io/badge/Solidity-%5E0.8.20-363636?style=flat-square&logo=solidity) ![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square) ![Status](https://img.shields.io/badge/Status-Production%20Ready-green?style=flat-square)

## I. Descripción.

Contrato inteligente simple en Solidity que permite recibir y enviar Ether en la red de prueba Sepolia. Configurado para usar Hardhat con TypeScript.

### Despliegue de mi contrato inteligente:

Address: **0xf3861969D9E49b9AD60875b3f43eec32ce87C789**

Etherscan: **https://sepolia.etherscan.io/address/0xf3861969D9E49b9AD60875b3f43eec32ce87C789#code**

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/21-Verificación.png)

## II. Características.

### Funciones Principales:

1. **Recibir Ether**
   - `receive()`: Función automática que acepta Ether enviado directamente al contrato
   - `deposit()`: Función explícita para depositar Ether
2. **Enviar Ether** (Solo propietario)
   - `sendEther(address, amount)`: Envía una cantidad específica de Ether a una dirección
3. **Gestión de Fondos** (Solo propietario)
   - `withdrawAll()`: Retira todo el balance del contrato
   - `getBalance()`: Consulta el balance actual del contrato
4. **Administración**
   - `transferOwnership(address)`: Transfiere la propiedad del contrato

## III. Requisitos Previos.

1. **Entorno de ejecución Node.js:** Se debe tener instalado el entorno de ejecución Node JS por lo menos en su versión 18, se recomienda que si se vaa instalar por primera ves instalar la versión **LTS** vigente para el momento.

   

   En la imagen se muestra los comandos de instalación en Linux, en mi caso Debian 13, los cuales deberan ser ejecutados mediante el uso de la terminal.

   ![](assets/01-nodejs.png](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/01-nodejs.png)

   

2. **MetaMask**: Extensión instalada como extensión de tu navegador.

   ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/02-Metamask.png))

3. **ETH de Sepolia** se debe contar con cierta cantidad mínima de Ether de sepolia.

   : Consigue ETH de prueba en:

   - [Sepolia Faucet de Alchemy](https://sepoliafaucet.com/)

   - [Sepolia Faucet de Infura](https://www.infura.io/faucet/sepolia)

   - [Sepolia POW Faucet](https://sepolia-faucet.pk910.de/)

     ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/03-Metamask.png)

4. **Infura API Key**: Regístrate gratis en [Infura.io](https://infura.io/)

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/04-Infura.png)



## IV. Despliegue de un Contrato Inteligente en la Red  Sepolia.

### Opción 1: Usando Remix IDE (Más simple para principiantes)

1. Ve a [Remix IDE](https://remix.ethereum.org/)
   - Crea un nuevo archivo llamado `EtherWallet.sol` 
   - Copia y pega el código del contrato.
   
2. Compila el contrato:
   - Selecciona el compilador 0.8.x
   - Click en "Compile EtherWallet.sol"
   
3. Despliega:
   - Ve a la pestaña "Deploy & Run Transactions"
   
   - Selecciona "Injected Provider - MetaMask"
   
   - Asegúrate de estar conectado a Sepolia en MetaMask
   
   - Click en "Deploy"
   
   - Confirma la transacción en MetaMask
   
     ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/05-Remix.png)

### Opción 2: Creando un Proyecto usando Hardhat con TypeScript

#### Paso-01: Instalación del Framework de desarrollo Hardhat

1. Primeramente desde la terminal, o desde el administrador de archivos, se crea el directorio del proyecto.

```bash
# Desde la terminal crea la carpeta del proyecto
$ mkdir etherwallet-tarea-01
```

2. Mediante el siguiente comando en la terminal se procede a ingresar dentro del directorio recién creado.

```bash
# Ingresa a la carpeta
$ cd etherwallet-tarea-01
```

3. Se instala el entorno de desarrollo **HardHat** en su versión 2 el cual nos permitirá: **compilar, implementar, probar y depurar software basado en la blockchain de Ethereum**, de forma local específicamente para este proyecto.

```bash
# Instalación de HardHat V2
$ npm install --save-dev hardhat@hh2
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/06-Entorno-HardHat.png)

4. Se procede a inicializar el entorno y la creación de nuestro proyecto.

```bash
# Inicializa proyecto Hardhat
# Selecciona: "Create a TypeScript project"
$ npx hardhat init
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/07-Entorno-HardHat.png)

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/08-Entorno-HardHat.png)

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/09-Entorno-HardHat.png)

#### Paso-02: Configuración de Variables de Entorno

1. Por medio del comando code . procedemos a abrir el Visual Studio Code para poder ver nuestro proyecto a través de este IDE de desarrollo de una forma mas aceptable a nuestra percepción, pero de igual modo podemos utilizar cualquier otra herramienta de edición de texto para las siguiente operaciones.

```
# abrir VisualStudio Code
$ code .
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/12-code.png)

> [!NOTE]
>
> Debemos tener en cuenta que para abrir correctamente el Visual Studio Code en nuestro proyecto debemos estar ubicados exactamente dentro de su directorio.

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/13-code.png)

2. Mediante el siguiente comando instala el módulo **dotenv** que permite cargar **variables de entorno** desde un archivo `.env` a tu aplicación Node.js. 

```bash
# Instala dependencias adicionales
$ npm install dotenv
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/10-Dotenv.png)

3. Procede a hacer una copia del archivo ejemplo llamado .env.example y renombralo como .env por medio del siguiente comando.

```bash
# Copia y renombra el archivo para variables de entorno
$ cp env.example .env
```

> [!IMPORTANT]
>
> Abre el recién creado archivo `.env` ubicado en la raíz del proyecto y sustituye tus **API_KEYs** respectivas para durante la ejecución del proyecto pueda utilizar las respectivas autorizaciones obtenidas por estas variables de entorno.
>

```bash
# Infura API Key
# Obtén una gratis en: https://infura.io/
INFURA_API_KEY=tu_infura_api_key_aqui

# Clave privada de tu wallet (SIN el prefijo 0x)
# ⚠️ NUNCA compartas esta clave ni la subas a GitHub
PRIVATE_KEY=tu_clave_privada_sin_0x

# Etherscan API Key (para verificar contratos)
# Obtén una gratis en: https://etherscan.io/myapikey
ETHERSCAN_API_KEY=tu_etherscan_api_key_aqui
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/14-env-example.png)

El proyecto deberá tener finalmente esta estructura.

```
etherwallet-project/
├── contracts/
│   └── EtherWallet.sol       # Contrato inteligente
├── scripts/
│   ├── deploy.ts             # Script para desplegar
│   └── interact.ts           # Script para interactuar
├── test/                     # Tests (opcional)
│   ├── EtherWallet.ts        # Script para hacerle pruebas al contrato
├── hardhat.config.ts         # Configuración de Hardhat
├── package.json              # Dependencias y scripts
├── .env                      # Variables de entorno (NO subir a Git)
├── .env.example              # Ejemplo de variables
└── .gitignore
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/11-Capeta_proyecto.png)

> [!TIP]
>
> Cómo obtener tu clave privada de MetaMask

1. Abre MetaMask

   ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/22-Metamask.png)

2. Click en los tres puntos → "Detalles de la cuenta"

   ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/23-Metamask.png)

3. Click en "Exportar clave privada"

   ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/24-Metamask.png)

4. Ingresa tu contraseña

   ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/25-Metamask.png)

5. Copia la clave privada (sin el prefijo 0x para el archivo .env)

   ![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/26-Metamask.png)

> [!IMPORTANT]
>
> Tu clave privada da acceso total a tus fondos. NUNCA la compartas.



#### Paso-03: Configuración de Hardhat (hardhat.config.ts)

> [!IMPORTANT]
>
> Es necesario recordar que el archivo `hardhat.config.ts` (o a veces denominando `hardhat.config.js`) es el **corazón de la configuración** de cualquier proyecto que utilice **Hardhat**, el entorno de desarrollo para Ethereum. Su función principal es decirle a Hardhat cómo debe compilar, implementar, probar y conectar tus contratos inteligentes a diversas redes de blockchain.

Deberá tener por lo menos en el caso de mi proyecto esta estructura.

```typescript
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import "dotenv/config";

const config: HardhatUserConfig = {
  solidity: "0.8.0",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};

export default config;
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/15-Hardhat-config.png)

#### Paso-04: Despliegue el proyecto en la red Sepolia

> [!CAUTION]
>
> Los archivos que componen nuestro proyecto deben estar ubicados en sus respectivos directorios para que no surjan errores durante su compilación o ejecución.

```bash
# Copiar archivos del proyecto
# - EtherWallet.sol → contracts/
# - deploy.ts → scripts/
# - interact.ts → scripts/
# - hardhat.config.ts (reemplazar el existente)
# - env.example → .env.example
```

> [!WARNING]
>
> Se recuerda que los comandos efectuados en la terminal deben ser ejecutados dentro del directorio del proyecto para que puedan surtir el efecto deseado.

> [!TIP]
>
> Previamente, verificar que tienes **ETH** en Sepolia. Usa los faucets mencionados en la sección "Requisitos Previos"

1. Compilación del proyecto por medio del siguiente comando.

```bash
# Compilar el contrato
$ npx hardhat compile
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/16-Compile.png)

2. Realiza test al proyecto.

```bash
# Realiza pruebas al proyecto
$ npx hardhat test
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/17-Test.png)

3. Despliega el contrato en la Red de Sepolia.

```bash
# Despliegue de proyecto en Red Sepolia
$ npx hardhat run scripts/deploy.ts --network sepolia
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/18-Despliegue.png)

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/19-Despliegue.png)

4. Verificacion en Etherscan de Sepolia.

```bash
# Verificar en Etherscan
$ npx hardhat verify --network sepolia 0xf3861969D9E49b9AD60875b3f43eec32ce87C789
```

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/20-Verificación.png)

![](https://raw.githubusercontent.com/miguelmejias0512/etherwallet-tarea-01/refs/heads/main/assets/21-Verificación.png)

## Puntos adicionales

### Seguridad

> [!IMPORTANT]
>
> - ✅ Este es un contrato de ejemplo para propósitos educativos
> - ✅ Solo funciona en la red de prueba Sepolia
> - ✅ El propietario tiene control total sobre los fondos
> - ❌ Nunca compartas tu clave privada
> - ❌ Nunca subas tu archivo .env a GitHub
> - ❌ No uses este contrato en mainnet sin una auditoría de seguridad profesional
>

### Buenas prácticas

> [!TIP]
>
> 1. **Usa .gitignore**: Asegúrate de que `.env` esté en tu .gitignore
> 2. **Variables de entorno**: Nunca hardcodees claves privadas en el código
> 3. **Pruebas**: Siempre prueba en testnet antes de mainnet
> 4. **Auditorías**: Para producción, siempre audita tu código
>



## Material adicional de referencia

- [Documentación de Hardhat](https://hardhat.org/docs)
- [Solidity Docs](https://docs.soliditylang.org/)
- [Sepolia Testnet](https://sepolia.dev/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

## Licencia

MIT License

## Contacto

- **Desarrollador**: Miguel Mejías 
- **Email**: [mmejias.postgrado@gmail.com]
- **GitHub**: [@miguelmejias0512](https://github.com/miguelmejias0512)
- **Twitter**: [@miguelmejias051](https://x.com/miguelmejias051)

## Agradecimientos

- [OpenZeppelin](https://openzeppelin.com/) - Inspiración en patrones de seguridad
- [Ethereum Foundation](https://ethereum.org/) - Documentación y recursos
- [Hardhat](https://hardhat.org/) - Framework de desarrollo.

------

<p align="center">  ⭐ Si este proyecto te fue útil, considera darle una estrella en GitHub, hecho con ❤️ para la comunidad blockchain. </p> <p align="center">   <a href="#-contrato-de-subasta---smart-contract">⬆️ Volver arriba</a> </p>


​				  
