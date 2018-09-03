pragma solidity ^0.4.22;
contract TestContract{
    string constant messageKeeper = "I'm in the blockchain";
    function getTestContract() public returns(string){
        return messageKeeper;
    }
}
