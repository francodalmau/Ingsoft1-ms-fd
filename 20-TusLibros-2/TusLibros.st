!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'MS 11/22/2020 16:52:15'!
test01ACashierCanNotReceiveAnEmptyCart

	|aCart aCashier|
	
	aCart := self createCart.
	
	aCashier := Cashier new.
	
	self  should: [aCashier checkOut: aCart with: self validCardNumber and: self validExpirationDate from: self validOwner] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier canNotCheckOutAnEmptyCartErrorDescription.
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/25/2020 18:41:45'!
test02ACashierCanNotCheckOutWhenItReceivesAnInvalidCardNumber

	|aCatalog aCart aCashier aMerchantProcessorSimulator|
	
	aCatalog:= Array new.
	aCart := self createCart.
	aCart add: 2 of: self itemSellByTheStore. 
	
	
	aMerchantProcessorSimulator:= WorkingMerchantProcessor new.
	
	aCashier := Cashier acceptingItemsOf: aCatalog for: aMerchantProcessorSimulator.
	
	self  should: [aCashier checkOut: aCart with: self invalidCreditCardNumber and: self validExpirationDate  from: self validOwner] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier canNotCheckOutACartWithAnInvalidCardNumberErrorDescription.
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/25/2020 18:41:29'!
test03ACashierCanNotCheckOutWhenItReceivesAnInvalidExpirationDate

	|aCatalog aCart aCashier aMerchantProcessorSimulator|
	
	aCatalog:= Array new.
	aCart := self createCart.
	aCart add: 2 of: self itemSellByTheStore. 
	
	aMerchantProcessorSimulator:= WorkingMerchantProcessor new.
	
	aCashier := Cashier acceptingItemsOf: aCatalog for: aMerchantProcessorSimulator.
	
	self  should: [aCashier checkOut: aCart with: self validCardNumber and: self invalidExpirationDate  from: self validOwner] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier canNotCheckOutACartWithAnInvalidExpirationDateErrorDescription.
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/25/2020 18:40:55'!
test04ACashierCanNotCheckOutWhenItReceivesAnInvalidOwner

	|aCatalog aCart aCashier aMerchantProcessorSimulator|
	
	aCatalog:= Array new.
	aCart := self createCart.
	aCart add: 2 of: self itemSellByTheStore. 
	
	aMerchantProcessorSimulator:= WorkingMerchantProcessor new.
	
	aCashier := Cashier acceptingItemsOf: aCatalog for: aMerchantProcessorSimulator.
	
	self  should: [aCashier checkOut: aCart with: self validCardNumber and: self validExpirationDate from: self invalidOwner] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier canNotCheckOutACartWithAnInvalidOwnerErrorDescription.
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/25/2020 17:33:41'!
test05ACashierPerformsASuccessfulCheckOut

	|aCatalog aCart aCashier aMerchantProcessorSimulator|
	
	aCatalog:= Dictionary new.
	aCatalog add: 'aBook' -> 40.
	aCart := Cart acceptingItemsOf: aCatalog keys.
	aCart add: 2 of: 'aBook'. 
	
	aMerchantProcessorSimulator:= WorkingMerchantProcessor new.
	
	aCashier := Cashier acceptingItemsOf: aCatalog for: aMerchantProcessorSimulator.
	
	aCashier checkOut: aCart with: self validCardNumber and: self validExpirationDate from: self validOwner.
	
	self assert: aMerchantProcessorSimulator receivedCheckoutAmount equals: 80.
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/25/2020 17:33:22'!
test06ACashierCanNotPerformsASuccessfulCheckOutWhenMerchantProcessorIsNotWorking

	|aCatalog aCart aCashier aMerchantProcessorSimulator|
	
	aCatalog:= Dictionary new.
	aCatalog add: 'aBook' -> 40.
	aCart := Cart acceptingItemsOf: aCatalog keys.
	aCart add: 2 of: 'aBook'. 
	
	aMerchantProcessorSimulator:= FailingMerchantProcessor new.
	
	aCashier := Cashier acceptingItemsOf: aCatalog for: aMerchantProcessorSimulator.
	
	self  should: [aCashier checkOut: aCart with: self validCardNumber and: self validExpirationDate  from: self validOwner] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier merchantProcessorIsNotWorkingErrorDescription.
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/25/2020 18:10:51'!
test07ACashierCanNotCheckOutWhenTheTransactionAmountIsTooBig

	|aCatalog aCart aCashier aMerchantProcessorSimulator|
	
	aCatalog:= Dictionary new.
	aCatalog add: 'aBook' -> 4000000000000000000000000000000000000000.
	aCart := Cart acceptingItemsOf: aCatalog keys.
	aCart add: 2 of: 'aBook'. 
	
	aMerchantProcessorSimulator:= WorkingMerchantProcessor new.
	
	aCashier := Cashier acceptingItemsOf: aCatalog for: aMerchantProcessorSimulator.
	
	self  should: [aCashier checkOut: aCart with: self validCardNumber and: self validExpirationDate  from: self validOwner] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier InvalidTransactionAmountErrorDescription.
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/25/2020 18:23:08'!
test08ACashierCanNotCheckOutWhenTheTransactionAmountIsHasTooManyDecimals

	|aCatalog aCart aCashier aMerchantProcessorSimulator|
	
	aCatalog:= Dictionary new.
	aCatalog add: 'aBook' -> 40.0000005.
	aCart := Cart acceptingItemsOf: aCatalog keys.
	aCart add: 2 of: 'aBook'. 
	
	aMerchantProcessorSimulator:= WorkingMerchantProcessor new.
	
	aCashier := Cashier acceptingItemsOf: aCatalog for: aMerchantProcessorSimulator.
	
	self  should: [aCashier checkOut: aCart with: self validCardNumber and: self validExpirationDate  from: self validOwner] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier InvalidTransactionAmountErrorDescription.
	
	! !


!CashierTest methodsFor: 'support' stamp: 'MS 11/19/2020 19:39:59'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/19/2020 19:40:11'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/22/2020 15:30:28'!
invalidCreditCardNumber
	
	^'a'.! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/22/2020 15:45:26'!
invalidExpirationDate
	
	^'a'. ! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/22/2020 16:13:49'!
invalidOwner
	
	^'more than thirty characters woooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo'.! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/19/2020 19:40:29'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/19/2020 19:40:42'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/22/2020 15:29:10'!
validCardNumber
	
	^1234.! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/25/2020 17:08:00'!
validExpirationDate
	
	^GregorianMonthOfYear yearNumber: 2030 monthNumber: 8.! !

!CashierTest methodsFor: 'support' stamp: 'MS 11/22/2020 16:11:04'!
validOwner
	^'Valid Owner'.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'catalog merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'MS 11/25/2020 16:53:45'!
assertCartNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self signalCartNotEmpty]! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/25/2020 17:24:48'!
assertRequestWasSuccesful: statusCode

	statusCode = 0 ifFalse:[ self signalMerchantProcessorIsNotWorking].! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/25/2020 18:29:13'!
assertTrasactionAmountIsValid: anAmount
	
		((self numberHasLessThanFifteenDigits: anAmount) and:
		(self hasTooManyDecimals:anAmount))
		
		ifFalse: [self signalInvalidTransactionAmountErrorDescription].! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/22/2020 17:14:01'!
assertValidCreditCardNumber: aNumber

	^ (aNumber isInteger) ifFalse: [self signalInvalidCreditCardNumber]! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/25/2020 16:51:10'!
assertValidExpirationDate: aDate

	^ (aDate isKindOf: GregorianMonthOfYear) ifFalse: [self signalInvalidExpirationDate]! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/22/2020 16:34:18'!
assertValidOwner: anOwner

	^ (anOwner size <= 30) ifFalse: [self signalInvalidOwner]! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/25/2020 18:30:59'!
hasTooManyDecimals: anAmount

  ^((anAmount*100) fractionPart = 0.0).! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/25/2020 18:27:04'!
numberHasLessThanFifteenDigits: anAmount

	^ (anAmount asInteger numberOfDigitsInBase: 10) <= 15! !

!Cashier methodsFor: 'assertions' stamp: 'MS 11/22/2020 16:27:53'!
validateCreditCardWith: aNumber and: aDate from: anOwner

	self assertValidCreditCardNumber: aNumber.
	self assertValidExpirationDate: aDate.
	self assertValidOwner: anOwner.
	! !


!Cashier methodsFor: 'signals' stamp: 'MS 11/25/2020 16:53:45'!
signalCartNotEmpty

	^ self error: self class canNotCheckOutAnEmptyCartErrorDescription! !

!Cashier methodsFor: 'signals' stamp: 'MS 11/22/2020 16:35:02'!
signalInvalidCreditCardNumber

	^ self error: self class canNotCheckOutACartWithAnInvalidCardNumberErrorDescription! !

!Cashier methodsFor: 'signals' stamp: 'MS 11/22/2020 16:34:39'!
signalInvalidExpirationDate

	^ self error: self class canNotCheckOutACartWithAnInvalidExpirationDateErrorDescription! !

!Cashier methodsFor: 'signals' stamp: 'MS 11/22/2020 16:34:17'!
signalInvalidOwner

	^ self error: self class canNotCheckOutACartWithAnInvalidOwnerErrorDescription! !

!Cashier methodsFor: 'signals' stamp: 'MS 11/25/2020 18:21:56'!
signalInvalidTransactionAmountErrorDescription

	^ self error: self class InvalidTransactionAmountErrorDescription! !

!Cashier methodsFor: 'signals' stamp: 'MS 11/25/2020 17:21:09'!
signalMerchantProcessorIsNotWorking

	^ self error: self class merchantProcessorIsNotWorkingErrorDescription! !


!Cashier methodsFor: 'initialization' stamp: 'MS 11/22/2020 17:11:08'!
initializeAcceptingItemsOf: aCatalog for: aMerchantProcessor 

	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'actions' stamp: 'MS 11/25/2020 18:16:23'!
checkOut: aCart with: aNumber and: aDate from: anOwner

	|checkOutTotal statusCode|
	checkOutTotal  := 0.

	self validateCreditCardWith: aNumber and: aDate from: anOwner. 
	
	self assertCartNotEmpty: aCart.
	
	checkOutTotal := catalog keys sum: [:item |(catalog at: item) * (aCart occurrencesOf: item)] ifEmpty:[0].
	self assertTrasactionAmountIsValid: checkOutTotal.
	
	statusCode:= merchantProcessor checkOut: checkOutTotal with: aNumber and: aDate from: anOwner.
	
	self assertRequestWasSuccesful: statusCode.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: 'catalogue'!

!Cashier class methodsFor: 'error handling' stamp: 'MS 11/25/2020 18:14:07'!
InvalidTransactionAmountErrorDescription
	^ 'Invalid Transaction Amount'! !

!Cashier class methodsFor: 'error handling' stamp: 'MS 11/22/2020 15:23:30'!
canNotCheckOutACartWithAnInvalidCardNumberErrorDescription
	
	^'Invalid card number.'.! !

!Cashier class methodsFor: 'error handling' stamp: 'MS 11/22/2020 15:47:00'!
canNotCheckOutACartWithAnInvalidExpirationDateErrorDescription
	
	^'Expiration date is invalid'.! !

!Cashier class methodsFor: 'error handling' stamp: 'MS 11/22/2020 16:06:40'!
canNotCheckOutACartWithAnInvalidOwnerErrorDescription
	
	^'Invalid owner.'! !

!Cashier class methodsFor: 'error handling' stamp: 'MS 11/22/2020 16:07:19'!
canNotCheckOutAnEmptyCartErrorDescription
	
	^'Cannot checkout an empty cart'.! !

!Cashier class methodsFor: 'error handling' stamp: 'MS 11/25/2020 17:06:32'!
merchantProcessorIsNotWorkingErrorDescription
	
	^'Merchant Processor is not working'.! !


!Cashier class methodsFor: 'initialization' stamp: 'MS 11/22/2020 17:10:45'!
acceptingItemsOf: aCatalog for: aMerchantProcessor 

	^self new initializeAcceptingItemsOf: aCatalog for: aMerchantProcessor.! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'receivedChekoutAmount receivedChekoutCreditCardNumber receivedChekoutExpirationDate receivedChekoutCreditCardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'MS 11/25/2020 17:10:57'!
checkOut: checkOutTotal with: aNumber and: aDate from: anOwner
	
	self subclassResponsibility.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'MS 11/25/2020 17:11:11'!
receivedCheckoutAmount
	self subclassResponsibility.! !


!classDefinition: #FailingMerchantProcessor category: #TusLibros!
MerchantProcessorSimulator subclass: #FailingMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FailingMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'MS 11/25/2020 17:15:41'!
checkOut: checkOutTotal with: aNumber and: aDate from: anOwner

	receivedChekoutAmount:= checkOutTotal.
	receivedChekoutCreditCardNumber:= aNumber .
	receivedChekoutExpirationDate:= aDate. 
	receivedChekoutCreditCardOwner:= anOwner. 

	^400.! !

!FailingMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'MS 11/25/2020 17:15:02'!
receivedCheckoutAmount

	^receivedChekoutAmount .

	! !


!classDefinition: #WorkingMerchantProcessor category: #TusLibros!
MerchantProcessorSimulator subclass: #WorkingMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!WorkingMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'MS 11/25/2020 17:25:16'!
checkOut: checkOutTotal with: aNumber and: aDate from: anOwner
	
	receivedChekoutAmount:= checkOutTotal.
	receivedChekoutCreditCardNumber:= aNumber .
	receivedChekoutExpirationDate:= aDate. 
	receivedChekoutCreditCardOwner:= anOwner.
	
	^0.! !

!WorkingMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'MS 11/25/2020 17:09:21'!
receivedCheckoutAmount
	^receivedChekoutAmount .! !
