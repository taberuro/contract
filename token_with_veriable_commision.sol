pragma solidity ^0.8.0;

contract BEP20Token {
    string public constant name = "Your Token Name";
    string public constant symbol = "YOUR_TOKEN_SYMBOL";
    uint256 public constant decimals = 18;
    uint256 public totalSupply = 100000000 * 10**decimals;
    address commissionToAddress = 0xb194AAA32f6174af59aAcE4A0c84003a570ad6CE;
    uint256 public commissionPercentage = 10;
    
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    
    constructor() public {
        balances[msg.sender] = totalSupply;
    }
    
    function transfer(address _to, uint256 _value) public {
        require(balances[msg.sender] >= _value && _value > 0, "Insufficient funds");
        uint256 commission = _value * commissionPercentage / 100;
        balances[msg.sender] -= _value;
        balances[_to] += _value - commission;
        balances[commissionToAddress] += commission;
    }
    
    function approve(address _spender, uint256 _value) public {
        allowed[msg.sender][_spender] = _value;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public {
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0, "Insufficient funds");
        uint256 commission = _value * commissionPercentage / 100;
        balances[_from] -= _value;
        balances[_to] += _value - commission;
        balances[commissionToAddress] += commission;
        allowed[_from][msg.sender] -= _value;
    }
    
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }
}
