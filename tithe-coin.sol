// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract TitheCoin {
    address public minter;
    address public philanthropyOrg;
    address defaultPhilanthropyOrg = 0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
    uint defaultDonation = 1;
    uint donationAmount;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() {
        minter = msg.sender;
        philanthropyOrg = defaultPhilanthropyOrg;
        donationAmount = defaultDonation;
    }

    function updatePhilanthropyOrg(address _philanthropyOrg) external {
        philanthropyOrg = _philanthropyOrg;
    }

    function updateDonationAmount(uint _donationAmount) external {
        donationAmount = _donationAmount;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
        //
        //Send a donation to our favorite philanthropy organization
        balances[receiver] -= donationAmount;
        balances[msg.sender] += donationAmount;
        this.send(philanthropyOrg, donationAmount);
    }

    error insufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender]) {
            revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
            });
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}