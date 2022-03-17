var FXAuctions = artifacts.require("./FXAuctions.sol");

contract("FXAuctions", function(accounts){
    const [contractOwner, tafara] = accounts;

    beforeEach(async () => {
        //usdAmount, closeTime, highestBid, lowestBid
        instance = await  FXAuctions.new(500, 20, 130, 3);
    }); 
    
    it("should check bid balance", async() =>{
        assert.equal(await instance.getAvailableBidBalance(), "500");
    })
    it("should check submit bid successfully", async() =>{
        assert.equal(await instance.primaryCount(), "0");

        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "PRIMARY",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tmmmbano@gmail.com",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 124,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "PRIMARY",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tmmmbano@gmail.com",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 124,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        assert.equal(await instance.primaryCount(), "2");
        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "INDIVIDUAL",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tafaram@nmbz.co.zw",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 124,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        assert.equal(await instance.individualsCount(), "1");
        assert.equal(await instance.primaryCount(), "2");

        // console.log(await instance.getSomeBids());
        let submittedBid = await instance.getPrimaryBids(1);
        console.log(submittedBid);
        assert.equal(submittedBid["_applicantBank"], 'NMB Bank');


        
    })

    it("should check select bid", async() =>{
        assert.equal(await instance.primaryCount(), "0");

        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "PRIMARY",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tmmmbano@gmail.com",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 124,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "PRIMARY",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tmmmbano@gmail.com",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 124,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        assert.equal(await instance.primaryCount(), "2");
        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "INDIVIDUAL",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tafaram@nmbz.co.zw",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 124,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        assert.equal(await instance.individualsCount(), "1");
        assert.equal(await instance.primaryCount(), "2");

        // console.log(await instance.getSomeBids());
        let submittedBid = await instance.getPrimaryBids(1);
        console.log(submittedBid);
        assert.equal(submittedBid["_applicantBank"], 'NMB Bank');




        
    })

    it("should check sort array", async() =>{
        assert.equal(await instance.primaryCount(), "0");

        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano 1",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "PRIMARY",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tmmmbano@gmail.com",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 126,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano 2",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "PRIMARY",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tmmmbano@gmail.com",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 124,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        assert.equal(await instance.primaryCount(), "2");
        await instance.submitBid(
            {
                _id: 0,
                _applicantName: "Tafara Mbano 3",
                _dateOfIncorporation: "22/01/1994",
                _tradingCommencementDate: "05/03/1994",
                _identificationNumber: "0497985480",
                _categoryOfBidder: "PRIMARY",
                _physicalAddress: "6020 Westlea",
                _emailAddress: "tafaram@nmbz.co.zw",
                _contactNumber: "0783461408",
                _applicantBank: "NMB Bank",
                _auctionRef: "378473",
                _priorExhangeControlNumber: "N/A",
                _date: 1646379440,
        

                _economicSector: "Manufacturing",
                _purposeOfFunds: "Raw Materials",
                _descriptionOfGoods: "Iron ore",
                _ultimateBeneficiary: "Zimbabwe",
                _bidAmountUSD: 10000,
                _bidExchangeRate: 129,
                _zwlEquivalent: 1240000,
                _currentBalanceZWL: 1020293944,
                _currentNostroBalanceUSD: 809,
            }
        )
        assert.equal(await instance.individualsCount(), "0");
        assert.equal(await instance.primaryCount(), "3");

        // console.log(await instance.getSomeBids());
        let submittedBid = await instance.getPrimaryBids(0);
        console.log(submittedBid);
        assert.equal(submittedBid["_applicantName"], 'Tafara Mbano 1');


        // instance.selectWinningBid();

        submittedBid = await instance.getSortedPrimaryBids(1);
        console.log(submittedBid);
        assert.equal(submittedBid["_applicantName"], 'Tafara Mbano 1');

        


        
    })

})