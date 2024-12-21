# GroupLearningChallenge Smart Contract

The **GroupLearningChallenge** is a Web3.0-based smart contract that facilitates group-based learning challenges. It enables the creation of groups, assignment of tasks, and dynamic reward distribution using ERC20 tokens.

---

## Features

- **Group Management**: Create and manage groups of learners.
- **Task Management**: Assign tasks to groups with specific rewards.
- **Dynamic Rewards**: Reward participants with ERC20 tokens upon task completion.
- **Transparency**: All transactions are recorded on the blockchain.

---

**Contract Address**

0x7190d2300596827918D4537a4D8Aa78c5E3d0599
<img width="942" alt="image" src="https://github.com/user-attachments/assets/5d8494dd-af72-4daf-869c-77b0ed258e48" />

---

**Key Functions**

1. **`createGroup(string memory _name, address[] memory _members)`**
   - Creates a new group.
   - Emits: `GroupCreated`

2. **`assignTask(uint256 _groupId, string memory _description, uint256 _reward)`**
   - Assigns a task to a specific group with a reward.
   - Emits: `TaskAssigned`


3. **`completeTask(uint256 _taskId)`**
   - Marks a task as completed and transfers the reward to the participant.
   - Emits: `TaskCompleted`

4. **`getGroup(uint256 _groupId)`**
   - Fetches the details of a group.

5. **`getTask(uint256 _taskId)`**
   - Fetches the details of a task.

---
**Future improvement**

1. **Task Assignment to Multiple Groups**:
   Allow tasks to be assigned to multiple groups simultaneously.

2. **Deadline Management**:
   Introduce deadlines for tasks and auto-expire them if not completed within the specified timeframe.

3. **Penalty Mechanism**:
   Add penalties for incomplete or overdue tasks.

4. **Leaderboard**:
   Implement a leaderboard to showcase group and individual performance.

5. **Flexible Rewards**:
   Enable dynamic reward calculation based on task complexity or participation level.

6. **Custom Role Management**:
   Allow group admins to manage tasks and members within their respective groups.

7. **NFT Rewards**:
   Introduce NFTs as optional rewards for task completion.

8. **Multi-token Support**:
   Support multiple reward tokens and allow groups to choose their preferred token.

9. **Integration with External Platforms**:
   Integrate with learning platforms (e.g., Coursera, Udemy) to validate task completion.

10. **User Reputation System**:
    Implement a reputation system for members based on their task completion history.


