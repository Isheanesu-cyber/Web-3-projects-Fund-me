// SPDX-License-Identifier: MIT

// FundMe
// Withdraw
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script{
    uint256 constant SEND_VALUE = 0.03 ether;

    function fundFundMe(address MostRecentlydeployed) public{
        vm.startBroadcast();
        FundMe(payable(MostRecentlydeployed)).fund{value:SEND_VALUE}();
        vm.stopBroadcast();
    }
    function run()external{
        address MostRecentlydeployed = DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        fundFundMe(MostRecentlydeployed);
    }
}

contract WithdrawFundMe is Script {

}