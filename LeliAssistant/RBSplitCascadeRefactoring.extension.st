Extension { #name : #RBSplitCascadeRefactoring }

{ #category : #'*LeliAssistant' }
RBSplitCascadeRefactoring >> previewString [
|copy|
copy:= self copy.
	copy extractReceiver.
	copy splitCascade.
	^ copy parseTree formattedCode
]
