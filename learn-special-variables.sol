// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract LedgerBalance 
{

    mapping (address => uint) balance;

    function updatesBalance(uint newBalance) public {
        balance[msg.sender] = newBalance;
    }
    
    function getLedgerBalance(address sender) public returns (uint){
        return balance[sender];
    }
}

contract Update 
{
    function updatesBalance() public {
        LedgerBalance ledgerBalance = new LedgerBalance();
        ledgerBalance.updatesBalance(30);
    }

    function getBalance() public returns (uint){
        LedgerBalance ledgerBalance = new LedgerBalance();
        return ledgerBalance.getLedgerBalance(msg.sender);    
    }
}