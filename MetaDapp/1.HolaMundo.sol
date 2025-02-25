// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HolaMundo{
    
    string private usuario;


    function agregarUsuarioSaludar (string memory _usuario) public{
        usuario = _usuario;

    }

    function saludarSolidity () public view returns(string memory){
        string memory saludo1 = "Hola ";
        string memory saludo2 = " al curso de solidity con ejemplos";
        string memory saludo = string.concat(saludo1, usuario, saludo2);
        return saludo;
    }




   
}