//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

// Multi Signature Wallet requires more than one private key to approve a transaction.

// This allows a shared ownership to manage funds collectively.

contract multisig{
    address[] public owners;
    uint public req;

    struct Transaction{
        address to;
        uint amount;
        bool executed;
        uint confirmed;
    }
    mapping (uint=>mapping(address=>bool)) public isconfirmed;

    // uint is for transaction id
    //address is for owners address
    //bool is whether the transaction is confirmed or not

    Transaction[] public transaction;

    modifier onlyowner(){
        bool isowner=false;
        
        for(uint i=0;i<owners.length;i++){
            if(msg.sender==owners[i]) isowner=true;

        }
        require(isowner,"not owner");
        _;


    }

    function submit_transaction(address _to,uint value) public onlyowner{
        transaction.push(Transaction({
            to:_to,
            amount:value,
            executed:false,
            confirmed:0
        }));
    }

    function confirm_transaction(uint _tadd) public onlyowner{
        require(!transaction[_tadd].executed,"Already Executed");
        require(!isconfirmed[_tadd][msg.sender],"Already Confirmed");

        isconfirmed[_tadd][msg.sender]=true;
        transaction[_tadd].confirmed++;

        if(transaction[_tadd].confirmed>=req){
            executetransaction(_tadd);
        }
    }

    function executetransaction(uint _tadd) internal {
        Transaction storage txn=transaction[_tadd];
        require(!txn.executed,"Transaction already executed");
        require(txn.confirmed>=req, "Not enougth confirmed transactions");

        txn.executed=true;


    }

    receive() external payable {}

}
