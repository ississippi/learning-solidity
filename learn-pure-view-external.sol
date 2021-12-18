// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract viewPureConstantModifiers 
{
    function multiply() external pure returns(uint) {
        return 3 * 7;
    }

    uint valuePlus = 7;
    function valuePlusThree() external view returns(uint) {
        return valuePlus + 3;
    }
}



