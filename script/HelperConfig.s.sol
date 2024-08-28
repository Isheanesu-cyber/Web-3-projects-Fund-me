// Deploy mocks when we are on local anvil chain
// Keep track of contract addresses across different chains 
// Sepolia ETH/USD
// Mainnet ETH/USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/Mocks/MockV3Aggregator.sol";

contract HelperConfig is Script{
    NetworkConfig public activeNetworkConfig;
    struct NetworkConfig{
        address PriceFeed;
    }
    constructor(){
        if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaETHConfig();
        }else if(block.chainid == 1){
            activeNetworkConfig = getmainnetETHConfig();
        }else{
            activeNetworkConfig = getCreateanvilETHConfig();
        }
    }

    function getSepoliaETHConfig() public pure returns (NetworkConfig memory){
        NetworkConfig memory sepoliaConfig = NetworkConfig({PriceFeed:0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }
        function getmainnetETHConfig() public pure returns (NetworkConfig memory){
        NetworkConfig memory ethConfig = NetworkConfig({PriceFeed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return ethConfig;
    }

    function getCreateanvilETHConfig() public returns (NetworkConfig memory){
        if(activeNetworkConfig.PriceFeed != address(0)){
            return activeNetworkConfig;
        }
        // 1. Deploy mocks
        // 2. Return the mock address
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(8,2000e8);
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig({PriceFeed:address(mockPriceFeed)});
        return anvilConfig;

    }
}