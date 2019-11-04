Extension { #name : #Character }

{ #category : #'*LeliAssistant' }
Character >> isSpecialOrSpace [
	"Answer whether the receiver is one of the special characters"

	^ self isSeparator	or: ('=()|:' includes: self)
]
