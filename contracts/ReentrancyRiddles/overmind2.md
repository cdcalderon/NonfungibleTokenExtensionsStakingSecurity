# Overmint2 Contract Exploitation

The `Overmint2` contract is an ERC721 contract that has a vulnerability that allows an attacker to hold more than the maximum number of NFTs per address. The vulnerability can be exploited by transferring the NFTs to another address and then back to the original address. However, by using `_safeMint()` instead of `_mint()`, this vulnerability can be prevented.

## Vulnerability

The `Overmint2` contract allows an address to hold a maximum of 3 NFTs. However, an attacker can exploit the vulnerability by following these steps:

1. Call `mint()` function four times and own the NFTs with token IDs 1, 2, 3, and 4.
2. Transfer the NFTs with IDs 1, 2, 3, and 4 to another address.
3. Call the `mint()` function to own the NFT with ID 5.
4. Transfer the NFTs with IDs 1, 2, 3, and 4 back to the original address.

At this point, the attacker can call the `success()` function, which will return `true` and indicate that the address holds 5 NFTs.

## Prevention

To prevent this vulnerability, we can use `_safeMint()` instead of `_mint()`. The `_safeMint()` function checks whether the receiver address is a contract or not. If it is a contract, then it will call the `onERC721Received()` function in the receiver contract. This prevents the NFTs from being transferred to an address that is not a contract, which prevents the exploit described above.
