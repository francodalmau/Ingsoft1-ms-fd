!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:52:59'!
test01MarsRoverHasPostionAndDirection

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.

self assert: MyRover position = (0@0).
self assert: MyRover direction = $N. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:18'!
test02CanMoveForward

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'f'.

self assert: MyRover position = (0@1).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:28'!
test03CanMoveBackwards

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'b'.

self assert: MyRover position = (0@-1).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:37'!
test04CanRotateRight

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'r'.

self assert: MyRover direction = $E.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:44'!
test05CanRotateLeft

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'l'.

self assert: MyRover direction = $O.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:55:53'!
test06MovingDoesNotAlterTheDirection

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'f'.

self assert: MyRover direction = $N.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:57:13'!
test07RotatingDoesNotAlterPosition

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'r'.

self assert: MyRover position = (0@0).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 19:32:26'!
test08DoesNotProcessInvalidCommands

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.

self should: [MyRover processCommands: 'a']
	
	raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription.


self assert: MyRover position = (0@0).
self assert: MyRover direction = $N.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 18:52:29'!
test09canProcessMultipleMoveCommands

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'fb'.

self assert: MyRover position = (0@0).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 18:53:15'!
test10canProcessMultipleRotateCommands

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'rr'.

self assert: MyRover direction = $S.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 18:54:31'!
test11MovesTowardsItsDirection

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $E.
MyRover processCommands: 'f'.

self assert: MyRover position = (1@0).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 19:12:52'!
test12MarsRoverCantHaveAnInvalidPosition

self should: [MarsRover initializeInPosition: 0 facing: $N.]
	
	raise: Error
		withMessageText: MarsRover invalidPositionErrorDescription.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 19:34:29'!
test13MarsRoverCantHaveAnInvalidDirection

self should: [MarsRover initializeInPosition: (0@0) facing: 0.]
	
	raise: Error
		withMessageText: MarsRover invalidDirectionErrorDescription.
! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'direction position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MS 10/25/2020 16:37:11'!
initializeInPosition: aPoint facing: aDirection 
	
	position := aPoint.
	direction := aDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'MS 10/25/2020 16:37:36'!
direction

	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'MS 10/25/2020 16:34:26'!
position
	^position.! !


!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:38:51'!
RotateLeft

	direction = $N ifTrue: [^direction:= $O].
	direction = $E ifTrue: [^direction:= $N].
	direction = $S ifTrue: [^direction:= $E].
	direction = $O ifTrue: [^direction:= $S].! !

!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:38:59'!
RotateRight

	direction = $N ifTrue: [^direction:= $E].
	direction = $E ifTrue: [^direction:= $S].
	direction = $S ifTrue: [^direction:= $O].
	direction = $O ifTrue: [^direction:= $N].! !

!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:21:12'!
isMovementCommand: aCommand

	^ aCommand = $f or: [aCommand = $b]! !

!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:21:27'!
isRotationCommand: aCommand

	^ aCommand = $r or: [aCommand = $l]! !

!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:48:26'!
move: aDirection

	| forwardDirection |
	
	direction = $N ifTrue:[forwardDirection := (0@1)].
	direction = $E ifTrue:[forwardDirection := (1@0)].
	direction = $S ifTrue:[forwardDirection := (0@-1)].
	direction = $O ifTrue:[forwardDirection := (-1@0)].

	^ aDirection = $f 
			ifTrue: [position:= position + forwardDirection]
			ifFalse: [position := position - forwardDirection]! !

!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:23:43'!
processCommands: aString 
	
	aString do:[:aCommand |
		self assertIsValidCommand: aCommand.
	
		(self isMovementCommand: aCommand) 
			ifTrue: [self move: aCommand].
		(self isRotationCommand: aCommand) 
			ifTrue: [ self rotate: aCommand]].! !

!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:30:24'!
rotate: aDirection

	^ aDirection = $l 
				ifTrue: [self RotateLeft]
				ifFalse: [self RotateRight]! !


!MarsRover methodsFor: 'signals' stamp: 'MS 10/25/2020 17:47:04'!
signalInvalidCommand

	self error: self class invalidCommandErrorDescription! !


!MarsRover methodsFor: 'assertions' stamp: 'MS 10/25/2020 18:22:22'!
assertIsValidCommand: aCommand 
	
	((self isMovementCommand: aCommand) or: [self isRotationCommand: aCommand]) ifFalse: [self signalInvalidCommand].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MS 10/25/2020 19:35:11'!
initializeInPosition: aPoint facing: aDirection 

	self assertIsValidPosition: aPoint.
	self assertIsValidDirection: aDirection.

	^self new initializeInPosition: aPoint facing: aDirection. ! !


!MarsRover class methodsFor: 'error handling' stamp: 'MS 10/25/2020 17:45:17'!
invalidCommandErrorDescription
	
	^'Invalid Command'.! !

!MarsRover class methodsFor: 'error handling' stamp: 'MS 10/25/2020 19:33:37'!
invalidDirectionErrorDescription
	
	^'Invalid Direction'.! !

!MarsRover class methodsFor: 'error handling' stamp: 'MS 10/25/2020 19:12:24'!
invalidPositionErrorDescription
	
	^'Invalid position'! !


!MarsRover class methodsFor: 'assertions' stamp: 'MS 10/25/2020 19:39:53'!
assertIsValidDirection: aDirection 
	(aDirection = $N or:[aDirection = $E or: [aDirection = $S or:[aDirection =  $W]]])
		ifFalse:[self error: self invalidDirectionErrorDescription].! !

!MarsRover class methodsFor: 'assertions' stamp: 'MS 10/25/2020 19:12:24'!
assertIsValidPosition: aPoint 
	
	(aPoint isKindOf: Point) ifFalse:[self error: self invalidPositionErrorDescription].! !
