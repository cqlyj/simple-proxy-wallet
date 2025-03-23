// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/**
 * @title WalletV2
 * @dev An upgradeable wallet contract supporting ERC20 token transfers.
 * @dev
 *  - The contract must be upgradeable via UUPS pattern.
 *  - Only authorized entities should be able to upgrade the contract.
 *  - ERC20 token transfers should be allowed through `transferERC20`.
 */
contract WalletV2 is UUPSUpgradeable {
    function _authorizeUpgrade(address newImplementation) internal override {}

    /*//////////////////////////////////////////////////////////////
                            CUSTOM FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function version() external pure returns (string memory) {
        return "V2";
    }

    // Transfers out ERC20s held by the wallet.
    function transferERC20(IERC20 token, address to, uint256 amount) external {
        token.transfer(to, amount);
    }
}
