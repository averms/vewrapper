# -----------------------------------------------------------------------------
# Tests
# Commands to test:
# - rmve
# - acve
# - lsve
# - upve
# - mkve
# -----------------------------------------------------------------------------

log() {
    echo >>tester.log "$1"
}

>tester.log

# && means command should fail.
# || means command should succeed.
rmve faily && {
    log "removing an undefined environment succeeded somehow."
    return 1
}

acve faily && {
    log "activating an undefined environment succeeded somehow."
    return 1
}

lsve || {
    log "listing environments failed."
    return 1
}

upve faily && {
    log "upgrading an undefined environment succeeded somehow."
    return 1
}

mkve testy || {
    log "making an environment failed."
    return 1
}

lsve || {
    log "listing environments failed."
    return 1
}

# here we activate the same environment twice
acve testy || {
    log "activating an environment that is already activated failed."
    return 1
}

log "Done."
