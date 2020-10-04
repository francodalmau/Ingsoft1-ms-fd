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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


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

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:18:28'!
pop
	|element|
	
	element := top.
	top := element predecessor.
	size := size - 1.
	^element sentence.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:00:54'!
push: aSentence 
	
	size := size + 1.
	top := StackElement with: aSentence pointingTo: top.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 15:58:24'!
size
	^size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:18:34'!
top

	^top sentence.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !



!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 17:00:23'!
find: aPrefix

	| sentencesWithPrefix actualElement stackCopy|
	
	sentencesWithPrefix := OrderedCollection new.
	stackCopy  := stack copy.
	[stackCopy isEmpty ] whileFalse: [
			actualElement := stackCopy pop.
			(
			(actualElement copyFrom: 1 to: aPrefix size) = aPrefix
			) ifTrue: [ sentencesWithPrefix addLast: actualElement].
	].

	^ sentencesWithPrefix .! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:26:35'!
initializeWith: aStack

	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:26:16'!
with: aStack
	^self new initializeWith: aStack.! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'sentence predecessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'initialization' stamp: 'FD 10/4/2020 15:53:41'!
initializeWith: aSentence pointingTo: aStackElement
	
	sentence := aSentence.
	predecessor := aStackElement .! !


!StackElement methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 15:56:18'!
predecessor
	^predecessor.! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 15:43:50'!
sentence
	^sentence.! !

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

!NullStackElement methodsFor: 'as yet unclassified' stamp: 'FD 10/4/2020 16:17:53'!
sentence

	^self error: OOStack stackEmptyErrorDescription.! !
