
var DEMIToken = artifacts.require('./DEMIToken');
module.exports = function(deployer) {
    deployer.deploy(DEMIToken);
};
