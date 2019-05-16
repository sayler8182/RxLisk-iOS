Swift 5 library for Lisk Blockchain
==========

RxLisk is a Swift 5 library for [Lisk](https://lisk.io)  - the cryptocurrency and blockchain application platform. 
It allows developers to interact with the core Lisk API, for retrieval of collections and single records of data located on the Lisk blockchain. 
Its does't require a locally installed Lisk node, and instead utilizes the existing peers on the network (mainnet or testnet). It can be used on iOS environment.

Lisk Swift is heavily inspired by [Lisk Swift](https://github.com/AndrewBarba/lisk-swift) and [Lisk JS](https://github.com/LiskHQ/lisk-js)

## Features

- [x] Local Signing for maximum security
- [x] Targets Lisk 1.6.0 API
- [x] Based on lisk-swift and lisk-js
- [x] Swift 5.0
- [x] Unit Tests
- [ ] Documentation

## API

- [x] Accounts
- [x] Blocks
- [ ] Dapps
- [x] Delegates
- [ ] Node
- [x] Peers
- [ ] Signatures
- [x] Transactions
- [x] Voters
- [x] Votes

## Requirements

- iOS 10.0+ 
- Xcode 10.0+
- Swift 5.0+ 

## Installation

### Swift Package Manager

TODO:

### CocoaPods

TODO:

### Carthage

TODO:

## Dependencies

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [RxAtomic](https://github.com/ReactiveX/RxSwift)
- [RxOptional](https://github.com/RxSwiftCommunity/RxOptional)
- [RxRelay](https://github.com/ReactiveX/RxSwift)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [RxTest](https://github.com/ReactiveX/RxSwift)

## Usage

### Import Framework

```swift
import RxLisk
```

### Environment

By default, all modules are initialized with an `LiskNodeConfig` pointing to the Lisk Mainnet. You can optionally pass in a specific client to any modules constructor:

```swift
// mainnet
let mainTransactions = LiskTransactions()

// testnet
let testTransactions = LiskTransactions(nodeConfig: .testnet)

// custom
let customNodeConfig = LiskNodeConfig(
    ssl: true,
    node: LiskNode(hostname: "custom.host.name"),
    port: 8888)
let customTransactions = LiskTransactions(nodeConfig: customNodeConfig)
```

### Accounts

#### All accounts 

```swift
let accountsModule = LiskAccounts()

// get accounts
module
    .accounts()
    .subscribe(
        onSuccess: { (accounts) in
            print(accounts.meta.offset)
            print(accounts.data.count) },
        onError: { (error) in
            print(error.localizedDescription) }
    )
```

#### Account with specific address

```swift
let address = ...
let accountsModule = LiskAccounts()

// get account info
module
    .account(address: address)
    .subscribe(
        onSuccess: { (account) in
            print(account.balance) },
        onError: { (error) in
            print(error.localizedDescription) }
    )
```

### Send LSK

```swift
let recipientId = ...
let secret = ...
let transactionsModule = LiskTransactions()

// sign transaction
try transaction.sign(secret: secret)

// send transaction
transactionsModule
    .sendTransaction(transaction: transaction) 
    .subscribe(
        onSuccess: { (response) in
            print(response.meta.status)
            print(response.data.message) },
        onError: { (error) in
            print(error.localizedDescription) }
    )
}
```  

## Thank You

To show support for continued development feel free to donate LSK to `8985905004777775964L`

Or vote delegate who was an inspiration: [andrew](https://explorer.lisk.io/delegate/14987768355736502769L)
