import sys
from ctypes import windll, wintypes

def single_instance(name="FSR3_MOD_UTILITY_SINGLE_INSTANCE"):
    kernel32 = windll.kernel32
    kernel32.CreateMutexW.restype = wintypes.HANDLE

    mutex = kernel32.CreateMutexW(None, wintypes.BOOL(True), name)

    ERROR_ALREADY_EXISTS = 183
    if kernel32.GetLastError() == ERROR_ALREADY_EXISTS:
        sys.exit(0)
