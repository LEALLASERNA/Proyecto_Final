// SPDX-License-Identifier: MIT

pragma solidity >=0.4.21 <0.7.0;

contract miContrato {

    struct Viajes {
        string Destino;
        uint256 Precio;
    }

    mapping (uint256 => Viajes) public ViajesPorFecha;

    function guardar (uint _fecha, string memory _destino, uint256 _precio) public {
        ViajesPorFecha[_fecha] = Viajes(_destino, _precio);
    }

    function consultar (uint _fecha) public view returns (string memory, uint256) {
        //string memory destino = ViajesPorFecha[_fecha].Destino;
        //uint precio = ViajesPorFecha[_fecha].Precio;
        //return (destino, precio);

        return (ViajesPorFecha[_fecha].Destino, ViajesPorFecha[_fecha].Precio);
    }





}