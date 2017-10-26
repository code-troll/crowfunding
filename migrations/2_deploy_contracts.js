var Crowfunding = artifacts.require("./Crowfunding.sol");

module.exports = function(deployer) {
  deployer.deploy(Crowfunding);
};
