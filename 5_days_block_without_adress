// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenLock {
    string public name = "MyToken";
    string public symbol = "MTK";
    uint256 public totalSupply;
    uint256 public lockPeriod = 5 days;
    mapping (address => uint256) public lockedTokens;
    mapping (address => uint256) public lockEndTime;

    function lock(uint256 _tokens) public {
        require(_tokens <= totalSupply, "Supply limit reached");
        lockedTokens[msg.sender] = _tokens;
        lockEndTime[msg.sender] = block.timestamp + lockPeriod;
    }

    function release() public {
        require(block.timestamp >= lockEndTime[msg.sender], "Lock period has not ended");
        // Perform token release logic here
        // Remove the locked tokens for the user
        lockedTokens[msg.sender] = 0;
        lockEndTime[msg.sender] = 0;
    }

    function checkStatus() public view returns (uint256, uint256) {
        return (lockedTokens[msg.sender], lockEndTime[msg.sender]);
    }

    function setTotalSupply(uint256 _totalSupply) public {
        totalSupply = _totalSupply;
    }
}
