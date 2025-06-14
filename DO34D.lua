local NotificationManager = {}
NotificationManager.__index = NotificationManager
NotificationManager.activeNotifications = 0

function NotificationManager.new()
    local self = setmetatable({}, NotificationManager)
    self.screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    self.screenGui.Name = "RaelHubNotification"
    return self
end

function NotificationManager:createNotification(texto, duracao)
    self.activeNotifications += 1

    local notificationFrame = Instance.new("Frame", self.screenGui)
    notificationFrame.Size = UDim2.new(0, 310, 0, 90)
    notificationFrame.Position = UDim2.new(1, 310, 1, -(self.activeNotifications * 100) - 10)
    notificationFrame.BackgroundTransparency = 1
    notificationFrame.ClipsDescendants = true

    -- Imagem de fundo
    local backgroundImage = Instance.new("ImageLabel", notificationFrame)
    backgroundImage.Size = UDim2.new(1, 0, 1, 0)
    backgroundImage.Image = "rbxassetid://18665679839"
    backgroundImage.BackgroundTransparency = 1
    Instance.new("UICorner", backgroundImage).CornerRadius = UDim.new(0, 20)

    -- Título da notificação
    local titleLabel = Instance.new("TextLabel", notificationFrame)
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.Position = UDim2.new(0, 0, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Rael Hub"
    titleLabel.TextColor3 = Color3.fromRGB(34, 168, 110)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.ArialBold

    -- Texto da notificação
    local notificationText = Instance.new("TextLabel", notificationFrame)
    notificationText.Size = UDim2.new(1, 0, 0, 15)
    notificationText.Position = UDim2.new(0, 0, 0, 40)
    notificationText.BackgroundTransparency = 1
    notificationText.Text = texto
    notificationText.TextColor3 = Color3.new(1, 1, 1)
    notificationText.TextScaled = true
    notificationText.TextWrapped = true
    notificationText.Font = Enum.Font.ArialBold

    -- Atualiza a altura do notificationText
    notificationText.Size = UDim2.new(1, 0, 0, notificationText.TextBounds.Y)

    -- Som da notificação
    local sound = Instance.new("Sound", self.screenGui)
    sound.SoundId = "rbxassetid://7817336081"
    sound:Play()

    -- Animação da notificação
    task.spawn(function()
        self:animateNotification(notificationFrame, duracao)
    end)
end

function NotificationManager:animateNotification(notificationFrame, duracao)
    notificationFrame:TweenPosition(UDim2.new(1, -310, 1, -(self.activeNotifications * 90) - 10), "Out", "Quad", 0.7, true)
    wait(duracao)
    notificationFrame:TweenPosition(UDim2.new(1, 310, 1, -(self.activeNotifications * 90) - 10), "In", "Quad", 1, true)
    wait(1)
    self:destroyNotification(notificationFrame)
end

function NotificationManager:destroyNotification(notificationFrame)
    self.activeNotifications -= 1
    notificationFrame:Destroy()
end

-- Retorna a tabela NotificationManager
return NotificationManager
