//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract donation_tracker{
    address public owner;
    //uint public fund;
    uint public totaldonations;
    mapping(address=>uint) donations;
    address[] public donors;
    constructor(){
        owner=msg.sender;

    }

    function adddonation() public payable{
        require(msg.value>0,"Donations must be more than 0");
        if(donations[msg.sender]==0){
            donors.push(msg.sender);
        }
        donations[msg.sender]+=msg.value;
        totaldonations+=msg.value;
    }
    function getbalance() public view returns(uint){
        return address(this).balance;
    }
    function withdraw(uint amount) public {
        require(owner==msg.sender,"Only the donor can withdraw his/her funds");
        require(donations[msg.sender]>=amount,"Insufficient balance");
        //donations[msg.sender]-=amount;
        totaldonations-=amount;
        payable(owner).transfer(amount);
    }
    function getalldonors() public view returns(address[] memory){
        return donors;
    }

    function get_total_donation() public view returns(uint){
        return totaldonations;
    }
}