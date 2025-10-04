
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WhistleBlower {

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    struct Report {
        uint id;
        string ipfsHash;
        address reporter;
        bool solved;
	    uint256 createdAt;
    	uint256 solvedAt;
    }

    constructor() {
        owner = msg.sender;
    }

    uint public reportCount;
    mapping(uint => Report) public reports;
    mapping(address => uint[]) public userReports;

    event NewReport(uint id,string ipfsHash,address indexed reporter,uint256 createdAt);
    event ReportSolved(uint id,address indexed solver,uint256 solvedAt);

    function submitReport(string memory _ipfsHash) public {
        reports[reportCount] = Report(reportCount, _ipfsHash,msg.sender,false,block.timestamp,0);
        userReports[msg.sender].push(reportCount);
        emit NewReport(reportCount,_ipfsHash,msg.sender,block.timestamp);
        reportCount++;
    }

    function getReport(uint _id) public view returns (string memory,address,bool,uint256,uint256) {
        require(_id < reportCount, "Invalid report ID");
        Report storage report = reports[_id];
        return (report.ipfsHash,report.reporter,report.solved,report.createdAt,report.solvedAt);
    }

    function getUserReports(address _user) public view returns (uint[] memory) {
        return userReports[_user];
    }

    function solveReport(uint _id) public onlyOwner {
        require(_id < reportCount, "Invalid report ID");
        require(!reports[_id].solved, "Report already solved");
        reports[_id].solved = true;
	    reports[_id].solvedAt = block.timestamp;
        emit ReportSolved(_id,msg.sender,block.timestamp);
    }
}