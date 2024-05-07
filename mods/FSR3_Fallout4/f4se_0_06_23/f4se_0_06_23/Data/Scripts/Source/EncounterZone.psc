Scriptname EncounterZone extends Form Native Hidden

; Get the count of all instantiated Actors (across all process levels) who belong to this encounter zone.  
; Can optionally specify a keyword for a linkedref that they must have (apRequiredLinkedRefKeyword), and/or a linkedref keyword they must NOT have (apExcludeLinkedRefKeyword).
; (Presence or absence of the keywordless linkedref cannot be checked.)
; (NOTE: if you're also necessarily going to call GetActors, just do that and check its size, instead of calling this.)
int Function CountActors( Keyword apRequiredLinkedRefKeyword = None, Keyword apExcludeLinkedRefKeyword = None ) native

; Get an array of all instantiated Actors (across all process levels) who belong to this encounter zone.  
; Can optionally specify a keyword for a linkedref that they must have (apRequiredLinkedRefKeyword), and/or a linkedref keyword they must NOT have (apExcludeLinkedRefKeyword).
; (Presence or absence of the keywordless linkedref cannot be checked.)
Actor[] Function GetActors( Keyword apRequiredLinkedRefKeyword = None, Keyword apExcludeLinkedRefKeyword = None ) native

; Tells this encounter zone to reset the next time the player enters it
Function Reset() native

; F4SE additions built 2022-06-21 01:37:59.702000 UTC

Location Function GetLocation() native
Function SetLocation(Location akLoc) native

int Function GetRank() native
Function SetRank(int rank) native

int Function GetMinLevel() native
Function SetMinLevel(int level) native

int Function GetMaxLevel() native
Function SetMaxLevel(int level) native

bool Function IsNeverResetable() native
Function SetNeverResetable(bool resetable) native

bool Function IsWorkshop() native
Function SetWorkshop(bool ws) native