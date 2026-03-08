// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "./MyToken.sol";

contract MyTokenTest is Test {
    MyToken public token;
    address public owner = address(1);
    address public user = address(2);

    function setUp() public {
        vm.prank(owner);
        token = new MyToken("TestToken", "TTK", 1000);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1000 * 10 ** 18);
        assertEq(token.balanceOf(owner), 1000 * 10 ** 18);
    }

    function testMinting() public {
        vm.prank(owner);
        token.mint(user, 500);
        assertEq(token.balanceOf(user), 500);
    }

    function testFailNonOwnerMint() public {
        vm.prank(user);
        token.mint(user, 100); // Should revert
    }
}
