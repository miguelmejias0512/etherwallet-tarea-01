// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title EtherWallet
 * @dev Contrato simple para recibir y enviar Ether en Sepolia
 */
contract EtherWallet {
    // Dirección del propietario del contrato
    address public owner;
    
    // Evento que se emite cuando se recibe Ether
    event EtherReceived(address indexed sender, uint256 amount);
    
    // Evento que se emite cuando se envía Ether
    event EtherSent(address indexed recipient, uint256 amount);
    
    // Evento que se emite cuando se retira todo el balance
    event Withdrawal(address indexed owner, uint256 amount);
    
    /**
     * @dev Constructor que establece al desplegador como propietario
     */
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * @dev Modificador para restringir funciones solo al propietario
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el propietario puede ejecutar esta funcion");
        _;
    }
    
    /**
     * @dev Función receive para aceptar Ether cuando se envía directamente al contrato
     */
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }
    
    /**
     * @dev Función fallback para aceptar Ether con datos
     */
    fallback() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }
    
    /**
     * @dev Función para depositar Ether explícitamente
     */
    function deposit() external payable {
        require(msg.value > 0, "Debe enviar algo de Ether");
        emit EtherReceived(msg.sender, msg.value);
    }
    
    /**
     * @dev Enviar Ether a una dirección específica (solo propietario)
     * @param _to Dirección del destinatario
     * @param _amount Cantidad de Ether a enviar en wei
     */
    function sendEther(address payable _to, uint256 _amount) external onlyOwner {
        require(_to != address(0), "Direccion invalida");
        require(_amount > 0, "La cantidad debe ser mayor a cero");
        require(address(this).balance >= _amount, "Balance insuficiente en el contrato");
        
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transferencia fallida");
        
        emit EtherSent(_to, _amount);
    }
    
    /**
     * @dev Retirar todo el balance del contrato (solo propietario)
     */
    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No hay fondos para retirar");
        
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Retiro fallido");
        
        emit Withdrawal(owner, balance);
    }
    
    /**
     * @dev Obtener el balance del contrato
     * @return Balance en wei
     */
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * @dev Transferir la propiedad del contrato a una nueva dirección
     * @param _newOwner Dirección del nuevo propietario
     */
    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Nueva direccion invalida");
        owner = _newOwner;
    }
}
