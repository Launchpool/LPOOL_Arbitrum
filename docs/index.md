# Solidity API

## LaunchPoolToken

Upgradeable smart-contract built on the basis of @openzeppelin extensions with [GSN](https://opengsn.org/) support

### constructor

```solidity
constructor() public
```

### initialize

```solidity
function initialize(string name_, string symbol_, uint256 initialSupply_, address treasury_, address owner_) public
```

The initialization function which replaces constructor (See upgradeable [docs](https://docs.openzeppelin.com/upgrades-plugins/1.x/))

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| name_ | string | ERC20 token name |
| symbol_ | string | ERC20 token symbol |
| initialSupply_ | uint256 | Initial supply of tokens minted to treasury |
| treasury_ | address | Address which receives initial supply of tokens |
| owner_ | address | Address which can upgrade smart-contract and call pause(), unpause() functions |

### _msgSender

```solidity
function _msgSender() internal view virtual returns (address)
```

Overrides the function from inherited smart-contracts: `ContextUpgradeable`, `ERC2771Recipient`

_The requirement from the ERC2771Recipient, see [gsn docs](https://docs.opengsn.org/contracts/#receiving-a-relayed-call)_

### _msgData

```solidity
function _msgData() internal view virtual returns (bytes)
```

Overrides the function from inherited smart-contracts: `ContextUpgradeable`, `ERC2771Recipient`

_The requirement from the ERC2771Recipient, see [gsn docs](https://docs.opengsn.org/contracts/#receiving-a-relayed-call)_

### clock

```solidity
function clock() public view returns (uint48)
```

_Overrides IERC6372 functions to make the token & governor timestamp-based_

### CLOCK_MODE

```solidity
function CLOCK_MODE() public pure returns (string)
```

_Overrides IERC6372 functions to make the token & governor timestamp-based_

### _update

```solidity
function _update(address _from, address _to, uint256 _value) internal virtual
```

Overrides the function from inherited smart-contracts: `ERC20Upgradeable`, `ERC20VotesUpgradeable`, `ERC20PausableUpgradeable`

_See {ERC20-_update}, {ERC20Votes-_update}, {ERC20Pausable-_update}_

### nonces

```solidity
function nonces(address _owner) public view virtual returns (uint256)
```

Overrides the function from inherited smart-contracts: `ERC20PermitUpgradeable`, `NoncesUpgradeable`

_See {ERC20Permit-nonces}, {Nonces-nonces}_

### pause

```solidity
function pause() external
```

Pauses token transfers, minting and burning

_Sender must be the owner_

### unpause

```solidity
function unpause() external
```

When paused, unpauses token transfers, minting and burning

_Sender must be the owner_

### setTrustedForwarder

```solidity
function setTrustedForwarder(address _forwarder) external
```

Set new trusted forwarder from `ERC2771Recipient`

_Sender must be the owner_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _forwarder | address | New trusted forwarder |

