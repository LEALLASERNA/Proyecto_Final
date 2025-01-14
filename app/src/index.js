import Web3 from "/web3";
import MiContrato from "../../build/contracts/miContrato.json";

const dir_contrato = "0x7E0b19B0c376b43d7a7b51D2ddfb26e11c4ebbE1";
const mi_direccion = "0x1b97d6f688fbe2a6cb76ce31c4b8a7ee573b92a0";
const url = "http://127.0.0.1:8545/";

const web3 = new Web3(url);
const contrato = new web3.eth.Contract(MiContrato.abi, dir_contrato);

const btGuardar = document.getElementById('btGuardar');
const btConsultar = document.getElementById('btConsultar');
const selector = document.getElementById('tarea');
const divGuardar = document.getElementById('guardarInfo');
const divConsultar = document.getElementById('consultarInfo');

selector.addEventListener('change', async() => {
  var selector_value = selector.value;
  if (selector_value == "1") {
    divGuardar.style.display = "block";
    divConsultar.style.display = "none";
  } else if (selector_value == "2"){
    divGuardar.style.display = "none";
    divConsultar.style.display = "block";
  } else {
    divGuardar.style.display = "none";
    divConsultar.style.display = "none";
  }
});

  btGuardar.addEventListener('click', async() => {
    var fecha = parseInt(document.getElementById('fecha').value);
    var precio = parseInt(document.getElementById('precio').value);
    var destino = document.getElementById('destino').value;

    await contrato.methods.guardar(fecha, destino, precio).send({from: mi_direccion});
  });

  btConsultar.addEventListener('click', async() => {
    var fecha = parseInt(document.getElementById('fecha_ver').value);
    var resultado = await instancia.consultar('resultado');
    var destino_precio = await contrato.methods.consultar(fecha).call();
    resultado.innerHTML = "El viaje de " + fecha +" se realizo a " + destino_precio[0] + " y tuvo un costo de " + destino_precio[1] + " euros";
  });