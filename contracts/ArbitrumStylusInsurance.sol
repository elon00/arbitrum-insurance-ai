// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ArbitrumStylusInsurance
 * @dev Cross-L2 Smart Account & Bridge Security Insurance Protocol
 */
contract ArbitrumStylusInsurance {
    struct AccountProtectionPolicy {
        address smartAccount;
        address backupGuardian;
        uint256 insuredBalanceCap;
        uint256 premiumPaid;
        bool isActive;
    }

    mapping(address => AccountProtectionPolicy) public policies;
    uint256 public totalAccountsProtected;

    event PolicyRegistered(address indexed account, address indexed guardian, uint256 cap);
    event RecoveryClaimExecuted(address indexed account, address indexed newOwner, uint256 compensation);

    function registerAccountCoverage(address backupGuardian, uint256 balanceCap) external payable {
        require(msg.value > 0, "Zero premium");
        policies[msg.sender] = AccountProtectionPolicy({
            smartAccount: msg.sender,
            backupGuardian: backupGuardian,
            insuredBalanceCap: balanceCap,
            premiumPaid: msg.value,
            isActive: true
        });

        totalAccountsProtected += 1;
        emit PolicyRegistered(msg.sender, backupGuardian, balanceCap);
    }

    function executeAccountRecoveryClaim(address compromisedAccount, address newOwner) external {
        AccountProtectionPolicy storage p = policies[compromisedAccount];
        require(p.isActive, "Policy inactive");
        require(msg.sender == p.backupGuardian, "Only guardian can recover");

        p.isActive = false;
        payable(newOwner).transfer(p.insuredBalanceCap);
        emit RecoveryClaimExecuted(compromisedAccount, newOwner, p.insuredBalanceCap);
    }
}
