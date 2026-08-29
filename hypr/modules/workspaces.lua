-- WORKSPACES CONFIGURATION
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Default workspace 1 on primary monitor
hl.workspace_rule({
    workspace = "1",
    monitor   = "HDMI-A-1",
    default   = true,
})

-- Workspaces 2 through 10 bound to HDMI-A-1
for i = 2, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor   = "HDMI-A-1",
    })
end
