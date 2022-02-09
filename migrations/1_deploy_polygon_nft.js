const PolygonNFT = artifacts.require("PolygonNFT");

module.exports = function (deployer) {
  deployer.deploy(PolygonNFT);
};
