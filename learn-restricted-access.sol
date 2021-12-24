// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;


modifier onlyBy(address _account) {
    require(msg.sender = _account),
    'Sender not authorized'
    _;
}

modifier onlyBy {
contract RestrictedAccess   {
    address public owner = msg.sender;
    uint public creationTime = block.timestamp;

    //write a function which will change the owner address
    function changeOwnerAddress(address _newOwner) external 
    {
        require(msg.sender = owner);
        owner = _newOwner;
    }
}