// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AdministraUsuarios{

    mapping (address => string) private listaUsuarios;
    
    function registrar (string memory nombre, address usuario) public{
        listaUsuarios[usuario] = nombre;
    }

    function consultar(address usuario) public view returns(string memory) {
        return listaUsuarios[usuario];
    }

    function borrar(address usuario) public{
        delete listaUsuarios[usuario];
    }
}