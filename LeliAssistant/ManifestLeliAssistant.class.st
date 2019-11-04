"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLeliAssistant,
	#superclass : #PackageManifest,
	#category : #'LeliAssistant-Manifest'
}

{ #category : #'code-critics' }
ManifestLeliAssistant class >> ruleRBEqualNotUsedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#LeliBrowser)) #'2019-01-05T12:11:20.577369-04:00') )
]
