!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:00:05'!
test01PlayerXStartsPlaying

	| game |
	
	game := TerniLapilli new.
	
	self assert: game isPlayingX.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 17:59:32'!
test02AfterPlayerXgoes0

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	self assert: game isPlaying0.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:18:54'!
test03AfterPlayer0goesX

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 0@1.
	
	self assert: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:23:29'!
test04WhenXIsPlaying0IsNot

	| game |
	
	game := TerniLapilli new.
	
	self deny: game isPlaying0.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:23:37'!
test05When0IsPlayingXIsNot

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	self deny: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:50:12'!
test06PlayerXCannotPutWhen0IsPlaying

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	self should: [ game putXAt: 0@1 ] raise: Error withMessageText: TerniLapilli itsNotPlayersTurnErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:00:32'!
test07Player0CannotPutWhenXIsPlaying

	| game |
	
	game := TerniLapilli new.
	
	self should: [ game put0At: 0@1 ] raise: Error withMessageText: TerniLapilli itsNotPlayersTurnErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:17:41'!
test08aPlayerCantPutATokenOnAnOccupiedPlace

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	
	self should: [ game put0At: 0@0 ] raise: Error withMessageText: TerniLapilli spaceAlreadyOccupied.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:26:35'!
test09WhenThereAreNoTokensPlayerXHasNotWon

	| game |
	
	game := TerniLapilli new.
	
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:37:08'!
test10WhenXHasLessThanThreeTokensHeHasNotWon

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:37:59'!
test11When0HasLessThanThreeTokensHeHasNotWon

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	game put0At: 2@0.
	
	self deny: game hasPlayer0Won.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 20:39:15'!
test12WhenARowIsFilledWithXPlayerXWins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	game put0At: 1@1.
	
	game putXAt: 0@2.

	self assert: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 20:39:54'!
test13WhenARowIsFilledWith0Player0Wins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	game put0At: 1@1.
	
	game putXAt: 2@2.
	game put0At: 1@2.

	self assert: game hasPlayer0Won .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 21:02:52'!
test14WhenAColumnIsFilledWithXPlayerXWins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 2@1.
	
	game putXAt: 1@0.
	game put0At: 1@1.
	
	game putXAt: 2@0.
	game put0At: 2@2.

	self assert: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 20:56:15'!
test15WhenAColumnIsFilledWith0Player0Wins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 0@1.
	
	game putXAt: 1@0.
	game put0At: 1@1.
	
	game putXAt: 2@2.
	game put0At: 2@1.

	self assert: game hasPlayer0Won .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 21:15:11'!
test16WhenADiagonalIsFilledWithXPlayerXWins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 2@1.
	
	game putXAt: 1@1.
	game put0At: 0@1.
	
	game putXAt: 2@2.

	self assert: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 21:22:18'!
test17WhenADiagonalIsFilledWith0Player0Wins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 2@1.
	game put0At: 0@2.
	
	game putXAt: 0@1.
	game put0At: 1@1.
	
	game putXAt: 0@0.
	game put0At: 2@0.

	self assert: game hasPlayer0Won .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 21:28:07'!
test18WhenAPlayerWinsTheGameEnds

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.
	
	game putXAt: 0@1.
	game put0At: 2@1.
	
	game putXAt: 0@2.
	
	self should: [game put0At: 2@0 ] raise: Error withMessageText: TerniLapilli gameHasEndedErrorDescription.! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentlyPlaying cellsOccupiedByX cellsOccupiedBy0'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:21:19'!
hasPlayer0Won
	^(self player0HasCompleteRow or: [self player0HasCompleteColumn]) or: [ self player0HasCompleteDiagonal ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:09:36'!
hasPlayerXWon
	^ (self playerXHasCompleteRow or: [self playerXHasCompleteColumn]) or: [ self playerXHasCompleteDiagonal ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 20:59:06'!
isColumnCompletedBy0: aColumn

	^((cellsOccupiedBy0 includes: 0@aColumn) and: [
		cellsOccupiedBy0 includes: 1@aColumn
		] and: [cellsOccupiedBy0 includes: 2@aColumn]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:08:13'!
isColumnCompletedByX:  aColumn

	^((cellsOccupiedByX includes: 0@aColumn) and: [
		cellsOccupiedByX includes: 1@aColumn
		] and: [cellsOccupiedByX includes: 2@aColumn]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:19:07'!
isFirstDiagonalCompletedBy0
	^((cellsOccupiedBy0 includes: 0@0) and: [
		cellsOccupiedBy0 includes: 1@1
		] and: [cellsOccupiedBy0 includes: 2@2]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:16:29'!
isFirstDiagonalCompletedByX
	^((cellsOccupiedByX includes: 0@0) and: [
		cellsOccupiedByX includes: 1@1
		] and: [cellsOccupiedByX includes: 2@2]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 20:49:51'!
isOccupied: aPoint 
	
	^ (cellsOccupiedBy0 includes: aPoint) or: [cellsOccupiedByX includes: aPoint ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 18:40:44'!
isPlaying0
	^currentlyPlaying = $0.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 18:44:12'!
isPlayingX
	^currentlyPlaying = $X.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 20:48:36'!
isRowCompletedBy0: aRow

	^((cellsOccupiedBy0 includes: aRow@0) and: [
		cellsOccupiedBy0 includes: aRow@1
		] and: [cellsOccupiedBy0 includes: aRow@2]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 20:30:45'!
isRowCompletedByX: aRow

	^((cellsOccupiedByX includes: aRow@0) and: [
		cellsOccupiedByX includes: aRow@1
		] and: [cellsOccupiedByX includes: aRow@2]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:19:20'!
isSecondDiagonalCompletedBy0
	^((cellsOccupiedBy0 includes: 0@2) and: [
		cellsOccupiedBy0 includes: 1@1
		] and: [cellsOccupiedBy0 includes: 2@0]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:16:53'!
isSecondDiagonalCompletedByX
	^((cellsOccupiedByX includes: 0@2) and: [
		cellsOccupiedByX includes: 1@1
		] and: [cellsOccupiedByX includes: 2@0]).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 20:58:17'!
player0HasCompleteColumn
	^((self isColumnCompletedBy0: 0) or: [( self isColumnCompletedBy0: 1)]) or: [( self isColumnCompletedBy0: 2) ]! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:17:27'!
player0HasCompleteDiagonal
	^ self isFirstDiagonalCompletedBy0 or: [self isSecondDiagonalCompletedBy0]! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 20:46:36'!
player0HasCompleteRow
	^ ((self isRowCompletedBy0: 0) or: [( self isRowCompletedBy0: 1)]) or: [( self isRowCompletedBy0: 2) ]! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:07:08'!
playerXHasCompleteColumn
	^((self isColumnCompletedByX: 0) or: [( self isColumnCompletedByX: 1)]) or: [( self isColumnCompletedByX: 2) ]! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 21:12:27'!
playerXHasCompleteDiagonal
	^ self isFirstDiagonalCompletedByX or: [self isSecondDiagonalCompletedByX]! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 10/29/2020 20:41:41'!
playerXHasCompleteRow
	
	^ ((self isRowCompletedByX: 0) or: [( self isRowCompletedByX: 1)]) or: [( self isRowCompletedByX: 2) ]! !


!TerniLapilli methodsFor: 'actions' stamp: 'FD 10/29/2020 20:51:26'!
put0At: aPoint 
	
	currentlyPlaying  = $0 ifFalse: [ self signalItsNotThatPlayersTurn  ].
	
	(self isOccupied: aPoint) ifTrue: [ self signalSpaceAlreadyOccupied ].
	
	cellsOccupiedBy0 add: aPoint.
	currentlyPlaying := $X! !

!TerniLapilli methodsFor: 'actions' stamp: 'FD 10/29/2020 19:31:18'!
putXAt: aPoint 
	
	currentlyPlaying = $X ifFalse: [self signalItsNotThatPlayersTurn].
	
	(self isOccupied: aPoint) ifTrue: [self signalSpaceAlreadyOccupied].
	
	cellsOccupiedByX add: aPoint.
	currentlyPlaying  := $0.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'FD 10/29/2020 20:49:31'!
initialize

	currentlyPlaying := $X.
	cellsOccupiedBy0 := OrderedCollection new.
	cellsOccupiedByX := OrderedCollection new.! !


!TerniLapilli methodsFor: 'error handling' stamp: 'FD 10/29/2020 18:57:55'!
signalItsNotThatPlayersTurn
	self error: self class itsNotPlayersTurnErrorDescription.! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 10/29/2020 19:09:49'!
signalSpaceAlreadyOccupied
	self error: self class spaceAlreadyOccupied .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 10/29/2020 18:51:36'!
itsNotPlayersTurnErrorDescription
	^ 'It is not that players turn'.! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 10/29/2020 19:04:23'!
spaceAlreadyOccupied
	^ 'space already occupied'! !
