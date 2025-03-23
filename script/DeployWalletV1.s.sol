// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {WalletV1} from "src/WalletV1.sol";
import {WalletProxy} from "src/WalletProxy.sol";

contract DeployWalletV1 is Script {
    function deployWallet() public returns (address) {
        vm.startBroadcast();

        WalletV1 wallet = new WalletV1(); // implementation
        WalletProxy proxy = new WalletProxy(address(wallet), ""); // proxy

        vm.stopBroadcast();

        return address(proxy);
    }

    function run() external returns (address) {
        address proxy = deployWallet();

        console.log("WalletProxy deployed at: ", proxy);

        return proxy;
    }
}
