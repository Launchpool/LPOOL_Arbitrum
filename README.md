# Launchpool smart contracts

> Launchpool New Smart-Contracts deployed to Arbitrum.

## LaunchPool token

> The token is assembled as a constructor using industry leader extensions (OpenZeppelin and GSN) ensuring high code quality and security.

### Upgradeable extension

> The token uses the upgrades plugin by @openzeppelin. It provides the feature to extend the functionality in the future and deploy new token under the same address and the same storage without any migration. See [detailed docs](https://docs.openzeppelin.com/upgrades-plugins/1.x/).

### Burnable extension

> The token uses [ERC20Burnable](https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20Burnable) extension by @openzeppelin adding the ability to burn tokens. This feature came from the original smart contract before migration.

### Meta-transactions

> The token uses [ERC20Permit](https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20Permit) extension by @openzeppelin adding the ability to send tokens via signing gasless (meta) transactions. ERC20Permit is the industry standard used by major tokens (e.g. USDC, DAI). Technically it is used to increase the allowance of an account using the [EIP712 offline signature](https://eips.ethereum.org/EIPS/eip-712).

### Votes

> The token uses [ERC20Votes](https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20Votes) extension by @openzeppelin adding voting functionality for token holders. This is a more generic version of Compound voting and delegation that was used in the LaunchPool token before migration. Here is the [article](https://syndika.co/blog/building-on-chain-daos-openzeppelin-and-tally-for-effective-development/) that describes this feature in detail and provides a complete example on how to execute votings and to build the DAO.

### Ownable extension

> The token uses [Ownable](https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20Votes) extension by @openzeppelin introducing the new actor - token owner or admin. The owner can process admin functions:

- Upgrade the smart contract (see Upgradeable extension);
- Pause/unpause token transfers, minting and burning (see Pausable extension);
- Set the new trusted forwarder from `ERC2771Recipient` (see GSN extension).

### Pausable extension

> The token uses [ERC20Pausable](https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20Votes) extension by @openzeppelin adding the pause/unpause functions which forbid token transfers, minting and burning while smart contract is paused. These functions are available only for Owner.

### Gasless transactions via GSN

> The token uses ERC2771Recipient extension by @opengsn which provides the compatibility with GSN architecture. Generally it abstracts the process of paying for gas away from end users which minimizes UX friction for dapps. With GSN, gasless clients can interact with Ethereum smart contracts without users needing ETH for transaction fees. See [detailed docs](https://docs.opengsn.org/#the-problem).
