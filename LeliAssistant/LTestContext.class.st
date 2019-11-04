Class {
	#name : #LTestContext,
	#superclass : #Object,
	#instVars : [
		'selectedClass',
		'selectedMethod',
		'selectedInterval'
	],
	#category : #'LeliAssistant-Test'
}

{ #category : #accessing }
LTestContext >> selectedClass [
	^ selectedClass
]

{ #category : #accessing }
LTestContext >> selectedClass: anObject [
	selectedClass := anObject
]

{ #category : #accessing }
LTestContext >> selectedInterval [
	^ selectedInterval
]

{ #category : #accessing }
LTestContext >> selectedInterval: anObject [
	selectedInterval := anObject
]

{ #category : #accessing }
LTestContext >> selectedMethod [
	^ selectedMethod
]

{ #category : #accessing }
LTestContext >> selectedMethod: anObject [
	selectedMethod := anObject
]
