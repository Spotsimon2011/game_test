import renpy

# Ren'Py automaticky spustí funkcie začínajúce na "init_" pri štarte
def init_force_unlock():
    persistent = renpy.game.persistent
    
    # 1. Odomknutie persistent premenných autorov
    if hasattr(persistent, '__dict__'):
        for key in list(persistent.__dict__.keys()):
            if 'gallery' in key.lower() or 'unlock' in key.lower() or 'cg' in key.lower():
                setattr(persistent, key, True)
                
    # 2. Vynútené odomknutie všetkých internejších ID obrázkov
    try:
        for name in list(renpy.game.script.namemap.keys()):
            persistent._seen_ever[name] = True
    except Exception:
        pass

    # 3. Globálne odomknutie objektov galérie
    try:
        import store
        for var_name in dir(store):
            var = getattr(store, var_name)
            if hasattr(var, 'unlock_all'):
                var.unlock_all()
            elif hasattr(var, 'unlock'):
                if hasattr(var, 'bindings'):
                    for g_item in var.bindings:
                        var.unlock(g_item)
    except Exception:
        pass
