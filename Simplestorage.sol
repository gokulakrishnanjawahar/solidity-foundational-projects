//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract store{
    uint public value; 

    function setvalue(uint _value) public{
        value=_value;
    }

    function getvalue() public view returns(uint){
            return value;
    }
}
