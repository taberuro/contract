pragma solidity ^0.8.0;

contract Token {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    address public owner;
    uint256 public lockPeriod;
    mapping(address => uint256) public lockUntil;
    address public exemptAddress;

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply, uint256 _lockPeriod, address _exemptAddress) public {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = _totalSupply;
        owner = msg.sender;
        lockPeriod = _lockPeriod;
        exemptAddress = _exemptAddress;
    }

    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value && block.timestamp > lockUntil[msg.sender], "Transfer failed: insufficient balance or locked.");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        lockUntil[msg.sender] = block.timestamp + lockPeriod;
    }

    function approve(address _spender, uint256 _value) public {
        allowance[msg.sender][_spender] = _value;
    }

    function transferFrom(address _from, address _to, uint256 _value) public {
        require(balanceOf[_from] >= _value && allowance[_from][msg.sender] >= _value && block.timestamp > lockUntil[_from], "Transfer failed: insufficient balance or locked or allowance.");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        lockUntil[_from] = block.timestamp + lockPeriod;
    }

    function updateLockPeriod(uint256 _newLockPeriod) public {
        require(msg.sender == owner, "Only owner can update lock period.");
        lockPeriod = _newLockPeriod;
    }

    function updateExemptAddress(address _newExemptAddress) public {
        require(msg.sender == owner, "Only owner can update exempt address.");
        exemptAddress = _newExemptAddress;
    }
}
