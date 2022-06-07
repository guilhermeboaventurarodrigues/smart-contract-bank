// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank{

    //Properties
    address public owner;
    mapping(address => uint) private addressToBalance;

    //Modifiers
    modifier isOwner(){
        require(msg.sender == owner, "Not owner");
        _;
    } 

    //Events
    event BalanceAdd(address target, uint balance);
    event Transfer(address from, address to, uint value);

    //Constructor
    constructor(){
        owner = msg.sender;
    }

    //Public functions
    function addBalance(address wallet, uint value) public isOwner {
        addressToBalance[address(wallet)] += value;
        emit BalanceAdd(wallet, value);
    }

    function transfer(address receiver, uint value) public{
        addressToBalance[msg.sender] -= value;
        addressToBalance[receiver] += value;
        emit Transfer(msg.sender, receiver, value);
    }

    function balanceOf() public view returns(uint){
        return addressToBalance[msg.sender];
    }

    //Kill function
    function kill() public isOwner{
        selfdestruct(payable(owner));
    }
}