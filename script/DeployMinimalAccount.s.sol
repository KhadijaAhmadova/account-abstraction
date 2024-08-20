// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {MinimalAccount} from "src/ethereum/MinimalAccount.sol";

contract DeployMinimalAccount is Script {
    function run() public returns (HelperConfig, MinimalAccount) {
        return deployMinimalAccount();
    }

    function deployMinimalAccount() public returns (HelperConfig, MinimalAccount) {
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        vm.startBroadcast(config.account);
        MinimalAccount account = new MinimalAccount(config.entryPoint);
        account.transferOwnership(config.account);
        vm.stopBroadcast();
        return (helperConfig, account);
    }
}
