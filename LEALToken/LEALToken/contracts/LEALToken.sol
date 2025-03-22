// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LEALToken {
    //Variables del token
    string public name = "LEAL";
    string public symbol = "ALL";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;
    bool public paused = false;
    uint256 public transactionFee = 1; // Tarifa del 1%
    address public feeRecipient;
    
    // Mapeo de balances
    mapping(address => uint256) public balanceOf; //Guarda el saldo de tokens de cada dirección.
    mapping(address => mapping(address => uint256)) public allowance; //Define cuántos tokens puede gastar una dirección en nombre de otra (para approve y transferFrom).
    mapping(address => bool) public blacklisted;

    // Eventos
    event Transfer(address indexed from, address indexed to, uint256 value); //Se emite cuando un usuario transfiere tokens.
    event Approval(address indexed owner, address indexed spender, uint256 value); //Se emite cuando un usuario aprueba a otro para gastar sus tokens.
    event Mint(address indexed to, uint256 value); //Se emite cuando se crean nuevos tokens.
    event Burn(address indexed from, uint256 value); // Se emite cuando se destruyen tokens.
    event Paused(bool state); //Se emite cuando se pausan el token.
    event Blacklisted(address indexed user, bool state); //Se emite cuando se bloquea a un usuario.
    event FeeChanged(uint256 newFee); //Se emite cuando se hace un cambio en la tasa or transferencia.

    // Constructor para asignar el suministro inicial y definir el owner
    constructor(uint256 _initialSupply, address _feeRecipient) {
        require(_feeRecipient != address(0), "Direccion de destinatario de tarifa invalida");

        owner = msg.sender;
        feeRecipient = _feeRecipient;
        totalSupply = _initialSupply * 10 ** uint256(decimals);//Simula una "creación" de tokens desde la dirección 0x0 (el vacío) hacia el creador.
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    
    }

    
    // Modificador para restringir acceso solo al propietario(owner)
    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el owner puede ejecutar esta funcion");
        _;
    }
    // Modificador para indicar si esta pausado
    modifier whenNotPaused() {
        require(!paused, "Las transferencias estan pausadas");
        _;
    }
    
    // Modificador para indicar si no esta en la lista negra
    modifier notBlacklisted(address _account) {
        require(!blacklisted[_account], "Cuenta en lista negra");
        _;
    }

    // Función para pausar transferencias
    function setPaused(bool _state) public onlyOwner {
        paused = _state;
        emit Paused(_state);
    }
    
    // Función para agregar o quitar de la lista negra
    function setBlacklist(address _user, bool _state) public onlyOwner {
        require(_user != address(0), "Direccion invalida");

        blacklisted[_user] = _state;
        emit Blacklisted(_user, _state);
    }
    
    // Función de transferencia con tarifa y validaciones
    function transfer(address _to, uint256 _value) public whenNotPaused notBlacklisted(msg.sender) notBlacklisted(_to) returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Saldo insuficiente");
        require(_to != address(0), "Direccion de destino invalida");

        uint256 fee = (_value * transactionFee) / 100;
        uint256 amountToSend = _value - fee;
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += amountToSend;
        balanceOf[feeRecipient] += fee;
        
        emit Transfer(msg.sender, _to, amountToSend);
        emit Transfer(msg.sender, feeRecipient, fee);
        return true;
    }
    
    // Función para cambiar la tarifa
    function setTransactionFee(uint256 _newFee) public onlyOwner {
        require(_newFee <= 10, "Tarifa no puede superar el 10%");
        transactionFee = _newFee;
        emit FeeChanged(_newFee);
    }
    
    // Aprobar a otra dirección para gastar tokens
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Direccion invalida");

        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    // Transferencia desde otra cuenta permitida
    function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused notBlacklisted(_from) notBlacklisted(_to) returns (bool success) {
        require(balanceOf[_from] >= _value, "Saldo insuficiente");
        require(allowance[_from][msg.sender] >= _value, "No autorizado");
        require(_to != address(0), "Direccion de destino invalida");
        require(_value > 0, "Valor debe ser mayor que cero");

        uint256 fee = (_value * transactionFee) / 100;
        uint256 amountToSend = _value - fee;
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += amountToSend;
        balanceOf[feeRecipient] += fee;
        allowance[_from][msg.sender] -= _value;
        
        emit Transfer(_from, _to, amountToSend);
        emit Transfer(_from, feeRecipient, fee);
        return true;
    }
    
    // Función para mintear tokens (solo owner)
    function mint(address _to, uint256 _value) public onlyOwner {
        totalSupply += _value;
        balanceOf[_to] += _value;
        emit Mint(_to, _value);
        emit Transfer(address(0), _to, _value);
    }
    
    // Función para quemar tokens (solo owner)
    function burn(uint256 _value) public onlyOwner {
        require(balanceOf[msg.sender] >= _value, "Saldo insuficiente");
        require(_value > 0, "Valor debe ser mayor que cero");

        totalSupply -= _value;
        balanceOf[msg.sender] -= _value;
        emit Burn(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }
}
