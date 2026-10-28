# -*- coding: utf-8 -*-
import hashlib
import time
import json

class ArbitrumAccountInsuranceActuary:
    def __init__(self, stylus_runtime: str = "WASM Arbitrum Stylus"):
        self.stylus_runtime = stylus_runtime

    def assess_smart_account_vulnerability(self, account_addr: str, balance_eth: float) -> dict:
        risk_factor = 0.015 if balance_eth < 10 else 0.035
        premium = balance_eth * risk_factor
        return {
            "account": account_addr,
            "runtime": self.stylus_runtime,
            "insured_balance_eth": balance_eth,
            "premium_annual_eth": round(premium, 4),
            "erc4337_paymaster_compatible": True,
            "social_recovery_included": True,
            "timestamp": int(time.time())
        }

if __name__ == "__main__":
    actuary = ArbitrumAccountInsuranceActuary()
    res = actuary.assess_smart_account_vulnerability("0x71C...49B2", 15.5)
    print("Arbitrum Smart Account Insurance Quote:", json.dumps(res, indent=2))
