// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {WalletV1} from "src/WalletV1.sol";
import {WalletV2} from "src/WalletV2.sol";
import {Vm} from "forge-std/Vm.sol";

contract UpgradeWallet is Script {
    function run() external returns (address) {
        address mostRecentlyDeployed = Vm(address(vm)).getDeployment(
            "WalletProxy",
            uint64(block.chainid)
        );

        console.log(
            "Most recently deployed WalletProxy: ",
            mostRecentlyDeployed
        );

        vm.startBroadcast();

        WalletV2 newWallet = new WalletV2(); // implementation

        vm.stopBroadcast();

        address proxy = upgradeWallet(mostRecentlyDeployed, address(newWallet));
        return proxy;
    }

    function upgradeWallet(
        address proxyAddress,
        address newWallet
    ) public returns (address) {
        vm.startBroadcast();

        WalletV1 proxy = WalletV1(proxyAddress);
        proxy.upgradeToAndCall(address(newWallet), "");

        vm.stopBroadcast();

        console.log("WalletProxy upgraded to: ", proxy.version());
        return address(proxy);
    }
}
