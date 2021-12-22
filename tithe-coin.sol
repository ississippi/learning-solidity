// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract TitheCoin {
    address public minter;
    address public philanthropyOrg;
    address defaultPhilanthropyOrg = 0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
    uint defaultDonationDivisor = 100 / 2;
    uint donationDivisor;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);
    event DebugLog(address from, address to, uint balanceSender, uint amount);

    constructor() {
        minter = msg.sender;
        philanthropyOrg = defaultPhilanthropyOrg;
        donationDivisor = defaultDonationDivisor;
    }

    function updatePhilanthropyOrg(address newPhilanthropyOrg) external {
        philanthropyOrg = newPhilanthropyOrg;
    }

    function updateDonationPercent(uint newDonationPct) external {
        donationDivisor = 100 / newDonationPct;
    }
    
    function calculateDonation(uint newDonationPct, uint amount) external pure returns(uint) {
        uint divisor = 100 / newDonationPct;
        return amount / divisor;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
        //
        //Send a donation to our favorite philanthropy organization
        uint donation = amount / donationDivisor;
        balances[receiver] -= donation;
        balances[msg.sender] += donation;
        emit DebugLog(msg.sender, receiver, balances[msg.sender], donation);
        this.send(philanthropyOrg, donation);
        balances[philanthropyOrg] += donation;
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