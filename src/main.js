import Vue from 'vue';
import App from './App.vue';
import "vuetify/dist/vuetify.min.css";
import Router from "vue-router";
import Vuetify from 'vuetify/lib';
import VueAxios from 'vue-axios';
import web3 from 'web3'

import FXAuction from './abis/FXAuction.json'

import Login from "@/components/Login";
import Dashboard from "@/components/Dashboard";
import BidForm from './components/BidForm'
import AuctionForm from './components/AuctionForm'
import AuctionView from './components/AuctionView'

// Import the Auth0 configuration
import { domain, clientId } from "../auth_config.json";
// Import the plugin here
import { Auth0Plugin } from "./auth";
import { authGuard } from "./auth/authGuard";



Vue.config.productionTip = false;


var Web3 = require('web3')
var VueWeb3 = require('vue-web3')
 
// explicit installation required in module environments
console.log(window.ethereum)
Vue.use(VueWeb3, { web3: new Web3(window.ethereum) })

web3 =  new Web3(window.ethereum)

console.log( web3.eth)

let fxAuction = new web3.eth.Contract(FXAuction.abi, '0x509950aFFa2fBE3f1183D4443A471A117bf911b8')


Vue.use(VueAxios);

Vue.use(Router);
const routes = [

  {
    path: '/',
    component: Dashboard,
    name: 'home',
    beforeEnter: authGuard 
  },
  {
    path: '/login',
    component: Login,
    name: 'login'
  },
  {
    path: '/bid',
    component: BidForm,
    name: 'submitBid',
    beforeEnter: authGuard 
  },
  {
    path: '/auction',
    component: AuctionForm,
    name: 'createAuction',
    beforeEnter: authGuard 
  },
  {
    path: '/auction/list',
    component: AuctionView,
    name: 'viewAuctions',
    beforeEnter: authGuard 
  }
]


const router = new Router({
  mode: 'history',
  routes: routes
});

Vue.use(Vuetify);
const vuetify = new Vuetify();

// Install the authentication plugin here
Vue.use(Auth0Plugin, {
  domain,
  clientId,
  onRedirectCallback: appState => {
    router.push(
      appState && appState.targetUrl
        ? appState.targetUrl
        : window.location.pathname
    );
  }
});

// var Web3 = require('web3')
// var VueWeb3 = require('vue-web3')
 
// // explicit installation required in module environments
// Vue.use(VueWeb3, { web3: new Web3(web3.currentProvider) })

// Vue.use(Web3)

const accountList = [
  {
      "id": 1,
      "accountNumber": 90964,
      "category": "Regional payment",
      "balance": "virtual indexing deliver",
      "currency": "invoice",
      "openingDate": "Wooden purple Developer",
      "customer": null
  },
  {
      "id": 2,
      "accountNumber": 90339,
      "category": "Hawaii bluetooth convergence",
      "balance": "Hat Associate empower",
      "currency": "Cambridgeshire",
      "openingDate": "Legacy 24/7",
      "customer": null
  },
  {
      "id": 3,
      "accountNumber": 11015,
      "category": "neutral quantifying Carolina",
      "balance": "Sharable",
      "currency": "evolve Division Universal",
      "openingDate": "e-business",
      "customer": null
  },
  {
      "id": 4,
      "accountNumber": 32174,
      "category": "Sausages Ergonomic",
      "balance": "invoice",
      "currency": "Refined Profound",
      "openingDate": "Operations Buckinghamshire",
      "customer": null
  },
  {
      "id": 5,
      "accountNumber": 7369,
      "category": "Technician New Dynamic",
      "balance": "mission-critical Chair Buckinghamshire",
      "currency": "withdrawal back navigate",
      "openingDate": "turn-key",
      "customer": null
  },
  {
      "id": 6,
      "accountNumber": 20,
      "category": "program grey Sausages",
      "balance": "6th",
      "currency": "architect Intelligent",
      "openingDate": "collaborative",
      "customer": null
  },
  {
      "id": 7,
      "accountNumber": 38681,
      "category": "Principal copy Shoes",
      "balance": "Architect",
      "currency": "streamline real-time",
      "openingDate": "hub copying Account",
      "customer": null
  },
  {
      "id": 8,
      "accountNumber": 70849,
      "category": "Regional heuristic",
      "balance": "Cotton",
      "currency": "radical",
      "openingDate": "copy state time-frame",
      "customer": null
  },
  {
      "id": 9,
      "accountNumber": 31240,
      "category": "Account Research",
      "balance": "navigate Unbranded Loan",
      "currency": "e-commerce",
      "openingDate": "Mexico Connecticut Checking",
      "customer": null
  },
  {
      "id": 10,
      "accountNumber": 96623,
      "category": "Naira",
      "balance": "visionary transmit azure",
      "currency": "Indonesia rich",
      "openingDate": "Generic benchmark functionalities",
      "customer": null
  },
  {
      "id": 11,
      "accountNumber": 273937547,
      "category": "1232",
      "balance": "50",
      "currency": "USD",
      "openingDate": "2020/05/11",
      "customer": {
          "id": 12,
          "title": "Mr",
          "givenNames": "Tafara",
          "familyName": "Mbano",
          "accountOfficer": 122,
          "street": "6020 Westlea",
          "town": "Harare",
          "country": "Zimbabwe",
          "gender": "Male",
          "email": "tmmmbano@gmail.com",
          "phoneNumber": 263783461408,
          "nationalID": "08-2009016J71"
      }
  },
  {
      "id": 12,
      "accountNumber": 23728382,
      "category": "156",
      "balance": "227938383",
      "currency": "ZWL",
      "openingDate": "2017/01/28",
      "customer": {
          "id": 12,
          "title": "Mr",
          "givenNames": "Tafara",
          "familyName": "Mbano",
          "accountOfficer": 122,
          "street": "6020 Westlea",
          "town": "Harare",
          "country": "Zimbabwe",
          "gender": "Male",
          "email": "tmmmbano@gmail.com",
          "phoneNumber": 263783461408,
          "nationalID": "08-2009016J71"
      }
  }
]

localStorage.setItem('accounts', JSON.stringify(accountList))


const customerList = [
  {
      "id": 1,
      "title": "Mr",
      "givenNames": "heuristic program",
      "familyName": "Investment Security",
      "accountOfficer": 24404,
      "street": "Hamill Trail",
      "town": "empower auxiliary experiences",
      "country": "Comoros",
      "gender": "Female",
      "email": "Nolan.Ledner@hotmail.com",
      "phoneNumber": 73750,
      "nationalID": "Rubber Chile",
      "bnkAccounts": null
  },
  {
      "id": 2,
      "title": "Prof",
      "givenNames": "Directives Soft Implementation",
      "familyName": "partnerships Uzbekistan intelligence",
      "accountOfficer": 76676,
      "street": "McCullough Corners",
      "town": "withdrawal",
      "country": "Niue",
      "gender": "Female",
      "email": "Raymond30@gmail.com",
      "phoneNumber": 80977,
      "nationalID": "quantifying transmit",
      "bnkAccounts": null
  },
  {
      "id": 3,
      "title": "Prof",
      "givenNames": "Peso",
      "familyName": "synthesize Lilangeni initiatives",
      "accountOfficer": 20939,
      "street": "Schaden View",
      "town": "Loan Lead",
      "country": "Nicaragua",
      "gender": "Female",
      "email": "Lawrence_Thiel@yahoo.com",
      "phoneNumber": 76782,
      "nationalID": "Handcrafted FTP",
      "bnkAccounts": null
  },
  {
      "id": 4,
      "title": "Dr",
      "givenNames": "hacking",
      "familyName": "Berkshire",
      "accountOfficer": 16417,
      "street": "Stokes Parkway",
      "town": "override",
      "country": "Kiribati",
      "gender": "Female",
      "email": "Sidney_Feeney@gmail.com",
      "phoneNumber": 82592,
      "nationalID": "Kenya UIC-Franc",
      "bnkAccounts": null
  },
  {
      "id": 5,
      "title": "Mrs",
      "givenNames": "Cotton",
      "familyName": "approach matrix Shoes",
      "accountOfficer": 83337,
      "street": "Kali Flats",
      "town": "Ball up",
      "country": "Colombia",
      "gender": "Female",
      "email": "Destiny84@yahoo.com",
      "phoneNumber": 25951,
      "nationalID": "Gourde Electronics bypass",
      "bnkAccounts": null
  },
  {
      "id": 6,
      "title": "Dr",
      "givenNames": "SAS Personal Egypt",
      "familyName": "Mississippi Litas Internal",
      "accountOfficer": 66626,
      "street": "Pablo Court",
      "town": "functionalities Meadows",
      "country": "Uganda",
      "gender": "Male",
      "email": "Shanel_Collins53@gmail.com",
      "phoneNumber": 18489,
      "nationalID": "quantify generating",
      "bnkAccounts": null
  },
  {
      "id": 7,
      "title": "Dr",
      "givenNames": "synthesizing Wisconsin Gorgeous",
      "familyName": "Unbranded Mouse transmit",
      "accountOfficer": 72944,
      "street": "Kiehn Park",
      "town": "microchip connecting",
      "country": "Guinea-Bissau",
      "gender": "Female",
      "email": "Rhett.Morar@hotmail.com",
      "phoneNumber": 27581,
      "nationalID": "Beauty XSS Curve",
      "bnkAccounts": null
  },
  {
      "id": 8,
      "title": "Dr",
      "givenNames": "Account",
      "familyName": "calculate Wall",
      "accountOfficer": 42217,
      "street": "Dax Parks",
      "town": "user system",
      "country": "New Caledonia",
      "gender": "Female",
      "email": "Keyshawn.Ratke@yahoo.com",
      "phoneNumber": 58540,
      "nationalID": "foreground SSL transparent",
      "bnkAccounts": null
  },
  {
      "id": 9,
      "title": "Mr",
      "givenNames": "uniform",
      "familyName": "JSON Data synthesize",
      "accountOfficer": 26080,
      "street": "Brandyn Shores",
      "town": "edge Springs Clothing",
      "country": "Italy",
      "gender": "Female",
      "email": "Mariane.Balistreri@hotmail.com",
      "phoneNumber": 10698,
      "nationalID": "open-source Health",
      "bnkAccounts": null
  },
  {
      "id": 10,
      "title": "Mrs",
      "givenNames": "Lakes Grocery Ball",
      "familyName": "Proactive Riel",
      "accountOfficer": 44158,
      "street": "Jonatan Stravenue",
      "town": "Pennsylvania payment Pound",
      "country": "Western Sahara",
      "gender": "Female",
      "email": "Reggie.Connelly12@yahoo.com",
      "phoneNumber": 35633,
      "nationalID": "concept Investor",
      "bnkAccounts": null
  },
  {
      "id": 11,
      "title": null,
      "givenNames": "Reserve Bank of",
      "familyName": "Zimbabwe",
      "accountOfficer": 121,
      "street": "Samora Machel",
      "town": "Harare",
      "country": "Zimbabwe",
      "gender": null,
      "email": "auctions@rbz.gov.zw",
      "phoneNumber": 782652352,
      "nationalID": "00-00000000A11",
      "bnkAccounts": null
  },
  {
      "id": 12,
      "title": "Mr",
      "givenNames": "Tafara",
      "familyName": "Mbano",
      "accountOfficer": 122,
      "street": "6020 Westlea",
      "town": "Harare",
      "country": "Zimbabwe",
      "gender": "Male",
      "email": "tmmmbano@gmail.com",
      "phoneNumber": 263783461408,
      "nationalID": "08-2009016J71",
      "bnkAccounts": null
  },
  {
      "id": 13,
      "title": null,
      "givenNames": "Rever",
      "familyName": null,
      "accountOfficer": null,
      "street": null,
      "town": null,
      "country": null,
      "gender": null,
      "email": null,
      "phoneNumber": null,
      "nationalID": null,
      "bnkAccounts": null
  }
]


localStorage.setItem('customers', JSON.stringify(customerList))


const users = [
  {
    'email': 'tmmmbano@gmail.com',
    'role': 'rbz_admin'
  },
  {
    'email': 'mbanotechworld@live.com',
    'role': 'authorised_dealer'
  }
]


localStorage.setItem('users', JSON.stringify(users))
localStorage.setItem('transactions', JSON.stringify([]))
localStorage.setItem('bidAmountHold', JSON.stringify([]))




new Vue({
  vuetify,
  router,
  web3: {
    // can bind to calls
    getAllPrimaryBids: {
      contract: fxAuction,
      method: 'getAllPrimaryBids',
      arguments: []
    },
    // can also bind to events
    // transfers: {
    //   contract: fxAuction,
    //   event: 'OwnershipTransferred',
    //   options: {
    //     fromBlock: 2
    //   }
    // }
  },
  render: h => h(App),
}).$mount('#app')
