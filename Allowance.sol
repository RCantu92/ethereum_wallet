pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    
    using SafeMath for uint;
    
    event AllowanceChanged(address indexed _forWhom, address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    
    mapping(address => uint) public allowance;
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    function isOwner() public view returns(bool) {
        return msg.sender == owner();
        
    }
    
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed.");
        _;
    }
    
    function reduceAllowance(address _who, uint _amount) internal {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
    
}