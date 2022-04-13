// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract FXAuction {

    uint private _bidListingId;   //Uniquely identifies the bid increments
    uint private _bidsAllocatedFunds;  //Keeps track of how many have been issued


    mapping(uint256 => BidDetails) private primaryBidData;  //maps the _bidListingId to the bid
    mapping(uint256 => BidderDetails) private primaryBidderData;  //maps the _bidListingId to the bidder


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


    struct BidDetails {
        uint fxBidFormListingId;  //identifies a bid
        // string categoryOfBidder; //Category
        uint bidAmountUSD;
        uint bidExchangeRate;
        uint zwlEquivalent;
        // uint currentBalanceZWL;
        // uint currentNostroBalanceUSD;

        uint allocatedAmountBlance;
        bool allocationStatus;
    }

    struct BidderDetails {
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

    }
    function submitBid(FxBidForm memory fxBidForm) 
        public {
        
        require(fxBidForm.bidAmountUSD > 0, "Price must be greater than 0");

        fxBidForm.fxBidFormListingId = _bidListingId;  //Generate a bid number
        // uint zwlEquival = bidAmountUSD*bidExchangeRate;

         // mapping the new primary bid to our generated bif number

        primaryBidData[_bidListingId] = BidDetails(
            fxBidForm.fxBidFormListingId,
            // fxBidForm.categoryOfBidder,
            fxBidForm.bidAmountUSD,
            fxBidForm.bidExchangeRate,
            fxBidForm.zwlEquivalent,
            // fxBidForm.currentBalanceZWL,
            // fxBidForm.currentNostroBalanceUSD,
            0,
            false
            );
            
        primaryBidderData[_bidListingId] = BidderDetails(
        fxBidForm.fxBidFormListingId,  
        fxBidForm.applicantName,
        fxBidForm.dateOfIncorporation,
        fxBidForm.tradingCommencementDate,
        fxBidForm.identificationNumber,
        fxBidForm.categoryOfBidder,
        fxBidForm.physicalAddress,
        fxBidForm.emailAddress,
        fxBidForm.contactNumber,
        fxBidForm.applicantBank,
        fxBidForm.auctionRef,
        fxBidForm.priorExhangeControlNumber,
        fxBidForm.date,


        fxBidForm.economicSector,
        fxBidForm.purposeOfFunds,
        fxBidForm.descriptionOfGoods,
        fxBidForm.ultimateBeneficiary
        );

        
        // FxBidForm(fxBidFormListingId,
        //     applicantName,
        //     dateOfIncorporation,
        //     tradingCommencementDate,
        //     identificationNumber,
        //     categoryOfBidder,
        //     physicalAddress,
        //     emailAddress,
        //     contactNumber,
        //     applicantBank,
        //     auctionRef,
        //     priorExhangeControlNumber,
        //     date,
        //     economicSector,
        //     purposeOfFunds,
        //     descriptionOfGoods,
        //     ultimateBeneficiary,
        //     bidAmountUSD,
        //     bidExchangeRate,
        //     zwlEquivalent,
        //     currentBalanceZWL,
        //     currentNostroBalanceUSD,
        //     0,
        //     false
        // );

        _bidListingId++;

    }

    function getAllPrimaryBids() public view returns(BidDetails[] memory) {
        uint256 numberOfPrimaryBids = _bidListingId;
        uint256 currentIndex = 0;

        BidDetails[] memory primaryActiveBids = new BidDetails[](numberOfPrimaryBids);
        
        for(uint256 i = 0; i < numberOfPrimaryBids; i++) {
                uint256 currentId = i;
                BidDetails storage currentItem = primaryBidData[currentId];
                primaryActiveBids[currentIndex] = currentItem;
                currentIndex += 1;
        }

        return primaryActiveBids;
    }

    function sortBids() public view returns(BidDetails[] memory) {
        
        uint numberOfPrimaryBids = _bidListingId;
        uint currentIndex = 0;

        BidDetails[] memory primaryBids = new BidDetails[](numberOfPrimaryBids);

        
        for(uint i = 0; i < numberOfPrimaryBids; i++) {
                uint currentId = i;
                BidDetails storage currentItem = primaryBidData[currentId];
                primaryBids[currentIndex] = currentItem;
                currentIndex += 1;
        }

        // Pass our primaryBids for sorting
        quickSort(primaryBids, 0, numberOfPrimaryBids-1);

        return primaryBids;
    }

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

    function findPrimaryBidById(uint256 fxBidFormListingId) public view returns(BidDetails memory) {
        return primaryBidData[fxBidFormListingId];
    }


    function quickSort(BidDetails[] memory bids, uint left, uint right) public view {
        uint i = left;
        uint j = right;
        if (i == j) return;
        uint pivotExchangeRate = bids[uint(left + (right - left) / 2)].bidExchangeRate; //pivotExchangeRate is the value at midpoint bids[i].amount
        // require(pivotExchangeRate == 128, "Original pivot != 3");

        while (i <= j) {
            while (bids[uint(i)].bidExchangeRate < pivotExchangeRate) i++;
            while (pivotExchangeRate < bids[uint(j)].bidExchangeRate) j--;
            if (i <= j) {
                (bids[uint(i)], bids[uint(j)]) = (bids[uint(j)], bids[uint(i)]);  //Assuming this is swapping
                i++;
                j--;
            }
        }
        if (left < j){
            quickSort(bids, left, j);
        }
        if (i < right){
            quickSort(bids, i, right);
        }
    }
}
