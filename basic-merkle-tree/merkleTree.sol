pragma solidity ^0.8.0;

contract MerkleTree {
    bytes32[] public leaves;
    bytes32 public root;

    constructor(bytes32[] memory leafValues) public {
        leaves = leafValues;
        root = getMerkleRoot(leafValues);
    }

    function getMerkleRoot(bytes32[] memory leafValues) public view returns (bytes32) {
        if (leafValues.length == 1) {
            return leafValues[0];
        }

        bytes32[] memory nextLevel = new bytes32[];

        for (uint i = 0; i < leafValues.length; i += 2) {
            if (i + 1 == leafValues.length) {
                nextLevel.push(leafValues[i]);
            } else {
                nextLevel.push(keccak256(leafValues[i] + leafValues[i + 1]));
            }
        }

        return getMerkleRoot(nextLevel);
    }
}
