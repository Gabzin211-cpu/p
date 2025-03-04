-- Definindo variáveis para o voo
local flying = false
local flightSpeed = 50  -- Velocidade inicial de voo

-- Função para enviar comando no chat
function sendChatCommand(command)
    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(command, "All")
end

-- Função para ativar/desativar voo
function toggleFlight()
    flying = not flying
    if flying then
        print("Voo ativado!")
        -- Ativa o voo (apenas um exemplo básico, você pode usar o método de sua escolha)
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.PlatformStand = true
        character:WaitForChild("HumanoidRootPart").Anchored = true  -- Evita que o personagem caia
    else
        print("Voo desativado!")
        -- Desativa o voo
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.PlatformStand = false
        character:WaitForChild("HumanoidRootPart").Anchored = false  -- Deixa o personagem livre para cair
    end
end

-- Função para controlar a velocidade do voo
function setFlightSpeed(speed)
    flightSpeed = speed
    print("Velocidade de voo ajustada para: " .. flightSpeed)
end

-- Função para abrir o menu "Menu Patonho"
function openMenu()
    print("Menu Patonho")
    print("1 - Pressionar T para enviar /revistar no chat.")
    print("2 - Ativar/Desativar voo. Velocidade atual: " .. flightSpeed)
    
    -- Detecta a entrada do jogador para o menu
    local choice = io.read()  -- Aqui podemos substituir por uma interface gráfica se necessário
    
    if choice == "1" then
        -- Quando a opção 1 for selecionada, envia o comando /revistar
        sendChatCommand("/revistar")
    elseif choice == "2" then
        -- Quando a opção 2 for selecionada, ativa/desativa o voo
        toggleFlight()
        -- Oferece a opção de mudar a velocidade
        print("Digite a nova velocidade de voo (em unidades): ")
        local speedInput = tonumber(io.read())
        if speedInput then
            setFlightSpeed(speedInput)
        end
    else
        print("Opção inválida.")
    end
end

-- Evento de tecla "T" pressionada
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.T then
        -- Envia /revistar quando a tecla T for pressionada
        sendChatCommand("/revistar")
    end
end)

-- Abertura do Menu Patonho
openMenu()
