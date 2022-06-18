import os
from brownie import Contract, accounts
from dotenv import load_dotenv
load_dotenv()

def main():
    account = accounts.add(os.getenv("PRIVATE_KEY"))
    usdc_contract = Contract('0x7974dAd3b5D2fb4493B1a40B1ad6a195FDaBCc55')
    defi_contract = Contract('0x88f15Eb13706b358FC144F18f3EF522335c48248 ')

    print(f"usdc token deposit balance before deposit is {defi_contract.deposited_balance(account)}")

    usdc_contract.approve(defi_contract, 100000, {"from": account})
    defi_contract.depositToken(100000, {"from": account})

    print(f"usdc token deposit balance after deposit is {defi_contract.deposited_balance(account)}")

    defi_contract.withdrawToken(25000, {"from": account})
    print(f"usdc token deposit balance after withdrawal is {defi_contract.deposited_balance(account)}")