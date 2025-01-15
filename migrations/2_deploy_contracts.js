const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const MiContrato = artifacts.require("miContrato");

/*
module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin, miContrato);
  deployer.deploy(MetaCoin);
  deployer.deploy(miContrato);
};
*/

module.exports = function(deployer) {
  deployer.deploy(MiContrato);
};