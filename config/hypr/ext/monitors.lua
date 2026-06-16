-- monitors

-- left
hl.monitor({
    output = "desc:Dell Inc. DELL U2725QE C0LF634",
    mode = "3840x2160@120",
    position = "-3840x0",
    scale = 1,
    bitdepth = 10,
})
-- center
hl.monitor({
    output = "desc:Dell Inc. DELL U2725QE FZ01H84",
    mode = "3840x2160@120",
    position = "0x0",
    scale = 1,
    bitdepth = 10,
})
-- right
hl.monitor({
    output = "desc:Dell Inc. DELL U2725QE 7S01H84",
    mode = "3840x2160@120",
    position = "3840x0",
    scale = 1,
    bitdepth = 10,
})

-- Dummyplug
hl.monitor({
    output = "desc:Ugreen Group Ltd. UGREEN 0x20200210",
    disabled = true,
})