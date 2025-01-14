const MiContrato = artifacts.require("miContrato");

module.exports = function(deployer) {
  deployer.deploy(MiContrato);
};

