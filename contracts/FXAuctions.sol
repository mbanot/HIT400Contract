// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

// import "./ERC20.sol";

contract FXAuctions {



  mapping (uint => FXBidForm) primaryBids;
  mapping (uint => FXBidForm) secondaryTraders;
  mapping (uint => FXBidForm) secondaryServices;
  mapping (uint => FXBidForm) secondaryFinished;
  mapping (uint => FXBidForm) secondaryConsumables;
  mapping (uint => FXBidForm) individuals;
  uint public primaryCount = 0;
  uint public secondaryTradersCount = 0;
  uint public secondaryServicesCount = 0;
  uint public secondaryFinishedCount = 0;
  uint public secondaryConsumablesCount = 0;
  uint public individualsCount = 0;


  uint public numberOfAuctioneers = 0;
  mapping (uint => FXBidForm)  bids;
  uint totalAuctionAmountUSD;
  uint bidSubmitionCloseTime;
  uint highestBidPrice;
  uint lowestBidPrice;
  address owner;

    struct FXBidForm {
        uint _id;
        string _applicantName;
        string _dateOfIncorporation;
        string _tradingCommencementDate;
        string _identificationNumber;
        string _categoryOfBidder;
        string _physicalAddress;
        string _emailAddress;
        string _contactNumber;
        string _applicantBank;
        string _auctionRef;
        string _priorExhangeControlNumber;
        uint _date;


        string _economicSector;
        string _purposeOfFunds;
        string _descriptionOfGoods;
        string _ultimateBeneficiary;
        uint _bidAmountUSD;
        uint _bidExchangeRate;
        uint _zwlEquivalent;
        uint _currentBalanceZWL;
        uint _currentNostroBalanceUSD;

    }

    mapping(address=>uint) bidBalance;
    mapping(address=>FXBidForm) bidInfor;

    modifier onlyWhileOpen(){
        require(bidSubmitionCloseTime <= block.timestamp);
        _;
    } 

    constructor (uint _totalAuctionAmountUSD, uint _bidSubmitionCloseTime, uint _highestBidPrice, uint _lowestBidPrice) {
        totalAuctionAmountUSD = _totalAuctionAmountUSD;
        bidSubmitionCloseTime = _bidSubmitionCloseTime;
        highestBidPrice = _highestBidPrice;
        lowestBidPrice = _lowestBidPrice;
        bidBalance[msg.sender] = _totalAuctionAmountUSD;

    }

    function getAvailableBidBalance() public view  returns (uint) {
      return bidBalance[msg.sender];
    }

    function getNumberOfBidders() public view returns (uint){
      return primaryCount;
    }

    function submitBid(FXBidForm memory _fixBiForm) public onlyWhileOpen {
            require(_fixBiForm._bidExchangeRate >= lowestBidPrice, "Price below starting price");    
            require(_fixBiForm._bidExchangeRate <= highestBidPrice, "Price above highest price");
            require(_fixBiForm._zwlEquivalent <= _fixBiForm._currentBalanceZWL, "Insufficient funds in bank account");     
            require(_fixBiForm._bidAmountUSD >= _fixBiForm._currentNostroBalanceUSD, "Bidder has sufficient USD in nostro accounts");  
            require(_fixBiForm._bidAmountUSD >= 2500
                    && _fixBiForm._bidAmountUSD <= 500000
                    && !((20000 < _fixBiForm._bidAmountUSD) && (_fixBiForm._bidAmountUSD < 50000)), "Bidder has sufficient USD in nostro accounts");  

 
            if(keccak256(abi.encodePacked((_fixBiForm._categoryOfBidder))) == keccak256(abi.encodePacked(("PRIMARY")))){
              _fixBiForm._id = primaryCount;
              primaryBids[primaryCount++] = _fixBiForm;
            }
            else if (keccak256(abi.encodePacked((_fixBiForm._categoryOfBidder))) == keccak256(abi.encodePacked(("SECONDARY - TRADER/AGENTS/COMMODITY BROKER")))){
              _fixBiForm._id = secondaryTradersCount;
              secondaryTraders[secondaryTradersCount++] = _fixBiForm;
            }
            else if (keccak256(abi.encodePacked((_fixBiForm._categoryOfBidder))) == keccak256(abi.encodePacked(("SECONDARY - SERVICES")))){
              _fixBiForm._id = secondaryServicesCount;
              secondaryServices[secondaryServicesCount++] = _fixBiForm;
            }
            else if (keccak256(abi.encodePacked((_fixBiForm._categoryOfBidder))) == keccak256(abi.encodePacked(("SECONDARY - FINISHED GOODS")))){
              _fixBiForm._id = secondaryFinishedCount;
              secondaryFinished[secondaryFinishedCount++] = _fixBiForm;
            }
            else if (keccak256(abi.encodePacked((_fixBiForm._categoryOfBidder))) == keccak256(abi.encodePacked(("SECONDARY - CONSUMABLES")))){
              _fixBiForm._id = secondaryConsumablesCount;
              secondaryConsumables[secondaryConsumablesCount++] = _fixBiForm;
            }
            else if (keccak256(abi.encodePacked((_fixBiForm._categoryOfBidder))) == keccak256(abi.encodePacked(("INDIVIDUAL")))){
              _fixBiForm._id = individualsCount;
              individuals[individualsCount++] = _fixBiForm;
            }


      }


    function incrementCount() internal{
        numberOfAuctioneers++;
   }

   function selectWinningBid() internal view {
        
    
   }




}