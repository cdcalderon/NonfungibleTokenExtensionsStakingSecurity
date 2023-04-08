// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/Ownable.sol";

// contract TwoStepOwnable is Ownable {
//     bool private _transferConfirmedByOwnerCandidate;
//     address private _ownerCandidate;

//     function transferOwnership(
//         address newOwnerCandidate
//     ) public virtual onlyOwner {
//         _ownerCandidate = newOwnerCandidate;
//     }

//     function confirmOwnershipTransfer() public virtual {
//         if (_transferConfirmedByOwnerCandidate) {
//             require(
//                 owner() == _msgSender(),
//                 "TwoStepOwnable: caller is not the owner"
//             );
//             _transferConfirmedByOwnerCandidate = false;
//             _setOwner(_ownerCandidate);
//         } else {
//             require(
//                 _ownerCandidate == _msgSender(),
//                 "TwoStepOwnable: caller is not the owner candidate"
//             );
//             _transferConfirmedByOwnerCandidate = true;
//         }
//     }
// }
