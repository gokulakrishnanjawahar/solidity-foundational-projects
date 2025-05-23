//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

// token vesting is mechanism that is used in blockchain to release the crypto tokens gradually over a period of 
// time instead of distributing it at a time.

contract tokenvesting{
    address public beneficiary;
    uint public start;
    uint public duration;
    uint public totalamt;
    uint public claimed;

    constructor(address _beneficiary,uint _totalamt){
        beneficiary=_beneficiary;
        totalamt=_totalamt;
        start=block.timestamp;
    
    }

    function vestedamt() public view returns (uint){
        if(block.timestamp<start) return 0;
        if(block.timestamp>=start+duration) return totalamt;

        return totalamt*(block.timestamp-start)/duration;

    }

    function claim() external{
        require(msg.sender==beneficiary,"You are not the beneficiary");
        uint vestedamount=vestedamt();
        uint unreleased=vestedamount-claimed;
        claimed+=unreleased;

        payable(beneficiary).transfer(unreleased);
    }
}