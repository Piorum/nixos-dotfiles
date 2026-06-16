local M = {}

M.full = function()
    local tmpfile = string.format("/tmp/screenshot.%d%d.png", os.time(), math.random(1000,9999))

    local monitor = hl.get_monitor_at_cursor() or hl.get_active_monitor()
    if not monitor then return end

    local region = string.format("%d,%d %dx%d", monitor.x, monitor.y, monitor.width, monitor.height)

    hl.config({ cursor = { invisible = true }})

    hl.timer(function()
        hl.exec_cmd(string.format("grim -g '%s' '%s' && hyprctl eval 'hl.config({ cursor = { invisible = false }})' && swappy -f '%s' && rm -f -- '%s'", region, tmpfile, tmpfile, tmpfile))
    end, { timeout = 125, type = "oneshot" })
end

return M