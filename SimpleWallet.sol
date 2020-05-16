pragma solidity ^0.6.0;

import "./Allowance.sol";

contract SimpleWallet is Allowance {
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contract.");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    
    function renounceOwnership() public onlyOwner override {
        revert ("Can't renounce ownership here.");
    }
    
    // Should be a fallback function
    function receiveMoney() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}