-- workspaces

-- set workspaces for each monitor
for i = 1, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-4" })
end
for i = 11, 20 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-5" })
end
for i = 21, 30 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-6" })
end

-- define relative binds
for i = 1, 10 do
    local key = i % 10
    local r_ws = "r~" .. i

    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = r_ws }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = r_ws }))
end