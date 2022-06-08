// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract FXAuction {

    uint auctionIdCount;

    mapping(uint256 => Auction) auctionData;  //maps the _bidListingId to the bid


    struct Auction {
        uint auctionId;
        uint _bidsAllocatedFunds;  //Keeps track of how many have been issued
        uint rbzUSDBalance;
        uint rbzZWLBalance;
        uint _bidListingId;   //Uniquely identifies the bid increments
        string auctionTitle;
        string auctionType;
        uint startTime;
        uint endTime;
        uint lowestBidPrice;
        uint highestBidPrice;
        mapping(uint256 => FxBidForm) primaryBidData;  //maps the _bidListingId to the bid
    }



    struct GetAuction {
        uint auctionId;
        uint _bidsAllocatedFunds;  //Keeps track of how many have been issued
        uint rbzUSDBalance;
        uint rbzZWLBalance;
        uint _bidListingId;   //Uniquely identifies the bid increments
        string auctionTitle;
        string auctionType;
        uint startTime;
        uint endTime;
        uint lowestBidPrice;
        uint highestBidPrice;
    }

    struct SubmitAuction {
        uint rbzUSDBalance;
        string auctionTitle;
        string auctionType;
        uint startTime;
        uint endTime;
        uint lowestBidPrice;
        uint highestBidPrice;
    }

    constructor() {
    }

    event BidSubmitted (
        FxBidForm bid
    );


    event AuctionCreated (
        uint indexed auctionId,
        uint rbzUSDBalance,
        uint rbzZWLBalance,
        string auctionTitle,
        string auctionType,
        uint startTime,
        uint endTime,
        uint lowestBidPrice,
        uint highestBidPrice
    );
    event BidAllocatedFunds (
        FxBidForm bid
    );


    event TestEvent (
        string message
    );

    struct FxBidForm {
        uint fxBidFormListingId;  //identifies a bid
        uint auctionId;

        string applicantName;
        string dateOfIncorporation;
        string tradingCommencementDate;
        string identificationNumber;
        string categoryOfBidder; //Category
        string physicalAddress;
        string emailAddress;
        string contactNumber;
        string applicantBank;
        string auctionRef;
        string priorExhangeControlNumber;
        uint date;


        string economicSector;
        string purposeOfFunds;
        string descriptionOfGoods;
        string ultimateBeneficiary;
        uint bidAmountUSD;
        uint bidExchangeRate;
        uint zwlEquivalent;
        uint currentBalanceZWL;
        uint currentNostroBalanceUSD;

        uint allocatedAmountBlance;
        bool allocationStatus;
    }

    function submitAuction(SubmitAuction memory newAuction) public {

        Auction storage a = auctionData[auctionIdCount];
        a.auctionId = auctionIdCount++;
        a.rbzUSDBalance = newAuction.rbzUSDBalance;
        a.auctionTitle = newAuction.auctionTitle;
        a.auctionType = newAuction.auctionType;
        a.startTime = newAuction.startTime;
        a.endTime = newAuction.endTime;
        a.lowestBidPrice = newAuction.lowestBidPrice;
        a.highestBidPrice = newAuction.highestBidPrice;

        emit TestEvent (
            "testing"
        );

        emit AuctionCreated (
            a.auctionId,
            a.rbzUSDBalance,
            a.rbzZWLBalance,
            a.auctionTitle,
            a.auctionType,
            a.startTime,
            a.endTime,
            a.lowestBidPrice,
            a.highestBidPrice
        );
    }

    function submitBid(FxBidForm memory fxBidForm) 
        public {
        
        require(fxBidForm.bidAmountUSD > 0, "Price must be greater than 0");
        require(fxBidForm.bidExchangeRate >= auctionData[fxBidForm.auctionId].lowestBidPrice, "Price below starting price");    
        require(fxBidForm.bidExchangeRate <= auctionData[fxBidForm.auctionId].highestBidPrice, "Price above highest price");
        require(fxBidForm.zwlEquivalent <= fxBidForm.currentBalanceZWL, "Insufficient funds in bank account");     
        require(fxBidForm.bidAmountUSD >= fxBidForm.currentNostroBalanceUSD, "Bidder has sufficient USD in nostro accounts");  
        // require(fxBidForm.bidAmountUSD >= 2500
        //       && fxBidForm.bidAmountUSD <= 500000
        //       && !((20000 < fxBidForm.bidAmountUSD) && (fxBidForm.bidAmountUSD < 50000)), "Bid amount is invalid");  
        require(fxBidForm.bidAmountUSD >= 2
              && fxBidForm.bidAmountUSD <= 500000
              && !((20000 < fxBidForm.bidAmountUSD) && (fxBidForm.bidAmountUSD < 50000)), "Bid amount is invalid");  


        fxBidForm.fxBidFormListingId = auctionData[fxBidForm.auctionId]._bidListingId;  //Generate a bid number
        // uint zwlEquival = bidAmountUSD*bidExchangeRate;

         // mapping the new primary bid to our generated bif number

         fxBidForm.allocatedAmountBlance = 0;
         fxBidForm.allocationStatus = false;

        auctionData[fxBidForm.auctionId].primaryBidData[auctionData[fxBidForm.auctionId]._bidListingId] = fxBidForm;

        auctionData[fxBidForm.auctionId]._bidListingId++;

        emit BidSubmitted (
        fxBidForm
    );


    }

    function getAllAuctionsCount() public view returns(uint){
        return auctionIdCount;
    }

    function getAllPrimaryBids(uint auctionId) public view returns(FxBidForm[] memory) {
        uint256 numberOfPrimaryBids = auctionData[auctionId]._bidListingId;
        uint256 currentIndex = 0;

        FxBidForm[] memory primaryActiveBids = new FxBidForm[](numberOfPrimaryBids);
        
        for(uint256 i = 0; i < numberOfPrimaryBids; i++) {
                uint256 currentId = i;
                FxBidForm storage currentItem = auctionData[auctionId].primaryBidData[currentId];
                primaryActiveBids[currentIndex] = currentItem;
                currentIndex += 1;
        }

        return primaryActiveBids;
    }

    function getAllAuctions() public view returns(GetAuction[] memory) {
        uint256 currentIndex = 0;

        GetAuction[] memory allAuctions = new GetAuction[](auctionIdCount);
        
        for(uint256 i = 0; i < auctionIdCount; i++) {
                GetAuction memory currentItem = GetAuction(
                    auctionData[currentIndex].auctionId,
                    auctionData[currentIndex]._bidsAllocatedFunds, 
                    auctionData[currentIndex].rbzUSDBalance,
                    auctionData[currentIndex].rbzZWLBalance,
                    auctionData[currentIndex]._bidListingId,
                    auctionData[currentIndex].auctionTitle,
                    auctionData[currentIndex].auctionType,
                    auctionData[currentIndex].startTime,
                    auctionData[currentIndex].endTime,
                    auctionData[currentIndex].lowestBidPrice,
                    auctionData[currentIndex].highestBidPrice
                    );
                allAuctions[currentIndex] = currentItem;
                currentIndex += 1;
        }

        return allAuctions;
    }

    // function sortBids() public view returns(FxBidForm[] memory) {
        
    //     uint numberOfPrimaryBids = _bidListingId;
    //     uint currentIndex = 0;

    //     BidDetails[] memory primaryBids = new BidDetails[](numberOfPrimaryBids);

        
    //     for(uint i = 0; i < numberOfPrimaryBids; i++) {
    //             uint currentId = i;
    //             BidDetails storage currentItem = primaryBidData[currentId];
    //             primaryBids[currentIndex] = currentItem;
    //             currentIndex += 1;
    //     }

    //     // Pass our primaryBids for sorting
    //     quickSort(primaryBids, 0, numberOfPrimaryBids);

    //     return primaryBids;
    // }

    //Allocate funds passinf the sortedPrimaryBids
    function allocateFunds(
        FxBidForm[] memory bids  //Array of primaryBids
    ) public {
        emit TestEvent (
            "testing"
        );

        uint auctionId = bids[0].auctionId;
        for (uint16 i = 0; i < bids.length; i++) {
            uint index = bids.length -i-1; 
            if(auctionData[auctionId].rbzUSDBalance  < bids[index].bidAmountUSD){
                break;
            }else{
                FxBidForm storage bid = auctionData[auctionId].primaryBidData[bids[index].fxBidFormListingId];
                bid.allocatedAmountBlance = bids[index].bidAmountUSD;
                auctionData[auctionId].rbzUSDBalance = auctionData[auctionId].rbzUSDBalance - bids[index].bidAmountUSD;
                auctionData[auctionId].rbzZWLBalance = auctionData[auctionId].rbzZWLBalance + bids[index].zwlEquivalent;

                auctionData[auctionId].primaryBidData[bids[index].fxBidFormListingId].allocationStatus = true;

                emit BidAllocatedFunds (
                    bid
                );

                auctionData[auctionId]._bidsAllocatedFunds++;

            }
        }

    }

    function findPrimaryBidById(uint256 fxBidFormListingId, uint auctionId) public view returns(FxBidForm memory) {
        return auctionData[auctionId].primaryBidData[fxBidFormListingId];
    }


    // function quickSort(FxBidForm[] memory bids, uint left, uint right) public view {
    //     uint i = left;
    //     uint j = right;
    //     if (i == j) return;
    //     uint pivotExchangeRate = bids[uint(left + (right - left) / 2)].bidExchangeRate; //pivotExchangeRate is the value at midpoint bids[i].amount
    //     // require(pivotExchangeRate == 128, "Original pivot != 3");

    //     while (i <= j) {
    //         while (bids[uint(i)].bidExchangeRate < pivotExchangeRate) i++;
    //         while (pivotExchangeRate < bids[uint(j)].bidExchangeRate) j--;
    //         if (i <= j) {
    //             (bids[uint(i)], bids[uint(j)]) = (bids[uint(j)], bids[uint(i)]);  //Assuming this is swapping
    //             i++;
    //             j--;
    //         }
    //     }
    //     if (left < j){
    //         quickSort(bids, left, j);
    //     }
    //     if (i < right){
    //         quickSort(bids, i, right);
    //     }
    // }
}
