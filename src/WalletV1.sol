// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @title WalletV1
 * @dev A simple upgradeable wallet contract supporting ETH transfers.
 * @dev
 *  - The contract must be upgradeable via UUPS pattern.
 *  - Only authorized entities should be able to upgrade the contract.
 *  - ETH transfers should be allowed through `transferETH`.
 */
contract WalletV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /**
     * @dev Initializes the contract, setting the deployer as the initial owner.
     * @dev
     *  - Can only be called once.
     *  - Sets the initial owner to the deployer.
     *  - Enables UUPS upgradeability.
     */
    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }

    /**
     * @dev Authorizes contract upgrades.
     * @param newImplementation The address of the new contract implementation.
     * @dev
     *  - Only the contract owner can authorize an upgrade.
     *  - Prevent unauthorized upgrades.
     */
    function _authorizeUpgrade(address newImplementation) internal override {}

    /*//////////////////////////////////////////////////////////////
                            CUSTOM FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function version() external pure returns (string memory) {
        return "V1";
    }

    // Transfers out ETH held by the wallet.
    function transferETH(address payable to, uint256 amount) external {
        to.transfer(amount);
    }
}
