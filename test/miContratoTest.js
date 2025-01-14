const MiContrato = artifacts.require("miContrato");

contract('Mi primer smart contract', (accounts) => {

    it('1er test - Valor correcto de destino', async () => {
    
        const instancia = await MiContrato.new();
        const fecha = 2015;
        const destino = "Alemania";
        const precio = 1000;
        await instancia.guardar(fecha, destino, precio);
        var resultado = await instancia.consultar(fecha);
        assert.equal(destino,resultado[0], "El destino no es correcto");
    });

    it('2do test - Valor correcto de precio', async () => {
    
        const instancia = await MiContrato.new();
        const fecha = 2024;
        const destino = "Madrid";
        const precio = 2000;
        await instancia.guardar(fecha, destino, precio);
        var resultado = await instancia.consultar(fecha);
        assert.equal(precio,resultado[1], "El precio no es correcta");
    });


})