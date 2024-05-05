

// pragma solidity ^0.8.11;

// contract Lottery {
//     address public owner;
//     address payable[] public players;
//     uint public lotteryId;
//     mapping(uint => address payable) public lotteryHistory;
//     bool public winnerPicked;
//     uint public randomResult;

//     constructor() {
//         owner = payable(msg.sender);
//         lotteryId = 1;
//     }

//     function getRandomNumber() internal view returns (uint) {
//         return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
//     }

//     function getWinnerByLottery(uint lottery) public view returns (address payable) {
//         return lotteryHistory[lottery];
//     }

//     function getBalance() public view returns (uint) {
//         return address(this).balance;
//     }

//     function getPlayers() public view returns (address payable[] memory) {
//         return players;
//     }

//     function enter() public payable {
//         require(msg.value > 0.01 ether, "Insufficient amount sent");

//         players.push(payable(msg.sender));
//     }

//     function pickWinner() public onlyOwner {
//         require(players.length > 0, "No players participated in the lottery");
//         require(!winnerPicked, "Winner already picked for this round");
//         randomResult = getRandomNumber();
//         winnerPicked = true;
//     }

//     function payWinner() public onlyOwner {
//         require(randomResult > 0, "Must have a source of randomness before choosing winner");
//         require(players.length > 0, "No players participated in the lottery");

//         require(winnerPicked, "Winner has not been picked yet");

//         uint index = randomResult % players.length;
//         players[index].transfer(address(this).balance);

//         lotteryHistory[lotteryId] = players[index];
//         lotteryId++;

//         // Reset the state of the contract
//         delete players;
//         randomResult = 0;
//         winnerPicked = false;
//     }

//     modifier onlyOwner() {
//         require(msg.sender == owner, "Only the owner can call this function");
//         _;
//     }
// }
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract Lottery {
    address public owner;
    address payable[] public players;
    uint public lotteryId;
    //uint public participationEndTime;
    //uint public lotteryDuration = 180; // 3 minutes in seconds
    mapping(uint => address payable) public lotteryHistory;
    bool public winnerPicked;
    uint public randomResult;
    uint public countdownEnd;

    constructor() {
        owner = payable(msg.sender);
        lotteryId = 1;
        countdownEnd = 0; // Initialize to 0
    }

    modifier onlyAfterCountdownEnd() {
        require(countdownEnd != 0, "Lottery is not started");
        require(countdownEnd > 0 && block.timestamp >= countdownEnd, "Countdown has not ended yet");
        require(!winnerPicked, "Winner has already been picked");
        _;
    }

    function getRandomNumber() internal view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }

    function getWinnerByLottery(uint lottery) public view returns (address payable) {
        return lotteryHistory[lottery];
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    function startLottery() public onlyOwner {
        require(countdownEnd == 0, "Lottery is already running");
        countdownEnd = block.timestamp + 180; // 3 minutes countdown
    }

    function enter() public payable {
        require(msg.value  > .01 ether, "Enter exactly 0.15 ether to participate");
        require(countdownEnd > 0 && block.timestamp < countdownEnd, "Cannot enter before starting or after time over");
        players.push(payable(msg.sender));
    }

    function pickWinner() public onlyOwner onlyAfterCountdownEnd {
        require(players.length > 0, "No players participated in the lottery");
        // require(!winnerPicked, "Winner already picked for this round");

        randomResult = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
        winnerPicked = true;
    }

    function payWinner() public onlyOwner {
        require(winnerPicked, "Winner must be picked before paying");
        require(players.length > 0, "No players participated in the lottery");

        uint index = randomResult % players.length;
        address payable winner = players[index];

        winner.transfer(address(this).balance);
        lotteryHistory[lotteryId] = winner;
        lotteryId++;

        // Reset the state of the contract
        delete players;
        randomResult = 0;
        winnerPicked = false;
        countdownEnd = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}

