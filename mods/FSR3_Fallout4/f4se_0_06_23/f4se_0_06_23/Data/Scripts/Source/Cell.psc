Scriptname Cell extends Form Native Hidden

; Enables/disables fast travel in this cell
Function EnableFastTravel(bool abEnable = true) native

; Gets the actor that owns this cell (or none if not owned by an actor)
ActorBase Function GetActorOwner() native

; Gets the faction that owns this cell (or none if not owned by a faction)
Faction Function GetFactionOwner() native

; Is this cell "attached"? (In the loaded area)
bool Function IsAttached() native

; Is this cell an interior cell?
bool Function IsInterior() native

; Is this cell currently loaded?
bool Function IsLoaded() native

; Flags the cell for reset on next load
Function Reset() native

; Sets this cell's owner as the specified actor
Function SetActorOwner(ActorBase akActor) native

; Sets this cell's owner as the specified faction
Function SetFactionOwner(Faction akFaction) native

; Sets the fog color for this cell (interior, non-sky-lit cells only)
Function SetFogColor(int aiNearRed, int aiNearGreen, int aiNearBlue, \
	int aiFarRed, int aiFarGreen, int aiFarBlue) native

; Adjusts this cell's fog near and far planes (interior, non-sky-lit cells only)
Function SetFogPlanes(float afNear, float afFar) native

; Sets the fog power for this cell (interior, non-sky-lit cells only)
Function SetFogPower(float afPower) native

; Sets this cell as public or private
Function SetPublic(bool abPublic = true) native

; F4SE additions built 2022-06-21 01:37:59.702000 UTC

; Returns the water type for this cell, None if there is no WaterType
WaterType Function GetWaterType() native
