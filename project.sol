// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract GroupLearningChallenge {

    // Struct to represent a group
    struct Group {
        uint256 id;
        string name;
        address[] members;
        uint256[] tasksCompleted;
    }

    // Struct to represent a task
    struct Task {
        uint256 id;
        string description;
        uint256 reward; // Reward amount for the task
        bool isCompleted;
        address completedBy;
    }

    // State variables
    uint256 public groupCount;
    uint256 public taskCount;
    address public owner;
    address public rewardToken;

    mapping(uint256 => Group) public groups;
    mapping(uint256 => Task) public tasks;

    event GroupCreated(uint256 indexed groupId, string name, address[] members);
    event TaskAssigned(uint256 indexed taskId, uint256 indexed groupId, string description, uint256 reward);
    event TaskCompleted(uint256 indexed taskId, address completedBy);

    // Constructor to initialize the reward token
    constructor(address _rewardToken) {
        owner = msg.sender;
        rewardToken = _rewardToken;
    }

    // Modifier to restrict access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    // Create a new group
    function createGroup(string memory _name, address[] memory _members) external onlyOwner {
        require(bytes(_name).length > 0, "Group name cannot be empty.");
        require(_members.length > 0, "Group must have at least one member.");

        groupCount++;
        groups[groupCount] = Group({
            id: groupCount,
            name: _name,
            members: _members,
            tasksCompleted: new uint256[](0)
        });

        emit GroupCreated(groupCount, _name, _members);
    }

    // Assign a new task to a group
    function assignTask(uint256 _groupId, string memory _description, uint256 _reward) external onlyOwner {
        require(groups[_groupId].id != 0, "Group does not exist.");
        require(bytes(_description).length > 0, "Task description cannot be empty.");
        require(_reward > 0, "Reward must be greater than zero.");

        taskCount++;
        tasks[taskCount] = Task({
            id: taskCount,
            description: _description,
            reward: _reward,
            isCompleted: false,
            completedBy: address(0)
        });

        emit TaskAssigned(taskCount, _groupId, _description, _reward);
    }

    // Mark a task as completed
    function completeTask(uint256 _taskId) external {
        Task storage task = tasks[_taskId];
        require(!task.isCompleted, "Task already completed.");
        task.isCompleted = true;
        task.completedBy = msg.sender;

        // Add task to the group's completed tasks
        for (uint256 i = 1; i <= groupCount; i++) {
            Group storage group = groups[i];
            for (uint256 j = 0; j < group.members.length; j++) {
                if (group.members[j] == msg.sender) {
                    group.tasksCompleted.push(_taskId);
                    break;
                }
            }
        }

        // Reward the participant dynamically based on the task's reward
        IERC20(rewardToken).transfer(msg.sender, task.reward);

        emit TaskCompleted(_taskId, msg.sender);
    }

    // Fetch group details
    function getGroup(uint256 _groupId) external view returns (Group memory) {
        return groups[_groupId];
    }

    // Fetch task details
    function getTask(uint256 _taskId) external view returns (Task memory) {
        return tasks[_taskId];
    }
}
