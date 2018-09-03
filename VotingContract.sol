// This file contains educational comments
// usual function comments and better practice comments.

/* First run */

pragma solidity ^0.4.18;
// the above is the version used to compile and 
// it implies that this code will work while using this
// version or above. Finally it is good practice to add
// this line so as to know which version was used.

contract TransparentElection {
    
    // The following is an event called when a Candidate
    // is added. The candidate information will be
    // displayed by the frontend.
    // Any candidates added will have an element candidates
    // which will be used to identify and vote for a 
    // candidate in the function "vote".
    // Values will be passed into the event and will be 
    // logged in the transaction's log.
    event NewCandidate(uint candidateID);
    
    // A struct will hold multiple variables and or
    // attributes. In thi contract it will describe
    // the Voter, with an id of their own and the id
    // of the candidate they voted for.
    
    struct Voter {
        bytes32 uid; 
        // using bytes32 for arbitrary-length raw byte data 
        // instead of using string as using bytes is cheaper.
        // EVM is optimized for dealing with data in chunks of 32 bytes.
        uint candidateIDVote;
    }
    
    // Another struct, just like "Voter", but for describing
    // the Candidate with a name  and a party.
    struct Candidate {
        bytes32 name;
        bytes32 party;
        // Adding a boolean to check if the Struct exists
        // mainly to keep track of the candidates.
        bool doesExist;
    }
    
    // I will now declare variables that are meant to be 
    // stored permanently on the Blockchain, which are called
    // State Variables.
    uint numberOfCandidates; //implied.
    uint numberOfVoters; // implied.
    
    /* mapping is similar to hash map, with a key as a uint and a value
    of one of the above structs. */
    // I will use them to hold the candidates and the voters.
    mapping (uint => Candidate) candidates;
    mapping (uint => Voter) voters;
    
    /*I will now create functions, which are executables of smart
    contracts and as such, they will interact with the Blockchain*/
    
    // These functions perform transactions (edit the mappings)
    function addCandidate(bytes32 name, bytes32 party) public {
        // candidateID is the return variable
        uint candidateID = numberOfCandidates++;
        // Create new Candidate Struct with name and saves it to storage.
        candidates[candidateID] = Candidate(name,party,true);
        NewCandidate(candidateID);
    }    
    
    function vote(bytes32 uid, uint candidateID) public {
        // checks if the struct exists for that candidate
        if (candidates[candidateID].doesExist == true) {
            uint voterID = numberOfVoters++; // return variable.
            voters[voterID] = Voter(uid, candidateIDVote);
        }
    }
    
    //These are Getter functions, marked by the key word "view"
    
    /*Finds total amount of votes for a candidate by looping
    through voters*/
    
    function totalVotes(uint candidateID) view public returns (uint) {
        uint numberOfVotes = 0; // will return this.
        for (uint i = 0; i < numberofVotes; i++) {
            // incremented per vote
            if (voters[i].candidateIDVote == candidateID) {
                numberOfVotes++;
            }
        }
        return numberOfVotes;
    }
    
    function getNumberOfCandidates() public view returns(uint) {
        return numberCandidates;
    }
    
    function getNumberOfVoters() public view(uint) {
        return numberVoters;
    }
    
    //return candidate info (ID, name, party)
    function getCandidate(uint candidateID) public view returns(uint, bytes32, bytes32) {
        return (candidateID, candidates[candidateID].name,candidates[candidateID].party);
    }
    
    
}
