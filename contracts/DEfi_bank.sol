// SPDX-License-Identifier: MIT
// functionality, Deposit withdraw issue interest
pragma solidity ^0.8.0;
interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract DEfi_bank {
    address public usdc;
    address public ausd;

    address[] public depositers; //array for customer deposit

    mapping(address => uint) public deposited_balance; // for the one who deposits
    mapping(address => bool) public has_deposited; // 
    constructor(address _usdc, address _ausd) {
        usdc = _usdc;
        ausd = _ausd;
    }
    function depositToken(uint _amount) public {
        IERC20(usdc).transferFrom(msg.sender, address(this), _amount);
        deposited_balance[msg.sender] += _amount;

        if (!has_deposited[msg.sender]) {
            depositers.push(msg.sender);
        }
        has_deposited[msg.sender] = true;
    }
    function withdrawToken(uint _amount) public {
        uint balance = deposited_balance[msg.sender];
        require(balance > 0, "Low balance");
        IERC20(usdc).transfer(msg.sender, balance);
        deposited_balance[msg.sender] -= _amount;

        if(balance - _amount == 0) {
            has_deposited[msg.sender] = false;
        }
    }
    function interestToken() public {
        for(uint i; i< depositers.length; i++) {
            address recipient = depositers[i];
            uint balance =  deposited_balance[recipient];
            if(balance > 0) {
            IERC20(ausd).transfer(recipient, balance);
        
            }
        }
        
    }


}
