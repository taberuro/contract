pragma solidity 0.6.0;

interface iBEP20 {
// Возвращает количество существующих токенов.
  function totalSupply() external view returns (uint256);
// возвращает кол-во знаков после запятой
  function decimals() external view returns (uint8);
// возвращает тикер токена 
  function symbol() external view returns (string memory);
// возвращает имя токена
  function name() external view returns (string memory);
//Возвращает владельца токена bep.
  function getOwner() external view returns (address);
//Возвращает количество токенов, принадлежащих "аккаунту`.
  function balanceOf(address account) external view returns (uint256);
//Перемещает токены "сумма" из учетной записи вызывающего абонента в "получатель". Возвращает логическое значение, указывающее, была ли операция выполнена успешно. Выдает событие {Transfer}.
  function transfer(address recipient, uint256 amount) external returns (bool);
// Возвращает оставшееся количество токенов, которые "покупатель" будет разрешено тратить от имени "владельца" через {перевод с}. Это по умолчанию - ноль.Это значение изменяется при вызове {утвердить} или {передать из}.
  function allowance(address _owner, address spender) external view returns (uint256); 
//  Устанавливает "сумму" в качестве надбавки "покупателю" за токены вызывающего абонента.Возвращает логическое значение, указывающее, была ли операция выполнена успешно.
//  ВАЖНО: Имейте в виду, что изменение надбавки с помощью этого метода сопряжено с риском что кто-то может использовать как старое, так и новое пособие по несчастным упорядочение транзакций. Одно из возможных решений для смягчения этой гонки условие состоит в том, чтобы сначала уменьшить пособие для покупателей до 0 и установить желаемое значение впоследствии:
//  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729 
//  Выдает событие {Утверждение}.
  function approve(address spender, uint256 amount) external returns (bool);
//  Перемещает токены "количество" от "отправителя" к "получателю", используя механизм надбавок. затем "сумма` вычитается из счета вызывающего абонента. 
//  Возвращает логическое значение, указывающее, была ли операция выполнена успешно. Выдает событие {Transfer}.
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
// Выдается, когда токены "value" перемещаются с одной учетной записи ("from") на другой ("кому").
// // Обратите внимание, что "значение" может быть равно нулю.
  event Transfer(address indexed from, address indexed to, uint256 value);
// Выдается, когда надбавка "покупатель" для "владельца" устанавливается. Вызов {утвердить}. "ценность" - это новая надбавка.
  event Approval(address indexed owner, address indexed spender, uint256 value);
}  // замыкается интерфейс 


// Выдается, когда надбавка "покупатель" для "владельца" устанавливается вызов {утвердить}. "ценность" - это новая надбавка.
// Этот контракт требуется только для промежуточных, библиотечных контрактов.
contract Context {
// Пустой внутренний конструктор, чтобы люди не могли ошибочно развернуть экземпляр этого контракта, который следует использовать через наследование.
  constructor () internal { }
  function _msgSender() internal view returns (address payable) {
    return msg.sender;
  }
  function _msgData() internal view returns (bytes memory) {
    this; // предупреждение об изменении состояния тишины без генерации байт-кода - см. https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
}  // замыкается контракт


// Обертывает арифметические операции Solidity с добавлением переполнения проверки. 
library SafeMath {
// Возвращает сложение двух целых чисел без знака, возвращаясь к переполнению. Аналог оператора Solidity `+`. 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {uint256 c = a + b;require(c >= a, "SafeMath: addition overflow");return c;}  
// Возвращает вычитание двух целых чисел без знака, возвращаясь к переполнению (когда результат отрицательный).
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {return sub(a, b, "SafeMath: subtraction overflow");}
// Возвращает вычитание двух целых чисел без знака, возвращаясь с пользовательским сообщением на переполнение (когда результат отрицательный).
  function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b <= a, errorMessage);uint256 c = a - b;return c;}
//  Возвращает умножение двух целых чисел без знака, возвращаясь к переполнение. Аналог оператора Solidity "//". 
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
      // Оптимизация газа: это дешевле, чем требовать, чтобы "a" не было равно нулю, но
      // выгода теряется, если "b" также тестируется.
      // См.: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {return 0;}
    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");
    return c;
  }
// Возвращает целочисленное деление двух целых чисел без знака. Возвращается на деление на ноль. Результат округляется до нуля.
  function div(uint256 a, uint256 b) internal pure returns (uint256) {return div(a, b, "SafeMath: division by zero");}
// Возвращает целочисленное деление двух целых чисел без знака. Возвращается с пользовательским сообщением на деление на ноль. Результат округляется до нуля.
  function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
      // Прочность автоматически утверждается только при делении на 0
    require(b > 0, errorMessage);uint256 c = a / b;return c;// assert(a == b * c + a % b); // Нет случая, когда это не выполняется
    }
// Возвращает остаток от деления двух целых чисел без знака. (целое число без знака по модулю), Возвращается с пользовательским сообщением при делении на ноль.
// // Аналог оператора Solidity `%`. Эта функция использует "возврат" код операции (который оставляет оставшийся газ нетронутым), в то время как Solidity использует неверный код операции для возврата (потребляет весь оставшийся газ).
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {return mod(a, b, "SafeMath: modulo by zero");}
  function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b != 0, errorMessage);return a % b;}
} //завершается использование библиотеки


// Модуль контракта, который обеспечивает базовый механизм контроля доступа, где существует учетная запись (владелец), которой может быть предоставлен эксклюзивный доступ к определенным функциям.
// // По умолчанию учетная запись владельца будет той, которая развертывает контракт. Этот пункт позже может быть изменен с помощью {передача права собственности}.
contract Ownable is Context {
  address private _owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
// Инициализирует контракт, устанавливая разработчика развертывания в качестве первоначального владельца.
  constructor () internal {
    address msgSender = _msgSender();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }
// Возвращает адрес текущего владельца.
  function owner() public view returns (address) {
    return _owner;
  }
//Выдает ошибку, если вызывается любой учетной записью, отличной от владельца.
  modifier onlyOwner() {
    require(_owner == _msgSender(), "Использует не владелец:");
    _;
  }
// Оставляет контракт без владельца. Вызвать контракт будет невозможно ,больше не функционирует метод "только владелец`. Может быть вызван только текущим владельцем.
// // ПРИМЕЧАНИЕ: Отказ от права собственности приведет к тому, что контракт останется без владельца, тем самым удаляя любую функциональность, доступную только владельцу.
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }
// Передает право собственности на контракт новой учетной записи ("Новый владелец"). Может быть вызван только текущим владельцем.
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0), "Ownable: новый владелец - это нулевой адрес");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}

contract BEP20FixedSupply is Context, iBEP20, Ownable {
  using SafeMath for uint256;
  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint256)) private _allowances;
  uint256 private _totalSupply;
  uint8 public _decimals;
  string public _symbol;
  string public _name;
  constructor() public {
    _name = 'EXAMPLE';          // В этой строке задаётся имя токена.
    _symbol = 'EXA';            // В этой строке задаётся тикер токена.
    _decimals = 5;              // В этой строке устанавливется кол-во точек после запятой (установлю стандартное значение, которое использовал в предыдущих работах)
    _totalSupply = 1000000000 ; //В этой строке задаётся кол-во монет, которое будет выпущено
    _balances[msg.sender] = _totalSupply;
    emit Transfer(address(0), msg.sender, _totalSupply);
  }
// Повторно возвращает владельца токена bep.
  function getOwner() external view virtual override returns (address) {return owner();}
//  Возвращает десятичные дроби токена.
  function decimals() external view virtual override returns (uint8) {return _decimals;}
// Возвращает символ токена.
  function symbol() external view virtual override returns (string memory) {return _symbol;}
//  Возвращает имя токена.
  function name() external view virtual override returns (string memory) {return _name;}
// Смотрите {BEP20-общее предложение}.
  function totalSupply() external view virtual override returns (uint256) {return _totalSupply;}
//См. {BEP20-баланс}.
  function balanceOf(address account) external view virtual override returns (uint256) {return _balances[account];}
 //  См. {BEP20-transfer}.
  function transfer(address recipient, uint256 amount) external override returns (bool) {_transfer(_msgSender(), recipient, amount);return true;}
// См. {BEP20-пособие}.
  function allowance(address owner, address spender) external view override returns (uint256) {return _allowances[owner][spender];}
//См. {BEP20-одобрить}.
  function approve(address spender, uint256 amount) external override returns (bool) {_approve(_msgSender(), spender, amount);return true;}
// Выдает событие {Утверждение}, указывающее на обновленную надбавку. Это не требуется в соответствии с EIP. Смотрите примечание в начале {EP 20};
  function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
    _transfer(sender, recipient, amount);
    _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: сумма перевода превышает размер резерва"));
    return true;
  }
// атомарно увеличивает пособие, предоставляемое "покупатель" вызывающим абонентом.Используется для смягчения особеннотсей iBEP20
  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
    return true;
  }
// Атомарно уменьшает пособие, предоставляемое вызывающей стороне "покупатель". Используется для смягчения особеннотсей iBEP20
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "BEP20: уменьшенная надбавка ниже нуля"));
    return true;
  }
// Уничтожает токены "amount" у вызывающего абонента. 
  function burn(uint256 amount) public virtual {_burn(_msgSender(), amount);}
// Уничтожает токены "количество` из "учетной записи", вычитая из вызывающего абонент пособие.
  function burnFrom(address account, uint256 amount) public virtual {
      uint256 decreasedAllowance = _allowances[account][_msgSender()].sub(amount, "BEP20: cжигаемая сумма превышает допустимую норму");
      _approve(account, _msgSender(), decreasedAllowance);
      _burn(account, amount);
  }
//  Перемещает "количество" токенов из "отправителя" в "получателя".
// Эта внутренняя функция эквивалентна {transfer} и может быть использована для например, внедрить автоматическую плату за токены, механизмы сокращения и т.д.

  function _transfer(address sender, address recipient, uint256 amount) internal {
    require(sender != address(0), "BEP20: перевод с нулевого адреса");
    require(recipient != address(0), "BEP20: перевод на нулевой адрес");
    _balances[sender] = _balances[sender].sub(amount, "BEP20: сумма перевода превышает баланс");
    _balances[recipient] = _balances[recipient].add(amount);
    emit Transfer(sender, recipient, amount);
  }
//  Уничтожает токены "количество" из "учетной записи", уменьшая общее предложение.
  function _burn(address account, uint256 amount) internal {
    require(account != address(0), "BEP20: запись с нулевого адреса");
    _balances[account] = _balances[account].sub(amount, "BEP20: сумма сжигания превышает баланс");
    _totalSupply = _totalSupply.sub(amount);
    emit Transfer(account, address(0), amount);
  }
// вызыв функции подтверждения контракта, в случае если оба задействованных аккаунта ненулевые 
  function _approve(address owner, address spender, uint256 amount) internal {
    require(owner != address(0), "BEP20: утвердить с нулевого адреса");
    require(spender != address(0), "BEP20: утвердить по нулевому адресу");
    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }
}
