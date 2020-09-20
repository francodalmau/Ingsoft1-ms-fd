!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 17:51:59'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook  closureToCheck |
	
	customerBook := CustomerBook new.
	closureToCheck := [customerBook addCustomerNamed: 'John Lennon'].
	
	self assert: closureToCheck RunsWithin: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 19:02:28'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook closureToCheck aCustomerName |
	
	aCustomerName := 'Paul McCartney'.
	customerBook := CustomerBook newWithCustomerNamed: aCustomerName.
	
	closureToCheck := [customerBook removeCustomerNamed: aCustomerName].
	
	self assert: closureToCheck RunsWithin: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 17:50:13'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook closureToCheck canNotBeEmptyErrorMessage |
			
	customerBook := CustomerBook new.
	closureToCheck  := [ customerBook addCustomerNamed: ''].
	canNotBeEmptyErrorMessage  := CustomerBook customerCanNotBeEmptyErrorMessage.
	
	self assert: closureToCheck FailsWith: canNotBeEmptyErrorMessage.
	self assert: customerBook  isEmpty.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 19:02:47'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook aCustomerName closureToCheck |
			
	aCustomerName := 'John Lennon'.
	customerBook := CustomerBook newWithCustomerNamed: aCustomerName .	
	closureToCheck := [ customerBook removeCustomerNamed: 'Paul McCartney'.].

	
	
	self assert: closureToCheck FailsOn: NotFound.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: aCustomerName).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 19:03:02'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook aCustomerName|
	
	aCustomerName := 'Paul McCartney'.
	customerBook := CustomerBook newWithCustomerNamed: aCustomerName.
	
	customerBook suspendCustomerNamed: aCustomerName.
	
	self assertThat: customerBook OnlyContainsTheSuspendedCustomer: aCustomerName  If: true.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 19:03:12'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook aCustomerName|
	
	aCustomerName := 'Paul McCartney'.
	customerBook := CustomerBook newWithCustomerNamed: aCustomerName.

	customerBook suspendCustomerNamed: aCustomerName.
	customerBook removeCustomerNamed: aCustomerName.
	
	self assertThat: customerBook OnlyContainsTheSuspendedCustomer: aCustomerName  If: false.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 19:03:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook aCustomerName |
			

	aCustomerName := 'John Lennon'.
	customerBook := CustomerBook newWithCustomerNamed: aCustomerName .
		
	self assert: [customerBook suspendCustomerNamed: 'George Harrison'.] FailsOn: CantSuspend.
	self assertThat: customerBook OnlyIncludes: aCustomerName.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fd 9/20/2020 19:01:38'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook aCustomerName |
			
	aCustomerName := 'John Lennon'.
	customerBook := CustomerBook newWithCustomerNamed: aCustomerName .
	
	customerBook suspendCustomerNamed: aCustomerName.
	
	self assert: [customerBook suspendCustomerNamed: aCustomerName .] FailsOn: CantSuspend.
	self assertThat: customerBook OnlyIncludes: aCustomerName.! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 18:52:36'!
assert: aClosure FailsOn: anError

	^self assert: aClosure FailsOn: anError With: nil.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 17:50:35'!
assert: aClosure FailsOn: anError With: anErrorMessage

	[ aClosure value.
	 self fail	]
		on: anError 
		do: [ :error | 
			^self assert: error messageText = anErrorMessage.
		 ].

	! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 17:50:35'!
assert: aClosure FailsWith: anErrorMessage

	^self assert: aClosure FailsOn: Error With: anErrorMessage.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 17:51:40'!
assert: aClosure RunsWithin: aTimelapse

	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (aTimelapse)
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 18:46:57'!
assertThat: aCustomerBook OnlyContainsTheSuspendedCustomer: aCustomer If: boolean
	
	| expectedCustomers |
	
	expectedCustomers := boolean ifTrue: 1 ifFalse: 0.

	self assertThat: aCustomerBook OnlyHasThisManySuspendedCustomers: expectedCustomers.
	self assertThereAreNoActiveCustomersIn: aCustomerBook.
	self assert: boolean = (aCustomerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 18:23:23'!
assertThat: aCustomerBook OnlyHasThisManySuspendedCustomers: aNumber

	self assert: aNumber equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumber equals: aCustomerBook numberOfCustomers.
	
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 19:05:45'!
assertThat: aCustomerBook OnlyIncludes: aCustomer "reveer cómo decirle a cual de las 3 listas referirse"

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: ( aCustomerBook includesCustomerNamed: aCustomer ).! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'fd 9/20/2020 18:03:25'!
assertThereAreNoActiveCustomersIn: aCustomerBook

	self assert: 0 equals: aCustomerBook numberOfActiveCustomers.
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'fd 9/20/2020 19:14:30'!
hasActiveCustomerNamed: aName

	^active includes: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'fd 9/20/2020 19:14:13'!
hasCustomerNamed: aName

	^(self hasActiveCustomerNamed: aName) or: (self hasSuspendedCustomerNamed: aName).! !

!CustomerBook methodsFor: 'customer management' stamp: 'fd 9/20/2020 19:14:25'!
hasSuspendedCustomerNamed: aName

	^suspended includes: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'fd 9/17/2020 21:45:34'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers .! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'customer management signals' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management signals' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer management actions' stamp: 'fd 9/20/2020 19:14:45'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self hasCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management actions' stamp: 'fd 9/20/2020 19:29:38'!
removeCustomerNamed: aName 
 	
	(self hasActiveCustomerNamed: aName) ifTrue: [^self removeCustomerNamed: aName fromCollection: active].
	(self hasSuspendedCustomerNamed: aName) ifTrue: [^self removeCustomerNamed: aName fromCollection: suspended].
	
	^NotFound signal.
! !

!CustomerBook methodsFor: 'customer management actions' stamp: 'fd 9/20/2020 19:26:44'!
removeCustomerNamed: aName fromCollection: aCollection

	1 to: aCollection size do: 	
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aName 
			] 
	].
! !

!CustomerBook methodsFor: 'customer management actions' stamp: 'fd 9/20/2020 19:15:33'!
suspendCustomerNamed: aName 
	
	(self hasActiveCustomerNamed: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'fd 9/17/2020 21:51:49'!
newWithCustomerNamed: aName

	^ self new initialize addCustomerNamed: aName.! !
