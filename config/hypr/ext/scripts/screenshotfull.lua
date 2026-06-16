local M = {}

M.full = function()
    local tmpfile = string.format("/tmp/screenshot.%d%d.png", os.time(), math.random(1000,9999))

    local monitor = hl.get_monitor_at_cursor() or hl.get_active_monitor()
    if not monitor then return end

    local region = string.format("%d,%d,%dx%d", monitor.x, monitor.y, monitor.width, monitor.height)

    hl.config({ cursor = { invisible = true }})

    hl.exec_cmd(string.format("grim -g '%s' '%'", region, tmpfile))

    hl.config({ cursor = { invisible = false }})

    hl.exec_cmd(string.format("swappy -f '%s' && rm -f -- '%s'", tmpfile, tmpfile))
end

return M