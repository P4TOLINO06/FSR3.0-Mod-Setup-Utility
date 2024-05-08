Scriptname Form extends ScriptObject Native Hidden

; Returns the formID for this object
Int Function GetFormID() native

; Obtains this form's value in gold. Will return -1 if the form doesn't have any value (like a quest)
int Function GetGoldValue() native

; Returns if this form has the specified keyword attached
bool Function HasKeyword(Keyword akKeyword) native

; Returns if this form has any of the keywords in the list attached
bool Function HasKeywordInFormList(FormList akKeywordList) native

; Is the "Known" flag set for this form?
bool Function PlayerKnows() native

; Turns on profiling for this specific object and all scripts attached to it - setting doesn't persist across saves
; Will do nothing on release console builds, and if the Papyrus:bEnableProfiling ini setting is off
Function StartObjectProfiling() native debugOnly

; Turns off profiling for this specific object and all scripts attached to it - setting doesn't persist across saves
; Will do nothing on release console builds, and if the Papyrus:bEnableProfiling ini setting is off
Function StopObjectProfiling() native debugOnly

; F4SE additions built 2022-06-21 01:37:59.702000 UTC

; returns the form's name, full name if possible
string Function GetName() native

; sets the name of the form
Function SetName(string name) native

; returns the description of the form
string Function GetDescription() native

; returns the weight of the form
float Function GetWeight() native

; sets the weight of the form
Function SetWeight(float weight) native

; sets the gold value of the form
Function SetGoldValue(int value) native

; returns all keywords of the form
Keyword[] Function GetKeywords() native

; Returns whether this Form has a World Model (fast)
bool Function HasWorldModel() native

; Returns the world model path of this Form, if it has a world model
string Function GetWorldModelPath() native
Function SetWorldModelPath(string path) native

; works on the path to the nif file representing the icon for the form in the inventory
string Function GetIconPath() native
Function SetIconPath(string path) native

; works on the path to the file representing the message icon for the form
string Function GetMessageIconPath() native
Function SetMessageIconPath(string path) native

; works on the enchantment associated with the form
Enchantment Function GetEnchantment() native
Function SetEnchantment(Enchantment e) native

; works on the enchantment value of the associated form
int Function GetEnchantmentValue() native
Function SetEnchantmentValue(int value) native

; Returns the particular equipslot type
EquipSlot Function GetEquipType() native
Function SetEquipType(EquipSlot type) native

Race Function GetRaceForm() native
Function SetRaceForm(Race newRace) native

; Functions and Flags dealing the BipedObject slot values from the CK
; These are the equivalent of 1 << (SlotMask-30).  Basically
; these are a flags where 30 is the first bit, and 61 is the 31st bit.

; These functions are valid for Race, Armor, and ArmorAddon
; returns the slot mask for the armor.
int Function GetSlotMask() native
; sets the slot mask for the armor
Function SetSlotMask(int slotMask) native
; adds the specified slotMask to the armor
int Function AddSlotToMask(int slotMask) native
; removes the specified slot masks from the armor
int Function RemoveSlotFromMask(int slotMask) native

; calculates the equivalent value for the properties below
int Function GetMaskForSlot(int slot) global native

; returns the SlotMask for a single slot from the CK
; can be used with the non-global SlotMask functions above
; and with the Math bit shifting functions
int Property kSlotMask30 =	0x00000001 AutoReadOnly
int Property kSlotMask31 =	0x00000002 AutoReadOnly
int Property kSlotMask32 =	0x00000004 AutoReadOnly
int Property kSlotMask33 =	0x00000008 AutoReadOnly
int Property kSlotMask34 =	0x00000010 AutoReadOnly
int Property kSlotMask35 =	0x00000020 AutoReadOnly
int Property kSlotMask36 =	0x00000040 AutoReadOnly
int Property kSlotMask37 =	0x00000080 AutoReadOnly
int Property kSlotMask38 =	0x00000100 AutoReadOnly
int Property kSlotMask39 =	0x00000200 AutoReadOnly
int Property kSlotMask40 =	0x00000400 AutoReadOnly
int Property kSlotMask41 =	0x00000800 AutoReadOnly
int Property kSlotMask42 =	0x00001000 AutoReadOnly
int Property kSlotMask43 =	0x00002000 AutoReadOnly
int Property kSlotMask44 =	0x00004000 AutoReadOnly
int Property kSlotMask45 =	0x00008000 AutoReadOnly
int Property kSlotMask46 =	0x00010000 AutoReadOnly
int Property kSlotMask47 =	0x00020000 AutoReadOnly
int Property kSlotMask48 =	0x00040000 AutoReadOnly
int Property kSlotMask49 =	0x00080000 AutoReadOnly
int Property kSlotMask50 =	0x00100000 AutoReadOnly
int Property kSlotMask51 =	0x00200000 AutoReadOnly
int Property kSlotMask52 =	0x00400000 AutoReadOnly
int Property kSlotMask53 =	0x00800000 AutoReadOnly
int Property kSlotMask54 =	0x01000000 AutoReadOnly
int Property kSlotMask55 =	0x02000000 AutoReadOnly
int Property kSlotMask56 =	0x04000000 AutoReadOnly
int Property kSlotMask57 =	0x08000000 AutoReadOnly
int Property kSlotMask58 =	0x10000000 AutoReadOnly
int Property kSlotMask59 =	0x20000000 AutoReadOnly
int Property kSlotMask60 =	0x40000000 AutoReadOnly
int Property kSlotMask61 =	0x80000000 AutoReadOnly
