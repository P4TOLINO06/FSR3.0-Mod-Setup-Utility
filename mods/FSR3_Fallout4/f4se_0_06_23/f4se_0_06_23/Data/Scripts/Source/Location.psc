Scriptname Location extends Form Native Hidden

; Links the given location to this one under the given keyword
Function AddLinkedLocation(Location akLoc, Keyword akKeyword) native

; Returns an array of all locations linked to this one under the given keyword
Location[] Function GetAllLinkedLocations(Keyword akKeyword) native

; Returns the float value attached to the specified keyword attached to this location
float Function GetKeywordData(Keyword akKeyword) native

; Returns the number of alive references matching the specified reference type
int Function GetRefTypeAliveCount(LocationRefType akRefType) native

; Returns the number of dead references matching the specified reference type
int Function GetRefTypeDeadCount(LocationRefType akRefType) native

; Returns if these two locations have a common parent - filtered with the keyword, if provided
bool Function HasCommonParent(Location akOther, Keyword akFilter = None) native

; Returns if this location has ever been cleared
bool Function HasEverBeenCleared() native

; Returns if this location has the specified reference type
bool Function HasRefType(LocationRefType akRefType) native

; Returns whether this location is flagged as "cleared" or not
bool Function IsCleared() native

; Returns whether the other location is a child of this one
bool Function IsChild(Location akOther) native

; Is this location linked to the given one under the given keyword?
bool Function IsLinkedLocation(Location akLocation, Keyword akKeyword) native

; Is this location loaded in game?
bool Function IsLoaded() native

bool Function IsSameLocation(Location akOtherLocation, Keyword akKeyword = None)
{Returns true if the calling location is the same as the supplied location - if an optional keyword is supplied, it also returns true if the locations share a parent with that keyword, or if either location is a child of the other and the other has that keyword.}
;jduvall 
	bool bmatching = self == akOtherLocation
	if !bmatching && akKeyword
		bmatching = HasCommonParent(akOtherLocation, akKeyword)
		
		if !bmatching && akOtherLocation.HasKeyword(akKeyword)
			bmatching = akOtherLocation.IsChild(self) 
		elseif !bmatching && self.HasKeyword(akKeyword)
			bmatching = self.IsChild(akOtherLocation) 
		endif
		
	endif
  return bmatching
endFunction

; adds afData to the current keyword value (threadsafe)
Function ModifyKeywordData(Keyword akKeyword, float afData)
	float currentValue = GetKeywordData(akKeyword)
	SetKeywordData(akKeyword, currentValue + afData)
endFunction

; Removes any link between this location and the given one under the given keyword
Function RemoveLinkedLocation(Location akLoc, Keyword akKeyword) native

; Forces reset on all encounter zones and interior cells which use this location
Function Reset() native

; Sets the specified keyword's data on the location
Function SetKeywordData(Keyword akKeyword, float afData) native

; Sets this location as cleared or not
Function SetCleared(bool abCleared = true) native

; Event sent to location when its cleared
Event OnLocationCleared()
EndEvent

; Event sent when a location is loaded
Event OnLocationLoaded()
EndEvent


; F4SE additions built 2022-06-21 01:37:59.702000 UTC

; Returns the parent location
Location Function GetParent() native

Function SetParent(Location akLocation) native

; Returns the locations EncounterZone, if recursive it goes up a parent until it finds an EncounterZone
EncounterZone Function GetEncounterZone(bool recursive = false) native

; Sets this locations encounter zone
Function SetEncounterZone(EncounterZone ez) native