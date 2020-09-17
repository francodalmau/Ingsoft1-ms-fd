!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:34:12'!
* unNumero 
	^unNumero! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:33:12'!
+ unNumero

	^ unNumero  next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:39:56'!
- unNumero

	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:50:58'!
/ unNumero 
	^ self = unNumero
	ifTrue: [^ self]
	ifFalse: [^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ]! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:48:58'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se soporta dividir por un numero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:39:38'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ 'No se soportan numeros negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 9/14/2020 21:50:30'!
next

	^self createChildNamed: self name,'I'! !


!classDefinition: #II category: #'Numeros De Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:46:30'!
* unNumero

	
	^ unNumero = I
	ifTrue: [^self]
	ifFalse: [^ self + (unNumero previous * self)].! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:32:39'!
+ unNumero

	^self previous + unNumero next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:45:15'!
- unNumero

	^ unNumero = I
	ifTrue: [^self previous]
	ifFalse: [^self previous - unNumero  previous ].! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:57:21'!
/ unNumero

	^ unNumero = I
	ifTrue: [^self]
	ifFalse: [^ self - ((self - unNumero )/ unNumero previous)].! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 9/17/2020 16:31:31'!
previous

	^ self parent.! !


!classDefinition: #III category: #'Numeros De Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIII category: #'Numeros De Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIII category: #'Numeros De Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #TestsDeVerificacion category: #'Numeros De Peano'!
DenotativeObject subclass: #TestsDeVerificacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsDeVerificacion class' category: #'Numeros De Peano'!
TestsDeVerificacion class
	instanceVariableNames: ''!

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 12:51:26'!
test01UnoMasUnSumandoEsElProximoDelSumando

	Assert that: I + II isEqualTo: II next.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:11:40'!
test02NumerosMayoresaUnoSumanBien

	Assert that: II + II isEqualTo: IIII.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:12:19'!
test03UnNumeroMenosUnoEsElPrevioDelNumero

	Assert that: II - I isEqualTo: II previous.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:15:11'!
test04NumerosMayoresaUnoRestanBien

	Assert that: IIII - II isEqualTo: II.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 12:51:02'!
test05RestaNoSoportaNumerosNegativos

	Assert should: [ I - II ] signal: Error withDescription: I descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:15:53'!
test06UnNumeroMultiplicadoPorUnoEsIgualAlNumero

	Assert that: II * I isEqualTo: II.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:16:23'!
test07NumerosMayoresaUnoMultiplicanBien

	Assert that: II * II isEqualTo: IIII.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:16:46'!
test08UnoMultiplicadoUnoEsIgualAUno

	Assert that: I * I isEqualTo: I.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:01:58'!
test09NumerosMayoresaUnoDividenBien

	Assert that: IIII / II isEqualTo: II.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:28'!
test10UnNumeroDivididoUnoEsIgualAlNumero

	Assert that: II / I isEqualTo: II.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:38'!
test11UnoDivididoUnoEsIgualAUno

	Assert that: I / I isEqualTo: I.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:59'!
test12DivisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: II descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	
	Assert should: [ I /  II] signal: Error withDescription: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
! !
