/*
file:   TokenManager.sol

A basic contract for Managing fiat pegged tokens


*/

pragma solidity ^0.4.13;

import "./Account.sol";

contract TokenManager
{


/* State Variables */

 uint public centralOffice;
 Account account;

/* Events */

/*public event when central office changes*/
event ChangedCentralOffice(address newCentralOffice);

event CentralOfficeCreated(string created);
/* Modifiers */

       // To throw call not made by centralOffice
    modifier onlyCentralOffice() {
        require (msg.sender == account.getAddress(centralOffice));
        _;
    }
    
/* Functions */

    function TokenManager(address _accountContract)public { 
        centralOffice = 11223344; 
        account =  Account(_accountContract);
        account.createAccount(msg.sender,11223344,0,1234);
        CentralOfficeCreated("Central Office created");
    }

    function contractBalance() public constant returns(uint) {
        return this.balance;
    }

    // Change the owner of a central office
    function changeCentralOffice(address _newCentralOffice,uint _pin)
        public onlyCentralOffice returns (bool)
    {
        
        account.changeCentralOffice(centralOffice,_newCentralOffice, _pin);
        ChangedCentralOffice(_newCentralOffice);
        return true;
    }
    
    function getCentralOffice() public constant returns(address)
    {
        return account.getAddress(centralOffice);
    }
    
 
}

/* End of Base */