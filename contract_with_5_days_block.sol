pragma solidity ^0.8.0;

contract LockableToken {
uint256 public lockPeriod = 5 days; // Lock period for 5 days
address public exemptAddress; // Exempt address that is not subject to blocking

mapping (address => uint256) public lockUntil; // Store the lock end time for each address
mapping (address => uint256) public balanceOf; // Store the balance of each address
string public name; // Store the name of the token
string public symbol; // Store the ticker of the token
uint256 public totalSupply; // Store the total supply of the token

// Constructor to initialize the contract
constructor(uint256 _totalSupply, string memory _name, string memory _symbol, address _exemptAddress) public {
    totalSupply = _totalSupply;
    balanceOf[msg.sender] = _totalSupply;
    name = _name;
    symbol = _symbol;
    exemptAddress = _exemptAddress;
}

// Transfer token from one address to another
function transfer(address _to, uint256 _value) public {
    // Check if the sender is not exempt from the lock and the lock has not expired
    if (msg.sender != exemptAddress && block.timestamp < lockUntil[msg.sender]) {
        revert("Transaction failed: Token transfer is temporarily locked.");
    }
    require(balanceOf[msg.sender] >= _value, "Transaction failed: Insufficient balance.");
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    lockUntil[msg.sender] = block.timestamp + lockPeriod;
}

// Get the balance of an address
function getBalance(address _address) public view returns (uint256) {
    return balanceOf[_address];
}
}
