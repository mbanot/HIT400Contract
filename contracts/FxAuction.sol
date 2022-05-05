// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract FXAuction {

    uint private _bidListingId;   //Uniquely identifies the bid increments
    uint private _bidsAllocatedFunds;  //Keeps track of how many have been issued


    mapping(uint256 => FxBidForm) private primaryBidData;  //maps the _bidListingId to the bid


    uint rbzUSDBalance = 100;
    uint rbzZWLBalance = 0;

    constructor() {
    }

    struct FxBidForm {
        uint fxBidFormListingId;  //identifies a bid

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

    function submitBid(FxBidForm memory fxBidForm) 
        public {
        
        require(fxBidForm.bidAmountUSD > 0, "Price must be greater than 0");

        fxBidForm.fxBidFormListingId = _bidListingId;  //Generate a bid number
        // uint zwlEquival = bidAmountUSD*bidExchangeRate;

         // mapping the new primary bid to our generated bif number

         fxBidForm.allocatedAmountBlance = 0;
         fxBidForm.allocationStatus = false;

        primaryBidData[_bidListingId] = fxBidForm;

        _bidListingId++;

    }

    function getAllPrimaryBids() public view returns(FxBidForm[] memory) {
        uint256 numberOfPrimaryBids = _bidListingId;
        uint256 currentIndex = 0;

        FxBidForm[] memory primaryActiveBids = new FxBidForm[](numberOfPrimaryBids);
        
        for(uint256 i = 0; i < numberOfPrimaryBids; i++) {
                uint256 currentId = i;
                FxBidForm storage currentItem = primaryBidData[currentId];
                primaryActiveBids[currentIndex] = currentItem;
                currentIndex += 1;
        }

        return primaryActiveBids;
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


        for (uint16 i = 0; i < bids.length; i++) {
            uint index = bids.length -i-1;
            if(rbzUSDBalance  < bids[index].bidAmountUSD){
                break;
            }else{

                primaryBidData[bids[index].fxBidFormListingId].allocatedAmountBlance = bids[index].bidAmountUSD;
                rbzUSDBalance = rbzUSDBalance - bids[index].bidAmountUSD;
                rbzZWLBalance = rbzZWLBalance + bids[index].zwlEquivalent;

                primaryBidData[bids[index].fxBidFormListingId].allocationStatus = true;

                _bidsAllocatedFunds++;
            }
        }

    }

    function findPrimaryBidById(uint256 fxBidFormListingId) public view returns(FxBidForm memory) {
        return primaryBidData[fxBidFormListingId];
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
