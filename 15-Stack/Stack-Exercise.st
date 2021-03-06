!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'testStack senteceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'FD 10/5/2020 17:37:24'!
setUp

	testStack := OOStack new.
	senteceFinder := SentenceFinderByPrefix with: testStack.
	! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:20:54'!
test01FindReturnsAnEmptyCollectionWhenTheStackIsEmpty
	
	self assert: (senteceFinder find: 'aSentence') isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:21:01'!
test02FindReturnsAnEmptyCollectionWhenThereIsNoMatch
	
	testStack push: 'aSentence'.

	self assert: (senteceFinder find: 'noMatch') isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:21:08'!
test03FindReturnsACollectionsWithTheSingleMatchInTheStack
	
	|match|
	
	testStack push: 'aSentence'.
	testStack push: 'anotherSentence'.

	match := senteceFinder find: 'aS'.
	self assert: match size = 1.
	self assert: (match includes: 'aSentence').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:21:13'!
test04FindReturnsACollectionsWithAllTheMatchingSentences
	
	|match|
	
	testStack push: 'aSentence'.
	testStack push: 'aSuperSentence'.
	testStack push: 'aSensationalSentence'.
	testStack push: 'anotherSentence'.

	match := senteceFinder find: 'aS'.
	self assert: match size = 3.
	self assert: (match includes: 'aSentence').
	self assert: (match includes: 'aSuperSentence').
	self assert: (match includes: 'aSensationalSentence').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:23:37'!
test05FindOnlyReturnsMatchesByPrefix
	
	|match|
	
	testStack push: 'aSentence'.

	match := senteceFinder find: 'Sentence'.
	self assert: match isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:23:48'!
test06FindReturnsAllMatchingAppereances
	
	|match|
	
	testStack push: 'aSentence'.
	testStack push: 'aSentence'.
	testStack push: 'aSentence'.
	
	match := senteceFinder find: 'aSentence'.
	self assert: match size = 3 .
	self assert: (match occurrencesOf: 'aSentence') = 3 .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:23:59'!
test07FindIsCaseSensitive
	
	|match|
	
	testStack push: 'aSentence'.
	
	match := senteceFinder find: 'asentence'.
	self assert: match isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:27:41'!
test08PrefixCantHaveSpaces
	
	
	
	testStack push: 'aSentence'.
	
	
	self
		should: [ senteceFinder find: 'a sentence' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Prefix prefixHasEmptySpacesErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:28:18'!
test09PrefixCantBeEmpty
	
	
	
	testStack push: 'aSentence'.
	
	
	self
		should: [ senteceFinder find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Prefix emptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'FD 10/5/2020 18:33:54'!
test10FindDoesNotAlterTheStack
	
	|initialStack|

	testStack push: 'aSentence'.
	testStack push: 'anotherSentence'.

	initialStack := testStack  copy.
	
	senteceFinder find: 'aS'.

	self assert: initialStack size = testStack size.
	self assert: initialStack top = testStack top.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:19:00'!
initialize

	size := 0.
	top := NullStackElement  new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:20:41'!
isEmpty
	^size == 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/5/2020 21:01:40'!
pop
	|element|
	
	element := top.
	top := element predecessor.
	size := size - 1.
	^element value.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/5/2020 21:01:55'!
push: anElement 
	
	size := size + 1.
	top := StackElement with: anElement pointingTo: top.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 15:58:24'!
size
	^size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/5/2020 21:02:03'!
top

	^top value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !



!classDefinition: #Prefix category: 'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Prefix methodsFor: 'initialization' stamp: 'FD 10/5/2020 18:13:30'!
value

	^value.! !

!Prefix methodsFor: 'initialization' stamp: 'FD 10/5/2020 18:13:05'!
with: aPrefix

	value := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: 'Stack-Exercise'!
Prefix class
	instanceVariableNames: ''!


!Prefix class methodsFor: 'validation' stamp: 'FD 10/5/2020 18:16:05'!
validatePrefix: aPrefix

	aPrefix = '' ifTrue: [self error: self emptyPrefixErrorDescription].
	(aPrefix includesSubString: ' ') ifTrue: [self error: self prefixHasEmptySpacesErrorDescription].! !


!Prefix class methodsFor: 'errors' stamp: 'FD 10/5/2020 18:17:00'!
emptyPrefixErrorDescription

	^'Prefix cannot be empty'.! !

!Prefix class methodsFor: 'errors' stamp: 'FD 10/5/2020 18:17:16'!
prefixHasEmptySpacesErrorDescription

	^'Prefix cannot have empty spaces'.! !


!Prefix class methodsFor: 'initialization' stamp: 'FD 10/5/2020 18:17:37'!
with: aPrefix

	self validatePrefix: aPrefix.
	^self new with: aPrefix .! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:26:35'!
initializeWith: aStack

	stack := aStack.! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'FD 10/5/2020 20:51:49'!
addToStack: aCollectionOfSentences
	
	aCollectionOfSentences do: [:sentence | stack push: sentence].! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'FD 10/5/2020 21:00:28'!
find: aPrefix

	|prefix sentencesWithPrefix stackSentences|
	
	prefix := (Prefix with: aPrefix) value.

	stackSentences := self getStackSentences.
	sentencesWithPrefix  := stackSentences select: [:sentence | self sentence: sentence matchesPrefix: prefix].
	
	self addToStack: stackSentences.

	^ sentencesWithPrefix .! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'FD 10/5/2020 20:57:38'!
getStackSentences

	| stackSentences |
	
	stackSentences := OrderedCollection new.
	
	[stack isEmpty ] whileFalse: [
			stackSentences addFirst: stack pop.
	].

	^stackSentences.! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'FD 10/5/2020 21:00:02'!
sentence: aSentence matchesPrefix: aPrefix

	^(aSentence copyFrom: 1 to: aPrefix size) = aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:26:16'!
with: aStack
	^self new initializeWith: aStack.! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'value predecessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'initialization' stamp: 'FD 10/5/2020 21:02:36'!
initializeWith: anElement pointingTo: aStackElement
	
	value := anElement.
	predecessor := aStackElement .! !


!StackElement methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 15:56:18'!
predecessor
	^predecessor.! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'FD 10/5/2020 21:02:59'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackElement class' category: 'Stack-Exercise'!
StackElement class
	instanceVariableNames: ''!

!StackElement class methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 15:54:22'!
with: aString pointingTo: aStackElement
	^self new initializeWith: aString pointingTo: aStackElement .! !


!classDefinition: #NullStackElement category: 'Stack-Exercise'!
StackElement subclass: #NullStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullStackElement methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:18:44'!
predecessor

	^self error: OOStack stackEmptyErrorDescription.! !

!NullStackElement methodsFor: 'as yet unclassified' stamp: 'FD 10/5/2020 21:03:31'!
value

	^self error: OOStack stackEmptyErrorDescription.! !
