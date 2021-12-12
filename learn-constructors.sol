// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Member 
{
    string name;
    uint age;
    constructor(string memory _name, uint _age) public {
        name = _name;
        age = _age;
    }
}

contract Teacher is Member // ('Rachel', 28) 
{

    constructor(string memory n, uint a) Member(n, a) public {}
    function getName() public view returns (string memory) {
        return name;
    }
}

contract Base 
{
    uint intData;
    constructor(uint _i) public {
        intData = _i;
    }
    function getData() public view returns (uint) {
        return intData;
    }
}

contract Derived is Base(5)
{
    //constructor() Base(5) public {}

    function getDerivedData() public view returns (uint) {
        return intData;
    }
}