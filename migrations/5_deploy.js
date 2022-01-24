
var CurveBondedToken = artifacts.require('./CurveBondedToken');
module.exports = function(deployer) {
    deployer.deploy(CurveBondedToken,"MaheshBabu","MB","0x101A89118528052cd6b6DD43f48DC2b54ADa68F0");
};