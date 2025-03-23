// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {WalletProxy} from "src/WalletProxy.sol";
import {WalletV1} from "src/WalletV1.sol";
import {WalletV2} from "src/WalletV2.sol";
import {DeployWalletV1} from "script/DeployWalletV1.s.sol";
import {UpgradeWallet} from "script/UpgradeWallet.s.sol";

contract WalletProxyTest is Test {
    DeployWalletV1 deployWalletV1;
    UpgradeWallet upgradeWallet;

    address public walletProxy;

    function setUp() public {
        deployWalletV1 = new DeployWalletV1();
        upgradeWallet = new UpgradeWallet();

        walletProxy = deployWalletV1.run(); // For now, it points to WalletV1
    }

    function testProxyWorks() public {
        WalletV1 wallet = WalletV1(walletProxy);
        assertEq(wallet.version(), "V1");

        WalletV2 newWallet = new WalletV2();
        upgradeWallet.upgradeWallet(walletProxy, address(newWallet));

        assertEq(wallet.version(), "V2");
    }
}
