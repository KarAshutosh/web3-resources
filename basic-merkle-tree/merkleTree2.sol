pragma solidity ^0.9.0;

contract MerkleTree {
    bytes32[] public leaves;
    bytes32 public root;

    constructor(bytes32[] memory leafValues) public {
        leaves = leafValues;
        root = getMerkleRoot(leafValues);
    }

    function getMerkleRoot(bytes32[] memory leafValues) public view returns (bytes32) {
        // If there is only one leaf node, return its value as the Merkle root
        if (leafValues.length == 1) {
            return leafValues[0];
        }

        // Initialize an empty array to hold the next level of nodes in the tree
        bytes32[] memory nextLevel = new bytes32[](leafValues.length / 2 + leafValues.length % 2);

        // Iterate through the leaf nodes in pairs, hashing them together and adding the result to the next level
        for (uint i = 0; i < leafValues.length; i += 2) {
            if (i + 1 == leafValues.length) {
                // If there is an odd number of leaf nodes, the last node is hashed with itself
                nextLevel[i / 2] = keccak256(leafValues[i] + leafValues[i]);
            } else {
                // Hash the current pair of leaf nodes and add the result to the next level
                nextLevel[i / 2] = keccak256(leafValues[i] + leafValues[i + 1]);
            }
        }

        // Recursively compute the root of the next level of the tree
        return getMerkleRoot(nextLevel);
    }
}
