// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@opengsn/contracts/src/ERC2771Recipient.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @title LaunchPool token smart-contract
 * @author Mihail Ceban, Syndika
 * @notice Upgradeable smart-contract built on the basis of @openzeppelin extensions with [GSN](https://opengsn.org/) support
 */
contract LaunchPoolToken is
    Initializable,
    OwnableUpgradeable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    ERC20PermitUpgradeable,
    ERC20VotesUpgradeable,
    ERC20PausableUpgradeable,
    ERC2771Recipient
{

    /**
     * This ensures that the contract is automatically locked when deployed,
     * preventing its use before initialization and safeguarding against unauthorized takeovers.
     */
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }
    
    /**
     * @notice The initialization function which replaces constructor (See upgradeable [docs](https://docs.openzeppelin.com/upgrades-plugins/1.x/))
     * @param name_ ERC20 token name
     * @param symbol_ ERC20 token symbol
     * @param initialSupply_ Initial supply of tokens minted to treasury
     * @param treasury_ Address which receives initial supply of tokens
     * @param owner_ Address which can upgrade smart-contract and call pause(), unpause() functions
     */
    function initialize(
        string memory name_,
        string memory symbol_,
        uint initialSupply_,
        address treasury_,
        address owner_
    ) public initializer {
        require(
            // owner_ != address(0) check is done in OwnableUpgradeable
            owner_ != 0x000000000000000000000000000000000000dEaD,
            "Invalid owner address"
        );
        require(
            // treasury_ != address(0) check is done in _mint()
            treasury_ != 0x000000000000000000000000000000000000dEaD,
            "Invalid treasury address"
        );

        // Initialize inherited plugins
        __ERC20_init(name_, symbol_);
        __ERC20Permit_init(name_);
        __ERC20Pausable_init();
        __Ownable_init(owner_);
        __ERC20Burnable_init();
        __ERC20Votes_init();

        // Mint initial supply
        _mint(treasury_, initialSupply_);
    }

    /**
     * @notice Overrides the function from inherited smart-contracts: `ContextUpgradeable`, `ERC2771Recipient`
     * @dev The requirement from the ERC2771Recipient, see [gsn docs](https://docs.opengsn.org/contracts/#receiving-a-relayed-call)
     */
    function _msgSender()
        internal
        view
        virtual
        override(ContextUpgradeable, ERC2771Recipient)
        returns (address)
    {
        return super._msgSender();
    }

    /**
     * @notice Overrides the function from inherited smart-contracts: `ContextUpgradeable`, `ERC2771Recipient`
     * @dev The requirement from the ERC2771Recipient, see [gsn docs](https://docs.opengsn.org/contracts/#receiving-a-relayed-call)
     */
    function _msgData()
        internal
        view
        virtual
        override(ContextUpgradeable, ERC2771Recipient)
        returns (bytes calldata)
    {
        return super._msgData();
    }

    /**
     * @dev Overrides IERC6372 functions to make the token & governor timestamp-based
     */
    function clock() public view override returns (uint48) {
        return uint48(block.timestamp);
    }

    /**
     * @dev Overrides IERC6372 functions to make the token & governor timestamp-based
     */
    // solhint-disable-next-line func-name-mixedcase
    function CLOCK_MODE() public pure override returns (string memory) {
        return "mode=timestamp";
    }

    /**
     * @notice Overrides the function from inherited smart-contracts: `ERC20Upgradeable`, `ERC20VotesUpgradeable`, `ERC20PausableUpgradeable`
     * @dev See {ERC20-_update}, {ERC20Votes-_update}, {ERC20Pausable-_update}
     */
    function _update(
        address _from,
        address _to,
        uint256 _value
    )
        internal
        virtual
        override(
            ERC20Upgradeable,
            ERC20VotesUpgradeable,
            ERC20PausableUpgradeable
        )
    {
        super._update(_from, _to, _value);
    }

    /**
     * @notice Overrides the function from inherited smart-contracts: `ERC20PermitUpgradeable`, `NoncesUpgradeable`
     * @dev See {ERC20Permit-nonces}, {Nonces-nonces}
     */
    function nonces(
        address _owner
    )
        public
        view
        virtual
        override(ERC20PermitUpgradeable, NoncesUpgradeable)
        returns (uint256)
    {
        return super.nonces(_owner);
    }

    /**
     * @notice Pauses token transfers, minting and burning
     * @dev Sender must be the owner
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @notice When paused, unpauses token transfers, minting and burning
     * @dev Sender must be the owner
     */
    function unpause() external onlyOwner {
        _unpause();
    }

    /**
     * @notice Set new trusted forwarder from `ERC2771Recipient`
     * @dev Sender must be the owner
     * @param _forwarder New trusted forwarder
     */
    function setTrustedForwarder(address _forwarder) external onlyOwner {
        require(
            _forwarder != address(0) && 
            _forwarder != 0x000000000000000000000000000000000000dEaD,
            "Invalid forwarder address"
        );
        _setTrustedForwarder(_forwarder);
    }
}
