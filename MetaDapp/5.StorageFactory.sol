//SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "./4.SimpleStorage.sol";

contract StorageFactory is SimpleStorage{

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorage() public {
        SimpleStorage simpleStorage = new  SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    //Funcion que introduce en cada direccion creada por usar createSimpleStorage, un numero favorito.
    function stStore(uint _stIndex, uint _favoriteNumber)public {

        /*Quiero recoger el Adress creado al utilizar la funcion "createSimpleStorage",
        guardado en el indice X del array de la funcion "createSimpleStorage",
        e instanciarla en el contrato SimpleStorage para utilizarla en las funciones que hay dentro de ella.
        Siempre para interactuar con un contarto necesitamos un Adress.*/

        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_stIndex]));
        simpleStorage.store(_favoriteNumber);
        
        //Refactorizado seria:
        //SimpleStorage(address(simpleStorageArray[_stIndex])).store(_favoriteNumber);
    }

    function stGet (uint _stIndex) public view returns(uint){
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_stIndex]));
        return simpleStorage.retrieve();
    }






}