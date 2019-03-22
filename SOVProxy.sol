pragma solidity 0.5.6;


interface SoundMoneyCoin {

  function mint() external;
  function balanceOf(address addr) external view returns (uint256);
  function transfer(address to, uint256 amount) external returns (bool);
}


contract SOVProxy {

    address payable private owner;
    SoundMoneyCoin SOV = SoundMoneyCoin(0x010589B7c33034b802F7dbA2C88cc9cec0f46673);
    
    constructor() public {
        owner = msg.sender;
    }

    function kill() public {
      require(msg.sender == owner);
      selfdestruct(owner);
    }

    function withdrawTokens() public returns (bool) {
        require(msg.sender == owner);
        
        uint256 balance = SOV.balanceOf(address(this));
        return SOV.transfer(owner, balance);
    }

    function fallback() public {
        SOV.mint();
    }
}
