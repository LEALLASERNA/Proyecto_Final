//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleStorage{

    uint favoriteNumber;

    struct People{
        uint favoriteNumber;
        string name;
    }

    mapping(string => uint) public nameToFavoriteNumber;

    People[] public people;

    function store(uint _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint _favoriteNumber) public{
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    //Funcion para ver solo los nombres de un array con prompt(su numero preferido)
    function verPersona(uint _favoriteNumber) view public returns (string[] memory){
        uint contador = 0;
        
        string[] memory nombres = new string[](people.length);
        
        for(uint i=0;i<people.length;i++){
            if(people[i].favoriteNumber == _favoriteNumber){
                nombres[contador] = people[i].name;
                contador++;
            }                         
        }
        
        string[] memory resultadosFinales = new string[](contador);
        
        for (uint j = 0; j < contador; j++) {
            resultadosFinales[j] = nombres[j];
        }
    
        return resultadosFinales;    
    }
}