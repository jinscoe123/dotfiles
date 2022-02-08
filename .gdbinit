# Save history across sessions.
set history save on
set history filename ~/.gdb_history
set history size 1000

# Pwndbg
define init-pwndbg
source /usr/share/pwndbg/gdbinit.py
end
document init-pwndbg
Initializes PwnDBG
end

# GEF
define init-gef
source ~/.gdbinit-gef.py
end
document init-gef
Initializes GEF
end
