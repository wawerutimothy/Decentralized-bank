import os
from brownie import accounts, USDC, AUSD, DEfi_bank
from dotenv import load_dotenv
load_dotenv()

def main():
    account = accounts.add(os.getenv("PRIVATE_KEY"))
    usdc_addr = USDC.deploy({"from": account})
    ausd_addr = AUSD.deploy({"from": account})

    DEfi_bank.deploy(usdc_addr, ausd_addr, {"from": account})


