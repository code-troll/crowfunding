pragma solidity ^0.4.0;


contract Crowfunding {
    struct Campaign {
    address recipient;
    uint contributed;
    uint qty_contributions;
    bool initialized;
    mapping (address => Contribution) contributions;
    }

    struct Contribution {
    address contributor;
    uint amount;
    uint count;
    }

    uint public campaignNumber;

    mapping (uint => Campaign) campaigns;

    mapping (address => uint) balances;

    function start() returns (uint id) {
        Campaign memory newCampaign;
        newCampaign.recipient = msg.sender;
        newCampaign.initialized = true;

        campaigns[campaignNumber] = newCampaign;

        campaignNumber++;

        return campaignNumber;
    }

    function donate(uint campaignId, uint amount) returns (bool success) {
        require(campaigns[campaignId].initialized);

        require(amount > 0);

        var campaign = campaigns[campaignId];
        campaign.contributed += amount;
        campaign.qty_contributions++;

        var contribution = campaign.contributions[msg.sender];
        contribution.contributor = msg.sender;
        contribution.amount += amount;
        contribution.count++;

        return true;
    }

    function getCampaignBalance(uint campaignId) constant returns (uint collected_amount) {
        require(campaigns[campaignId].initialized);

        return campaigns[campaignId].contributed;
    }

    function getContributorDonation(address contributor, uint campaignId) constant returns (uint contribution) {
        require(campaigns[campaignId].initialized);

        return campaigns[campaignId].contributions[contributor].amount;
    }

    function getContributorContributions(address contributor, uint campaignId) constant returns (uint contribution) {
        require(campaigns[campaignId].initialized);

        return campaigns[campaignId].contributions[contributor].count;
    }
}