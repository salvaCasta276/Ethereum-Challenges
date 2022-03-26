// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

contract ForceSol{
    address payable public targetContract;
    constructor (address payable _targetContract){
        targetContract = _targetContract;
    }

    function sendEth() payable public {
        targetContract.transfer(msg.value);
    }
}

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}