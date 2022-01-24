
var CurveBondedToken = artifacts.require('./CurveBondedToken');
module.exports = function(deployer) {
    deployer.deploy(CurveBondedToken,"MaheshBabu","MB","0x61DC4688294029D420196FecB3e1b790082E877B");
};