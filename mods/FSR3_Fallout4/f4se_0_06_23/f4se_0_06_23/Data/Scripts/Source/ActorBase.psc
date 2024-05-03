Scriptname ActorBase extends Form Native Hidden

; Returns this actor's class
Class Function GetClass() native

; Gets the number of actors of this type that have been killed
int Function GetDeadCount() native

; Returns this actor's gift filter formlist
FormList Function GetGiftFilter() native

; Returns this actor's race
Race Function GetRace() native

; Obtains this actor's level
int Function GetLevel() native

; Obtains this actor's level, unmodified by matching the player's level
int Function GetLevelExact() native

; Returns this actor's sex. Values for sex are:
; -1 - None
; 0 - Male
; 1 - Female
int Function GetSex() native

; Gets the actor for this UniqueNPC
Actor Function GetUniqueActor() native

; Is this actor essential?
bool Function IsEssential() native

; Is this actor invulnerable?
bool Function IsInvulnerable() native

; Is this actor protected (can only be killed by player)?
bool Function IsProtected() native

; Is this actor base unique?
bool Function IsUnique() native

; Sets this actor as essential or not - if set as essential, will UNSET protected
Function SetEssential(bool abEssential = true) native

; Sets this actor as invulnerable or not
Function SetInvulnerable(bool abInvulnerable = true) native

; Sets this actor as protected or not - if set as protected, will UNSET essential
Function SetProtected(bool abProtected = true) native

; Sets the actors outfit
Function SetOutfit( Outfit akOutfit, bool abSleepOutfit = false ) native


; F4SE additions built 2022-06-21 01:37:59.702000 UTC
; Gets the template of the ActorBase, topmost will return the highest parent
ActorBase Function GetTemplate(bool bTopMost = true) native

; Returns whether this actorbase has overlay head parts
bool Function HasHeadPartOverlays() native

; Returns the head part array from either the overlay list or original list
HeadPart[] Function GetHeadParts(bool bOverlays = false) native

; Get the Outfit of the actor
Outfit Function GetOutfit(bool bSleepOutfit = false) native

struct BodyWeight
	float thin
	float muscular
	float large
EndStruct

; The sum of the three ratios should add to 1.0
; Call QueueUpdate on the Actor instance to update visually
Function SetBodyWeight(BodyWeight weight) native

; Returns the 3 weight ratios
BodyWeight Function GetBodyWeight() native