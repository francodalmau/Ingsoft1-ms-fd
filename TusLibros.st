!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 19:36:08'!
no_test04ACartWithUnderThirtyMinutesLifetimeIsValid

	|newCart aLifetime| 
	
	newCart:= Cart new.
	
	aLifetime:=  Duration new.
	
	self assert: aLifetime totalMinutes 
	

	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 19:21:07'!
test01NewCartHasNoBooks

	|newCart|
	
	newCart:= Cart new.
	
	self assert: newCart books isEmpty.
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 19:20:54'!
test02ABookCanBeAddedToTheCart

	|newCart newBook| 
	
	newCart:= Cart new.
	
	newBook:= Book new.
	
	newCart add: newBook.
	
	
	self assert: newCart books size equals: 1.
	self assert: newCart books includes: newBook.
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 19:20:42'!
test03ABookCanBeAddedToTheCartMoreThanOnceAtATime

	|newCart newBook| 
	
	newCart:= Cart new.
	
	newBook:= Book new.
	
	newCart add: newBook withQuantity: 2.
	
	
	self assert: newCart books size equals: 2.
	self assert: newCart books includes: newBook.
	
	! !


!classDefinition: #MerchantProcessorTests category: #TusLibros!
TestCase subclass: #MerchantProcessorTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorTests methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 17:45:19'!
test01WhileMerchantProcessorWorksDebitingAValidAmountWithAValidCreditCardIsSuccesful! !

!MerchantProcessorTests methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 17:52:56'!
test02WhileMerchantProcessorWorksDebitingAValidAmountWithAnInvalidCreditCardIsNotSuccesful! !

!MerchantProcessorTests methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 17:53:19'!
test03WhileMerchantProcessorWorksDebitingAnInvalidAmountWithAValidCreditCardIsNotSuccesful! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'CS 11/16/2020 19:38:50'!
books
	
	^books copy.! !


!Cart methodsFor: 'initialization' stamp: 'CS 11/16/2020 19:38:58'!
initialize
	
	books:= Bag new.
	! !


!Cart methodsFor: 'actions' stamp: 'CS 11/16/2020 19:19:13'!
add: aBook 
	
	self add: aBook withQuantity: 1.! !

!Cart methodsFor: 'actions' stamp: 'CS 11/16/2020 19:40:56'!
add: aBook withQuantity: aQuantity 

	books add: aBook withOccurrences: aQuantity.! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
