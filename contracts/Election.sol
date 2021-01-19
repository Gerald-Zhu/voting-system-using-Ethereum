pragma solidity ^0.5.12;

contract Election{
    //投票的选项
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters;
    //授权用户
    mapping(address => bool) public rightvote;
    mapping(uint => Candidate) public candidates;
    
    uint public candidatesCount;

     address public chairperson;

    event votedEvent(
        uint indexed _candidateId
    );
    //事件
     event girightEvent(
        address _giright
    );
    constructor() public {
        chairperson = msg.sender;
        addCandidate("Biden");
        addCandidate("Trump"); 
    }

   //增加一个投票的选项
    function addCandidate (string memory _name) public{
         require(chairperson==msg.sender);
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public{
        //判断授权用户
        require(rightvote[msg.sender]);

        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        voters[msg.sender] = true;
        //结束授权
        rightvote[msg.sender] = false;
        candidates[_candidateId].voteCount ++;
        emit votedEvent(_candidateId);

    }

//授权函数
    function giright (address _giright) public{
        require(chairperson==msg.sender);
        rightvote[_giright] = true;
        
        emit girightEvent(_giright);

    }
}
