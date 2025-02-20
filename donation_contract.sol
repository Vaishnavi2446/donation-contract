// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonationWithMessage {
    address public owner;
    uint256 public totalDonations;

    struct Donation {
        address donor;
        uint256 amount;
        string message;
    }

    Donation[] public donations;

    event DonationReceived(address indexed donor, uint256 amount, string message);

    constructor() {
        owner = msg.sender;
    }

    function donate(string memory _message) public payable {
        require(msg.value > 0, "Donation must be greater than 0");

        donations.push(Donation(msg.sender, msg.value, _message));
        totalDonations += msg.value;

        emit DonationReceived(msg.sender, msg.value, _message);
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");

        payable(owner).transfer(address(this).balance);
    }

    function getDonation(uint256 index) public view returns (address, uint256, string memory) {
        require(index < donations.length, "Invalid index");
        Donation memory donation = donations[index];
        return (donation.donor, donation.amount, donation.message);
    }

    function getTotalDonations() public view returns (uint256) {
        return totalDonations;
    }

    function getDonationsCount() public view returns (uint256) {
        return donations.length;
    }
}

