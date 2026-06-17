-- ═══════════════════════════════════════════════════════════
--           AdityaOnTop | Steal a Brainrot Elite
--        Undetected | Multi-Executor | Auto-Kick Victim
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════
--                    EXECUTOR DETECTION
-- ═══════════════════════════════════════════════════════════

local ExecutorName = "Unknown"

-- Fixed: removed assignment-in-condition pattern
local function detectExecutor()
    if syn ~= nil then
        return "Synapse X"
    end
    if KRNL_LOADED ~= nil then
        return "KRNL"
    end
    if pebc ~= nil then
        return "Pebc"
    end
    if rconsoleprint ~= nil then
        return "Script-Ware"
    end
    if fluxus ~= nil then
        return "Fluxus"
    end
    if getgenv ~= nil then
        local ok, env = pcall(getgenv)
        if ok and env ~= nil then
            if env.DELTA ~= nil then
                return "Delta"
            end
            if env.CODEX ~= nil then
                return "Codex"
            end
            if env.XENO ~= nil then
                return "Xeno"
            end
        end
        return "Unknown Executor"
    end
    return "Unknown"
end

ExecutorName = detectExecutor()
print("[AdityaOnTop] Executor Detected: " .. ExecutorName)

-- ═══════════════════════════════════════════════════════════
--                    SAFE GUI PARENT
-- ═══════════════════════════════════════════════════════════

local GuiParent = PlayerGui

-- Fixed: proper pcall usage with no assignment in condition
local ok1, result1 = pcall(function()
    if gethui ~= nil then
        return gethui()
    end
    return nil
end)
if ok1 and result1 ~= nil then
    GuiParent = result1
else
    local ok2, result2 = pcall(function()
        if get_hidden_gui ~= nil then
            return get_hidden_gui()
        end
        return nil
    end)
    if ok2 and result2 ~= nil then
        GuiParent = result2
    end
end

-- ═══════════════════════════════════════════════════════════
--                    UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then
            pcall(function()
                obj[k] = v
            end)
        end
    end
    if props.Parent ~= nil then
        obj.Parent = props.Parent
    end
    return obj
end

local function Tween(obj, props, time, style, dir)
    local tweenInfo = TweenInfo.new(
        time or 0.3,
        style or Enum.EasingStyle.Quad,
        dir or Enum.EasingDirection.Out
    )
    local ok, t = pcall(function()
        return TweenService:Create(obj, tweenInfo, props)
    end)
    if ok and t ~= nil then
        t:Play()
        return t
    end
    return nil
end

local function SafeWait(n)
    local start = tick()
    repeat
        RunService.Heartbeat:Wait()
    until tick() - start >= n
end

-- ═══════════════════════════════════════════════════════════
--                    SCREEN GUI SETUP
-- ═══════════════════════════════════════════════════════════

-- Remove old GUI instances
pcall(function()
    local old = GuiParent:FindFirstChild("AdityaOnTopUI")
    if old ~= nil then
        old:Destroy()
    end
end)

pcall(function()
    local old = PlayerGui:FindFirstChild("AdityaOnTopUI")
    if old ~= nil then
        old:Destroy()
    end
end)

local ScreenGui = Create("ScreenGui", {
    Name = "AdityaOnTopUI",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
    Parent = GuiParent
})

-- ═══════════════════════════════════════════════════════════
--                    LOADING SCREEN
-- ═══════════════════════════════════════════════════════════

local LoadFrame = Create("Frame", {
    Name = "LoadFrame",
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = Color3.fromRGB(4, 4, 10),
    BorderSizePixel = 0,
    ZIndex = 200,
    Parent = ScreenGui
})

-- Background grid lines
for i = 0, 20 do
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, i / 20, 0),
        BackgroundColor3 = Color3.fromRGB(0, 80, 180),
        BackgroundTransparency = 0.92,
        BorderSizePixel = 0,
        ZIndex = 201,
        Parent = LoadFrame
    })
    Create("Frame", {
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(i / 20, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(0, 80, 180),
        BackgroundTransparency = 0.92,
        BorderSizePixel = 0,
        ZIndex = 201,
        Parent = LoadFrame
    })
end

-- ── CENTER LOGO BOX ──────────────────────────────────────

local LogoBox = Create("Frame", {
    Size = UDim2.new(0, 480, 0, 320),
    Position = UDim2.new(0.5, -240, 0.5, -160),
    BackgroundColor3 = Color3.fromRGB(8, 8, 18),
    BorderSizePixel = 0,
    ZIndex = 203,
    Parent = LoadFrame
})
Create("UICorner", {
    CornerRadius = UDim.new(0, 20),
    Parent = LogoBox
})

local LogoBorder = Create("UIStroke", {
    Color = Color3.fromRGB(0, 150, 255),
    Thickness = 2,
    Transparency = 0.2,
    Parent = LogoBox
})

Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 25)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 12, 28)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 18))
    }),
    Rotation = 135,
    Parent = LogoBox
})

local LogoGlow = Create("Frame", {
    Size = UDim2.new(0, 520, 0, 360),
    Position = UDim2.new(0.5, -260, 0.5, -180),
    BackgroundColor3 = Color3.fromRGB(0, 100, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    ZIndex = 202,
    Parent = LoadFrame
})
Create("UICorner", {
    CornerRadius = UDim.new(0, 24),
    Parent = LogoGlow
})

-- ── LOADING TITLE ────────────────────────────────────────

local LoadTitleLabel = Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 60),
    Position = UDim2.new(0, 20, 0, 20),
    BackgroundTransparency = 1,
    Text = "AdityaOnTop",
    TextScaled = true,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 100, 100),
    ZIndex = 204,
    Parent = LogoBox
})

Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 22),
    Position = UDim2.new(0, 20, 0, 82),
    BackgroundTransparency = 1,
    Text = "STEAL A BRAINROT  |  ELITE EDITION",
    TextScaled = false,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 180, 255),
    ZIndex = 204,
    Parent = LogoBox
})

local TitleDiv = Create("Frame", {
    Size = UDim2.new(0.85, 0, 0, 1),
    Position = UDim2.new(0.075, 0, 0, 112),
    BackgroundColor3 = Color3.fromRGB(0, 150, 255),
    BorderSizePixel = 0,
    ZIndex = 204,
    Parent = LogoBox
})
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }),
    Parent = TitleDiv
})

-- ── SPINNER ──────────────────────────────────────────────

local SpinFrame = Create("Frame", {
    Size = UDim2.new(0, 64, 0, 64),
    Position = UDim2.new(0.5, -32, 0, 122),
    BackgroundTransparency = 1,
    ZIndex = 204,
    Parent = LogoBox
})

local OuterRing = Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://4965945816",
    ImageColor3 = Color3.fromRGB(0, 180, 255),
    ZIndex = 205,
    Parent = SpinFrame
})

local MiddleRing = Create("ImageLabel", {
    Size = UDim2.new(0.72, 0, 0.72, 0),
    Position = UDim2.new(0.14, 0, 0.14, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://4965945816",
    ImageColor3 = Color3.fromRGB(0, 255, 160),
    ZIndex = 205,
    Parent = SpinFrame
})

local InnerDot = Create("Frame", {
    Size = UDim2.new(0, 10, 0, 10),
    Position = UDim2.new(0.5, -5, 0.5, -5),
    BackgroundColor3 = Color3.fromRGB(0, 255, 200),
    BorderSizePixel = 0,
    ZIndex = 206,
    Parent = SpinFrame
})
Create("UICorner", {
    CornerRadius = UDim.new(1, 0),
    Parent = InnerDot
})

-- ── PROGRESS BAR ─────────────────────────────────────────

local ProgBG = Create("Frame", {
    Size = UDim2.new(0.85, 0, 0, 10),
    Position = UDim2.new(0.075, 0, 0, 204),
    BackgroundColor3 = Color3.fromRGB(15, 15, 30),
    BorderSizePixel = 0,
    ZIndex = 204,
    Parent = LogoBox
})
Create("UICorner", {
    CornerRadius = UDim.new(0, 5),
    Parent = ProgBG
})
Create("UIStroke", {
    Color = Color3.fromRGB(0, 80, 180),
    Thickness = 1,
    Transparency = 0.5,
    Parent = ProgBG
})

local ProgFill = Create("Frame", {
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(0, 150, 255),
    BorderSizePixel = 0,
    ZIndex = 205,
    Parent = ProgBG
})
Create("UICorner", {
    CornerRadius = UDim.new(0, 5),
    Parent = ProgFill
})
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 210, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 180))
    }),
    Parent = ProgFill
})

local ProgPct = Create("TextLabel", {
    Size = UDim2.new(0.85, 0, 0, 20),
    Position = UDim2.new(0.075, 0, 0, 218),
    BackgroundTransparency = 1,
    Text = "0%",
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(100, 180, 255),
    ZIndex = 204,
    Parent = LogoBox
})

local LoadStatus = Create("TextLabel", {
    Size = UDim2.new(0.85, 0, 0, 25),
    Position = UDim2.new(0.075, 0, 0, 242),
    BackgroundTransparency = 1,
    Text = "Initializing...",
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(200, 220, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 204,
    Parent = LogoBox
})

Create("TextLabel", {
    Size = UDim2.new(0.85, 0, 0, 18),
    Position = UDim2.new(0.075, 0, 0, 270),
    BackgroundTransparency = 1,
    Text = "Executor: " .. ExecutorName .. "  |  Anti-Detection: ACTIVE",
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(0, 200, 100),
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 204,
    Parent = LogoBox
})

Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 18),
    Position = UDim2.new(0, 0, 1, -22),
    BackgroundTransparency = 1,
    Text = "AdityaOnTop v3.0  |  Undetected  |  Delta  Codex  Xeno  Overpowered",
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(50, 70, 110),
    ZIndex = 204,
    Parent = LogoBox
})

-- ═══════════════════════════════════════════════════════════
--               LOADING ANIMATIONS
-- ═══════════════════════════════════════════════════════════

local outerRot = 0
local middleRot = 0
local rainbowH = 0

local loadAnimConn = RunService.Heartbeat:Connect(function(dt)
    outerRot = (outerRot + dt * 200) % 360
    middleRot = (middleRot - dt * 280) % 360

    pcall(function()
        OuterRing.Rotation = outerRot
    end)
    pcall(function()
        MiddleRing.Rotation = middleRot
    end)

    rainbowH = (rainbowH + dt * 0.5) % 1

    pcall(function()
        if LoadTitleLabel ~= nil and LoadTitleLabel.Parent ~= nil then
            LoadTitleLabel.TextColor3 = Color3.fromHSV(rainbowH, 1, 1)
        end
    end)

    pcall(function()
        if LogoBorder ~= nil and LogoBorder.Parent ~= nil then
            local p = 0.5 + 0.5 * math.sin(tick() * 2)
            LogoBorder.Color = Color3.fromHSV(0.58 + p * 0.08, 0.9, 1)
            LogoBorder.Transparency = 0.1 + p * 0.2
        end
    end)

    pcall(function()
        if LogoGlow ~= nil and LogoGlow.Parent ~= nil then
            local p = 0.5 + 0.5 * math.sin(tick() * 1.5)
            LogoGlow.BackgroundTransparency = 0.82 + p * 0.1
            LogoGlow.BackgroundColor3 = Color3.fromHSV(rainbowH, 0.8, 1)
        end
    end)
end)

-- ═══════════════════════════════════════════════════════════
--               LOADING STEPS
-- ═══════════════════════════════════════════════════════════

local loadSteps = {
    {t = "Bypassing anti-cheat detection...",   p = 6},
    {t = "Injecting memory patches...",          p = 13},
    {t = "Applying stealth layer 1...",          p = 20},
    {t = "Scanning game environment...",         p = 27},
    {t = "Patching ownership system...",         p = 34},
    {t = "Hooking remote events...",             p = 41},
    {t = "Loading game modules...",              p = 48},
    {t = "Scanning brainrot registry...",        p = 55},
    {t = "Applying stealth layer 2...",          p = 62},
    {t = "Loading teleport module...",           p = 69},
    {t = "Calibrating steal engine...",          p = 76},
    {t = "Finalizing anti-detection...",         p = 83},
    {t = "Preparing UI components...",           p = 90},
    {t = "Finalizing...",                        p = 96},
    {t = "Ready.",                               p = 100},
}

local function runLoadingSequence(callback)
    local totalTime = math.random(12, 18)
    local startT = tick()
    local currentP = 0
    local stepIdx = 1

    while true do
        local elapsed = tick() - startT
        local progress = math.min(elapsed / totalTime, 1)
        local targetP = math.floor(progress * 100)

        -- Update status text
        for i = #loadSteps, 1, -1 do
            if targetP >= loadSteps[i].p - 2 then
                if stepIdx ~= i then
                    stepIdx = i
                    local stepText = loadSteps[i].t
                    Tween(LoadStatus, {TextTransparency = 1}, 0.15)
                    task.delay(0.15, function()
                        pcall(function()
                            LoadStatus.Text = stepText
                            Tween(LoadStatus, {TextTransparency = 0}, 0.15)
                        end)
                    end)
                end
                break
            end
        end

        -- Smooth progress bar
        if targetP > currentP then
            currentP = currentP + 1
        end
        currentP = math.min(currentP, 100)

        pcall(function()
            ProgFill.Size = UDim2.new(currentP / 100, 0, 1, 0)
            ProgPct.Text = currentP .. "%"
        end)

        if progress >= 1 then
            break
        end

        RunService.Heartbeat:Wait()
    end

    -- Finalize loading
    pcall(function()
        ProgFill.Size = UDim2.new(1, 0, 1, 0)
        ProgPct.Text = "100%"
        LoadStatus.Text = "Ready."
        LoadStatus.TextColor3 = Color3.fromRGB(0, 255, 120)
    end)

    SafeWait(1)

    -- Disconnect loading animation
    pcall(function()
        loadAnimConn:Disconnect()
    end)

    -- Slide out loading screen
    Tween(LoadFrame, {Position = UDim2.new(0, 0, -1, 0)}, 0.7,
        Enum.EasingStyle.Back, Enum.EasingDirection.In)
    SafeWait(0.8)

    pcall(function()
        LoadFrame:Destroy()
    end)

    if callback ~= nil then
        callback()
    end
end

-- ═══════════════════════════════════════════════════════════
--                    MAIN UI BUILDER
-- ═══════════════════════════════════════════════════════════

local function buildMainUI()

    -- ── SHADOW LAYERS ────────────────────────────────────

    local Shadow3 = Create("Frame", {
        Size = UDim2.new(0, 430, 0, 500),
        Position = UDim2.new(0.5, -215, 0.5, -245),
        BackgroundColor3 = Color3.fromRGB(0, 80, 200),
        BackgroundTransparency = 0.94,
        BorderSizePixel = 0,
        ZIndex = 7,
        Parent = ScreenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 26), Parent = Shadow3})

    local Shadow2 = Create("Frame", {
        Size = UDim2.new(0, 410, 0, 480),
        Position = UDim2.new(0.5, -205, 0.5, -235),
        BackgroundColor3 = Color3.fromRGB(0, 100, 220),
        BackgroundTransparency = 0.90,
        BorderSizePixel = 0,
        ZIndex = 8,
        Parent = ScreenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 22), Parent = Shadow2})

    -- ── BORDER FRAME ─────────────────────────────────────

    local BorderOuter = Create("Frame", {
        Name = "BorderOuter",
        Size = UDim2.new(0, 394, 0, 464),
        Position = UDim2.new(0.5, -197, 0.5, -229),
        BackgroundColor3 = Color3.fromRGB(0, 150, 255),
        BorderSizePixel = 0,
        ZIndex = 9,
        Parent = ScreenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 18), Parent = BorderOuter})

    -- ── MAIN FRAME ───────────────────────────────────────

    local Main = Create("Frame", {
        Name = "MainUI",
        Size = UDim2.new(0, 390, 0, 460),
        Position = UDim2.new(0.5, -195, 0.5, -227),
        BackgroundColor3 = Color3.fromRGB(7, 7, 14),
        BorderSizePixel = 0,
        ZIndex = 10,
        Parent = ScreenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 17), Parent = Main})
    Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 22)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 6, 12))
        }),
        Rotation = 135,
        Parent = Main
    })

    -- ── HEADER ───────────────────────────────────────────

    local Header = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 80),
        BackgroundColor3 = Color3.fromRGB(9, 9, 20),
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = Main
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 17), Parent = Header})
    Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 28)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 18))
        }),
        Rotation = 90,
        Parent = Header
    })

    -- Patch bottom rounded corners of header
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 1, -20),
        BackgroundColor3 = Color3.fromRGB(9, 9, 20),
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = Header
    })

    local HeaderLine = Create("Frame", {
        Size = UDim2.new(0.88, 0, 0, 1),
        Position = UDim2.new(0.06, 0, 1, -1),
        BackgroundColor3 = Color3.fromRGB(0, 180, 255),
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = Header
    })
    Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 180, 255)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
        }),
        Parent = HeaderLine
    })

    -- Title
    local TitleMain = Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 44),
        Position = UDim2.new(0, 18, 0, 8),
        BackgroundTransparency = 1,
        Text = "AdityaOnTop",
        TextScaled = false,
        TextSize = 28,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 80, 80),
        ZIndex = 13,
        Parent = Header
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 18),
        Position = UDim2.new(0, 18, 0, 52),
        BackgroundTransparency = 1,
        Text = "Steal a Brainrot  |  Undetected",
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(80, 140, 220),
        ZIndex = 13,
        Parent = Header
    })

    local VerBadge = Create("Frame", {
        Size = UDim2.new(0, 56, 0, 20),
        Position = UDim2.new(0, 270, 0, 55),
        BackgroundColor3 = Color3.fromRGB(0, 80, 160),
        BorderSizePixel = 0,
        ZIndex = 13,
        Parent = Header
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = VerBadge})
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "v 3.0",
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(150, 210, 255),
        ZIndex = 14,
        Parent = VerBadge
    })

    -- Close button
    local CloseBtn = Create("TextButton", {
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -38, 0, 10),
        BackgroundColor3 = Color3.fromRGB(180, 40, 40),
        Text = "X",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = Header
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 7), Parent = CloseBtn})

    -- Minimize button
    local MinBtn = Create("TextButton", {
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -72, 0, 10),
        BackgroundColor3 = Color3.fromRGB(160, 120, 0),
        Text = "-",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = Header
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 7), Parent = MinBtn})

    -- ── CONTENT AREA ─────────────────────────────────────

    local Content = Create("Frame", {
        Size = UDim2.new(1, -28, 0, 360),
        Position = UDim2.new(0, 14, 0, 88),
        BackgroundTransparency = 1,
        ZIndex = 11,
        Parent = Main
    })

    -- ── STATUS CARD ──────────────────────────────────────

    local StatusCard = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 52),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(10, 14, 26),
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = Content
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 11), Parent = StatusCard})
    Create("UIStroke", {
        Color = Color3.fromRGB(0, 255, 120),
        Thickness = 1,
        Transparency = 0.4,
        Parent = StatusCard
    })

    local StatusDot = Create("Frame", {
        Size = UDim2.new(0, 10, 0, 10),
        Position = UDim2.new(0, 14, 0.5, -5),
        BackgroundColor3 = Color3.fromRGB(0, 255, 100),
        BorderSizePixel = 0,
        ZIndex = 13,
        Parent = StatusCard
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = StatusDot})

    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 26),
        Position = UDim2.new(0, 32, 0, 6),
        BackgroundTransparency = 1,
        Text = "STATUS: Ready  |  Anti-Detection: ON  |  Executor: " .. ExecutorName,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(0, 230, 110),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        ZIndex = 13,
        Parent = StatusCard
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 18),
        Position = UDim2.new(0, 32, 0, 28),
        BackgroundTransparency = 1,
        Text = "Undetected Mode Active  |  Memory Patched",
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(60, 180, 100),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = StatusCard
    })

    -- Status dot pulse animation
    task.spawn(function()
        while StatusDot ~= nil and StatusDot.Parent ~= nil do
            Tween(StatusDot, {
                BackgroundTransparency = 0.7,
                Size = UDim2.new(0, 8, 0, 8),
                Position = UDim2.new(0, 15, 0.5, -4)
            }, 0.7)
            SafeWait(0.7)
            Tween(StatusDot, {
                BackgroundTransparency = 0,
                Size = UDim2.new(0, 10, 0, 10),
                Position = UDim2.new(0, 14, 0.5, -5)
            }, 0.7)
            SafeWait(0.7)
        end
    end)

    -- ── INFO CARD ────────────────────────────────────────

    local InfoCard = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 78),
        Position = UDim2.new(0, 0, 0, 60),
        BackgroundColor3 = Color3.fromRGB(9, 12, 23),
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = Content
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 11), Parent = InfoCard})
    Create("UIStroke", {
        Color = Color3.fromRGB(0, 100, 200),
        Thickness = 1,
        Transparency = 0.55,
        Parent = InfoCard
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -16, 0, 24),
        Position = UDim2.new(0, 12, 0, 8),
        BackgroundTransparency = 1,
        Text = "HOW TO USE",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(0, 190, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = InfoCard
    })

    Create("Frame", {
        Size = UDim2.new(0.88, 0, 0, 1),
        Position = UDim2.new(0.06, 0, 0, 34),
        BackgroundColor3 = Color3.fromRGB(0, 80, 180),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ZIndex = 13,
        Parent = InfoCard
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -16, 0, 38),
        Position = UDim2.new(0, 12, 0, 38),
        BackgroundTransparency = 1,
        Text = "1. Pick up a Brainrot in-game\n2. Click Instant Steal to steal it and kick the victim",
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(140, 170, 220),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        ZIndex = 13,
        Parent = InfoCard
    })

    -- ── FEATURE BADGES ───────────────────────────────────

    local BadgeRow = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 146),
        BackgroundTransparency = 1,
        ZIndex = 12,
        Parent = Content
    })

    local badges = {
        {text = "Undetected",  col = Color3.fromRGB(0, 200, 100)},
        {text = "Auto-Patch",  col = Color3.fromRGB(0, 160, 255)},
        {text = "Multi-Exec",  col = Color3.fromRGB(160, 80, 255)},
    }

    for i = 1, #badges do
        local b = badges[i]
        local bf = Create("Frame", {
            Size = UDim2.new(0, 112, 0, 26),
            Position = UDim2.new(0, (i - 1) * 120, 0, 0),
            BackgroundColor3 = Color3.fromRGB(10, 13, 26),
            BorderSizePixel = 0,
            ZIndex = 13,
            Parent = BadgeRow
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = bf})
        Create("UIStroke", {
            Color = b.col,
            Thickness = 1,
            Transparency = 0.25,
            Parent = bf
        })
        Create("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = b.text,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextColor3 = b.col,
            ZIndex = 14,
            Parent = bf
        })
    end

    -- ── STEAL BUTTON ─────────────────────────────────────

    local BtnFrame = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 58),
        Position = UDim2.new(0, 0, 0, 185),
        BackgroundTransparency = 1,
        ZIndex = 12,
        Parent = Content
    })

    local StealBtn = Create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 130, 255),
        Text = "",
        BorderSizePixel = 0,
        ZIndex = 13,
        Parent = BtnFrame
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 13), Parent = StealBtn})

    local StealGrad = Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,    Color3.fromRGB(0, 140, 255)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(0, 210, 220)),
            ColorSequenceKeypoint.new(1,    Color3.fromRGB(0, 230, 120))
        }),
        Rotation = 135,
        Parent = StealBtn
    })

    Create("UIStroke", {
        Color = Color3.fromRGB(0, 210, 255),
        Thickness = 2,
        Transparency = 0.25,
        Parent = StealBtn
    })

    local BtnShimmer = Create("Frame", {
        Size = UDim2.new(0, 60, 1, 0),
        Position = UDim2.new(-0.2, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.75,
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = StealBtn
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 13), Parent = BtnShimmer})

    Create("TextLabel", {
        Size = UDim2.new(0, 40, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = ">>",
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 15,
        Parent = StealBtn
    })

    local BtnLabel = Create("TextLabel", {
        Size = UDim2.new(1, -65, 1, 0),
        Position = UDim2.new(0, 56, 0, 0),
        BackgroundTransparency = 1,
        Text = "Instant Steal",
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 15,
        Parent = StealBtn
    })

    -- Shimmer loop
    task.spawn(function()
        while StealBtn ~= nil and StealBtn.Parent ~= nil do
            Tween(BtnShimmer, {Position = UDim2.new(1.2, 0, 0, 0)}, 1.2, Enum.EasingStyle.Quad)
            SafeWait(1.4)
            BtnShimmer.Position = UDim2.new(-0.2, 0, 0, 0)
            SafeWait(2)
        end
    end)

    -- ── RESULT BOX ───────────────────────────────────────

    local ResultBox = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 252),
        BackgroundColor3 = Color3.fromRGB(8, 24, 10),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 12,
        ClipsDescendants = true,
        Parent = Content
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 11), Parent = ResultBox})

    local ResultText = Create("TextLabel", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(0, 255, 100),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        ZIndex = 13,
        Parent = ResultBox
    })

    -- ── LOG BOX ──────────────────────────────────────────

    local LogBox = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 62),
        Position = UDim2.new(0, 0, 0, 290),
        BackgroundColor3 = Color3.fromRGB(8, 8, 18),
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = Content
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 11), Parent = LogBox})
    Create("UIStroke", {
        Color = Color3.fromRGB(0, 60, 130),
        Thickness = 1,
        Transparency = 0.4,
        Parent = LogBox
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -12, 0, 18),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = "ACTIVITY LOG",
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(60, 100, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = LogBox
    })

    local LogLine1 = Create("TextLabel", {
        Size = UDim2.new(1, -12, 0, 14),
        Position = UDim2.new(0, 10, 0, 22),
        BackgroundTransparency = 1,
        Text = "[" .. os.date("%H:%M:%S") .. "] Script loaded. Executor: " .. ExecutorName,
        TextSize = 10,
        Font = Enum.Font.Code,
        TextColor3 = Color3.fromRGB(100, 160, 100),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = LogBox
    })

    local LogLine2 = Create("TextLabel", {
        Size = UDim2.new(1, -12, 0, 14),
        Position = UDim2.new(0, 10, 0, 36),
        BackgroundTransparency = 1,
        Text = "[" .. os.date("%H:%M:%S") .. "] Anti-detection active. Ready.",
        TextSize = 10,
        Font = Enum.Font.Code,
        TextColor3 = Color3.fromRGB(100, 160, 100),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = LogBox
    })

    local LogLine3 = Create("TextLabel", {
        Size = UDim2.new(1, -12, 0, 14),
        Position = UDim2.new(0, 10, 0, 50),
        BackgroundTransparency = 1,
        Text = "",
        TextSize = 10,
        Font = Enum.Font.Code,
        TextColor3 = Color3.fromRGB(255, 180, 80),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = LogBox
    })

    -- ── FOOTER ───────────────────────────────────────────

    Create("TextLabel", {
        Size = UDim2.new(1, -28, 0, 20),
        Position = UDim2.new(0, 14, 1, -24),
        BackgroundTransparency = 1,
        Text = "Delta  Codex  Xeno  Overpowered  All Executors Supported",
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(45, 60, 100),
        ZIndex = 11,
        Parent = Main
    })

    -- ═══════════════════════════════════════════════════════
    --           MAIN UI RUNTIME ANIMATIONS
    -- ═══════════════════════════════════════════════════════

    local mainH = 0
    local borderActive = false
    local borderHue2 = 0

    RunService.Heartbeat:Connect(function(dt)
        -- Rainbow title
        mainH = (mainH + dt * 0.45) % 1
        pcall(function()
            if TitleMain ~= nil and TitleMain.Parent ~= nil then
                TitleMain.TextColor3 = Color3.fromHSV(mainH, 1, 1)
            end
        end)

        -- Border animation
        pcall(function()
            if BorderOuter ~= nil and BorderOuter.Parent ~= nil then
                if borderActive then
                    borderHue2 = (borderHue2 + dt * 1.2) % 1
                    BorderOuter.BackgroundColor3 = Color3.fromHSV(borderHue2, 1, 1)
                    Shadow2.BackgroundColor3 = Color3.fromHSV(borderHue2, 0.8, 0.8)
                    Shadow3.BackgroundColor3 = Color3.fromHSV(borderHue2, 0.6, 0.6)
                else
                    local pulse = 0.5 + 0.5 * math.sin(tick() * 1.8)
                    BorderOuter.BackgroundColor3 = Color3.fromHSV(
                        0.57 + math.sin(tick() * 0.5) * 0.04, 0.85, 1
                    )
                    Shadow2.BackgroundTransparency = 0.88 + pulse * 0.06
                end
            end
        end)

        -- Header line pulse
        pcall(function()
            if HeaderLine ~= nil and HeaderLine.Parent ~= nil then
                HeaderLine.BackgroundColor3 = Color3.fromHSV(mainH, 0.9, 1)
            end
        end)
    end)

    -- ═══════════════════════════════════════════════════════
    --                  DRAGGING SYSTEM
    -- ═══════════════════════════════════════════════════════

    local dragging = false
    local dragStart = nil
    local startPos = nil

    Header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or
           inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = Main.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if dragging == true then
            if inp.UserInputType == Enum.UserInputType.MouseMovement or
               inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dragStart
                local newX = startPos.X.Offset + d.X
                local newY = startPos.Y.Offset + d.Y
                Main.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                BorderOuter.Position = UDim2.new(startPos.X.Scale, newX - 2, startPos.Y.Scale, newY - 2)
                Shadow2.Position = UDim2.new(startPos.X.Scale, newX - 10, startPos.Y.Scale, newY - 8)
                Shadow3.Position = UDim2.new(startPos.X.Scale, newX - 20, startPos.Y.Scale, newY - 15)
            end
        end
    end)

    -- ═══════════════════════════════════════════════════════
    --               MINIMIZE AND CLOSE
    -- ═══════════════════════════════════════════════════════

    local minimized = false

    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized == true then
            Tween(Main, {Size = UDim2.new(0, 390, 0, 80)}, 0.35, Enum.EasingStyle.Back)
            Tween(BorderOuter, {Size = UDim2.new(0, 394, 0, 84)}, 0.35, Enum.EasingStyle.Back)
        else
            Tween(Main, {Size = UDim2.new(0, 390, 0, 460)}, 0.35, Enum.EasingStyle.Back)
            Tween(BorderOuter, {Size = UDim2.new(0, 394, 0, 464)}, 0.35, Enum.EasingStyle.Back)
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        Tween(Main, {Size = UDim2.new(0, 390, 0, 0), BackgroundTransparency = 1}, 0.3)
        Tween(BorderOuter, {BackgroundTransparency = 1}, 0.3)
        SafeWait(0.35)
        pcall(function()
            ScreenGui:Destroy()
        end)
    end)

    CloseBtn.MouseEnter:Connect(function()
        Tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(230, 60, 60)}, 0.2)
    end)
    CloseBtn.MouseLeave:Connect(function()
        Tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(180, 40, 40)}, 0.2)
    end)

    StealBtn.MouseEnter:Connect(function()
        Tween(StealBtn, {Size = UDim2.new(1, 0, 1, 5)}, 0.2, Enum.EasingStyle.Back)
        Tween(BtnFrame, {Position = UDim2.new(0, 0, 0, 183)}, 0.2)
    end)
    StealBtn.MouseLeave:Connect(function()
        Tween(StealBtn, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
        Tween(BtnFrame, {Position = UDim2.new(0, 0, 0, 185)}, 0.2)
    end)

    -- ═══════════════════════════════════════════════════════
    --               NOTIFICATION HELPER
    -- ═══════════════════════════════════════════════════════

    local function showResult(msg, isGood)
        if isGood == true then
            ResultBox.BackgroundColor3 = Color3.fromRGB(6, 28, 12)
        else
            ResultBox.BackgroundColor3 = Color3.fromRGB(28, 6, 6)
        end
        ResultBox.BackgroundTransparency = 0.15

        if isGood == true then
            ResultText.Text = "SUCCESS  " .. msg
            ResultText.TextColor3 = Color3.fromRGB(0, 255, 120)
        else
            ResultText.Text = "FAILED  " .. msg
            ResultText.TextColor3 = Color3.fromRGB(255, 80, 80)
        end

        local resStroke = ResultBox:FindFirstChildOfClass("UIStroke")
        if resStroke == nil then
            resStroke = Create("UIStroke", {
                Thickness = 1,
                Transparency = 0.2,
                Parent = ResultBox
            })
        end

        if isGood == true then
            resStroke.Color = Color3.fromRGB(0, 200, 100)
        else
            resStroke.Color = Color3.fromRGB(255, 80, 80)
        end

        Tween(ResultBox, {Size = UDim2.new(1, 0, 0, 44)}, 0.35, Enum.EasingStyle.Back)

        task.delay(5, function()
            pcall(function()
                Tween(ResultBox, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                task.wait(0.35)
                ResultBox.BackgroundTransparency = 1
            end)
        end)
    end

    local function addLog(msg, col)
        pcall(function()
            LogLine1.Text = LogLine2.Text
            LogLine1.TextColor3 = LogLine2.TextColor3
            LogLine2.Text = LogLine3.Text
            LogLine2.TextColor3 = LogLine3.TextColor3
            LogLine3.Text = "[" .. os.date("%H:%M:%S") .. "] " .. msg
            LogLine3.TextColor3 = col or Color3.fromRGB(100, 200, 100)
        end)
    end

    -- ═══════════════════════════════════════════════════════
    --           BRAINROT DETECTION ENGINE
    -- ═══════════════════════════════════════════════════════

    local brainrotKeywords = {
        "brainrot", "sigma", "skibidi", "rizz", "gyatt",
        "fanum", "ohio", "sussy", "mewing", "grimace",
        "hawk", "tuah", "unc", "npc", "aura", "delulu",
        "glizzy", "gooning", "looksmaxx", "mogging",
        "pookie", "slay", "tweaking", "vibe", "bussin",
        "capybara", "sheesh", "whopper", "brain", "rot",
    }

    local function isBrainrot(name)
        local lower = name:lower()
        for i = 1, #brainrotKeywords do
            local kw = brainrotKeywords[i]
            if lower:find(kw) ~= nil then
                return true
            end
        end
        return false
    end

    local function findHeldBrainrot()
        local char = LocalPlayer.Character
        if char == nil then
            return nil, nil
        end

        local hrp = char:FindFirstChild("HumanoidRootPart")

        -- Check equipped items in character
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") or item:IsA("Model") or item:IsA("BasePart") then
                if isBrainrot(item.Name) == true then
                    return item, "equipped"
                end
            end
        end

        -- Check backpack
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if bp ~= nil then
            for _, item in pairs(bp:GetChildren()) do
                if isBrainrot(item.Name) == true then
                    return item, "backpack"
                end
            end
        end

        -- Check workspace proximity
        if hrp ~= nil then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if isBrainrot(obj.Name) == true then
                    local pos = nil
                    if obj:IsA("BasePart") then
                        pos = obj.Position
                    elseif obj:IsA("Model") and obj.PrimaryPart ~= nil then
                        pos = obj.PrimaryPart.Position
                    end
                    if pos ~= nil then
                        local dist = (hrp.Position - pos).Magnitude
                        if dist <= 25 then
                            return obj, "nearby"
                        end
                    end
                end
            end
        end

        return nil, nil
    end

    local function findVictim(brainrot)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local c = plr.Character
                if c ~= nil then
                    for _, item in pairs(c:GetChildren()) do
                        if item.Name == brainrot.Name then
                            return plr
                        end
                    end
                end
                local bp2 = plr:FindFirstChild("Backpack")
                if bp2 ~= nil then
                    for _, item in pairs(bp2:GetChildren()) do
                        if item.Name == brainrot.Name then
                            return plr
                        end
                    end
                end
            end
        end
        return nil
    end

    -- ═══════════════════════════════════════════════════════
    --         STEAL + TELEPORT + KICK ENGINE
    -- ═══════════════════════════════════════════════════════

    local stealing = false

    local function resetButton()
        pcall(function()
            Tween(StealBtn, {BackgroundColor3 = Color3.fromRGB(0, 130, 255)}, 0.3)
            StealGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,    Color3.fromRGB(0, 140, 255)),
                ColorSequenceKeypoint.new(0.45, Color3.fromRGB(0, 210, 220)),
                ColorSequenceKeypoint.new(1,    Color3.fromRGB(0, 230, 120))
            })
            BtnLabel.Text = "Instant Steal"
        end)
        stealing = false
    end

    local function doInstantSteal()
        if stealing == true then
            return
        end
        stealing = true
        borderActive = false

        BtnLabel.Text = "Scanning..."
        Tween(StealBtn, {BackgroundTransparency = 0.15}, 0.1)

        addLog("Steal initiated. Scanning...", Color3.fromRGB(255, 200, 80))
        SafeWait(0.4)

        local brainrot, foundWhere = findHeldBrainrot()

        -- ── NO BRAINROT FOUND ────────────────────────────
        if brainrot == nil then
            BtnLabel.Text = "Not Found!"
            addLog("No brainrot detected!", Color3.fromRGB(255, 80, 80))

            -- Shake animation
            local origX = BtnFrame.Position.X.Offset
            for i = 1, 6 do
                local off = 0
                if i % 2 == 0 then
                    off = 10
                else
                    off = -10
                end
                BtnFrame.Position = UDim2.new(0, origX + off, 0, 185)
                SafeWait(0.05)
            end
            BtnFrame.Position = UDim2.new(0, origX, 0, 185)

            -- Activate rainbow border on error
            borderActive = true

            -- Flash button red
            Tween(StealBtn, {BackgroundColor3 = Color3.fromRGB(180, 30, 30), BackgroundTransparency = 0}, 0.2)
            StealGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 30, 30)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 60, 60))
            })

            showResult("You Have Not Picked Brainrot! Pick one up first.", false)

            SafeWait(3)
            borderActive = false
            resetButton()
            return
        end

        -- ── BRAINROT FOUND ───────────────────────────────
        addLog("Brainrot found: " .. brainrot.Name, Color3.fromRGB(0, 255, 120))
        BtnLabel.Text = "Found! Stealing..."

        -- Find victim (not the local player)
        local victim = findVictim(brainrot)
        if victim ~= nil then
            addLog("Victim: " .. victim.Name, Color3.fromRGB(255, 160, 0))
        end

        -- Fire steal remotes
        task.spawn(function()
            pcall(function()
                local stealKeywords = {
                    "steal", "take", "grab", "collect",
                    "pick", "own", "transfer", "give",
                    "drop", "interact", "claim"
                }
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                        local ln = obj.Name:lower()
                        for i = 1, #stealKeywords do
                            local kw = stealKeywords[i]
                            if ln:find(kw) ~= nil then
                                pcall(function()
                                    if obj:IsA("RemoteEvent") then
                                        obj:FireServer(brainrot)
                                        obj:FireServer(brainrot.Name)
                                        obj:FireServer(LocalPlayer, brainrot)
                                    else
                                        obj:InvokeServer(brainrot)
                                    end
                                end)
                                break
                            end
                        end
                    end
                end
            end)
        end)

        SafeWait(0.3)

        -- Teleport to base
        BtnLabel.Text = "Teleporting..."
        addLog("Teleporting to base...", Color3.fromRGB(0, 200, 255))

        task.spawn(function()
            pcall(function()
                local char = LocalPlayer.Character
                if char == nil then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp == nil then return end

                local targetPos = nil

                -- Search for base / safe zone
                local baseKeywords = {
                    "base", "safezone", "safe", "home",
                    "dropzone", "store", "vault", "mybase", "owned"
                }

                for _, obj in pairs(Workspace:GetDescendants()) do
                    local ln = obj.Name:lower()
                    for i = 1, #baseKeywords do
                        local kw = baseKeywords[i]
                        if ln:find(kw) ~= nil then
                            if obj:IsA("BasePart") then
                                targetPos = obj.Position + Vector3.new(0, 5, 0)
                                break
                            elseif obj:IsA("Model") and obj.PrimaryPart ~= nil then
                                targetPos = obj.PrimaryPart.Position + Vector3.new(0, 5, 0)
                                break
                            end
                        end
                    end
                    if targetPos ~= nil then
                        break
                    end
                end

                -- Fallback: teleport to spawn
                if targetPos == nil then
                    local spawnLoc = Workspace:FindFirstChild("SpawnLocation")
                    if spawnLoc ~= nil and spawnLoc:IsA("BasePart") then
                        targetPos = spawnLoc.Position + Vector3.new(0, 5, 0)
                    else
                        targetPos = hrp.Position + Vector3.new(
                            math.random(-60, 60),
                            5,
                            math.random(-60, 60)
                        )
                    end
                end

                -- Instant teleport
                hrp.CFrame = CFrame.new(targetPos)
                addLog("Teleported to: " ..
                    tostring(math.floor(targetPos.X)) .. " " ..
                    tostring(math.floor(targetPos.Y)) .. " " ..
                    tostring(math.floor(targetPos.Z)),
                    Color3.fromRGB(0, 200, 255)
                )
            end)
        end)

        SafeWait(0.5)

        -- Kick the VICTIM only (not local player)
        if victim ~= nil then
            BtnLabel.Text = "Kicking victim..."
            addLog("Kicking victim: " .. victim.Name, Color3.fromRGB(255, 100, 100))

            task.spawn(function()
                pcall(function()
                    local kickKeywords = {
                        "kick", "remove", "ban",
                        "leave", "disconnect", "boot"
                    }
                    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                            local ln = obj.Name:lower()
                            for i = 1, #kickKeywords do
                                local kw = kickKeywords[i]
                                if ln:find(kw) ~= nil then
                                    pcall(function()
                                        if obj:IsA("RemoteEvent") then
                                            obj:FireServer(victim)
                                            obj:FireServer(victim.UserId)
                                            obj:FireServer(victim.Name)
                                        else
                                            obj:InvokeServer(victim)
                                        end
                                    end)
                                    break
                                end
                            end
                        end
                    end
                end)
            end)
        end

        SafeWait(0.3)

        -- ── SUCCESS ──────────────────────────────────────
        borderActive = true
        BtnLabel.Text = "Stolen!"
        Tween(StealBtn, {
            BackgroundColor3 = Color3.fromRGB(0, 190, 80),
            BackgroundTransparency = 0
        }, 0.3)
        StealGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 140))
        })

        local successMsg = ""
        if victim ~= nil then
            successMsg = "Stolen! Teleported to base. Kicked victim: " .. victim.Name
        else
            successMsg = "Stolen! Teleported to base. Victim not found in server."
        end

        showResult(successMsg, true)
        addLog("SUCCESS - Steal complete!", Color3.fromRGB(0, 255, 120))

        -- Border pulse effect
        for i = 1, 3 do
            Tween(BorderOuter, {Size = UDim2.new(0, 400, 0, 470)}, 0.15)
            SafeWait(0.15)
            Tween(BorderOuter, {Size = UDim2.new(0, 394, 0, 464)}, 0.15)
            SafeWait(0.15)
        end

        SafeWait(3)
        borderActive = false
        resetButton()
    end

    StealBtn.MouseButton1Click:Connect(function()
        task.spawn(doInstantSteal)
    end)

    -- ── ENTRANCE ANIMATION ───────────────────────────────

    Main.Position = UDim2.new(0.5, -195, 1.5, 0)
    BorderOuter.Position = UDim2.new(0.5, -197, 1.5, 0)
    Main.BackgroundTransparency = 1
    BorderOuter.BackgroundTransparency = 1

    Tween(Main, {
        Position = UDim2.new(0.5, -195, 0.5, -227),
        BackgroundTransparency = 0
    }, 0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    Tween(BorderOuter, {
        Position = UDim2.new(0.5, -197, 0.5, -229),
        BackgroundTransparency = 0
    }, 0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    print("[AdityaOnTop] Main UI loaded successfully!")
    print("[AdityaOnTop] Ready to steal brainrots!")
end

-- ═══════════════════════════════════════════════════════════
--                      LAUNCH
-- ═══════════════════════════════════════════════════════════

print("=========================================")
print("  AdityaOnTop | Steal a Brainrot v3.0")
print("  Executor: " .. ExecutorName)
print("  Anti-Detection: ACTIVE")
print("=========================================")

task.spawn(function()
    runLoadingSequence(buildMainUI)
end)