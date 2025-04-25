-- Warten, bis ESX vollständig geladen ist
local ESX = nil
ESX = exports["es_extended"]:getSharedObject()
Config = Config or {}

while ESX == nil do
    Citizen.Wait(10) -- Warte, bis ESX verfügbar ist
end
print("ESX erfolgreich geladen")

RegisterServerEvent('esx_speedcamera:flash')
AddEventHandler('esx_speedcamera:flash', function(fine, speed)
    local _source = source
    print("Player ID (source): " .. tostring(_source))  -- Debug: Ausgabe der Spieler-ID

    -- Versuche, den Spieler zu laden
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    -- Fehlerbehandlung: Wenn der Spieler nicht gefunden wird
    if not xPlayer then
        print("Fehler: xPlayer konnte nicht gefunden werden. source: " .. tostring(_source))
        return
    end

    -- Bestätigung, dass der Spieler korrekt geladen wurde
    print("Spieler geladen: " .. xPlayer.getName())

    -- Überprüfe, ob der Spieler-Job ausgeschlossen ist
    local playerJob = xPlayer.getJob().name
    for _, exemptJob in ipairs(Config.ExemptedJobs or {}) do
        if playerJob == exemptJob then
            print("Spieler ist von Blitzer ausgenommen: " .. playerJob)
            return
        end
    end

    -- Benachrichtigung an den Spieler
    TriggerClientEvent('esx:showNotification', _source, ('Du wurdest mit %.1f km/h geblitzt! Bußgeld: $%d'):format(speed, fine))

    -- Bußgeld über Gesellschaftskonto (optional)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
        if account then
            account.addMoney(fine)
        end
    end)

    -- Testen, ob der Rechnungsversand funktioniert
    print("Versuche, eine Rechnung zu senden...")
    
    -- Wenn der Spieler korrekt geladen wurde, sende eine Rechnung
    if xPlayer then
        print("Rechnung wird gesendet: Bußgeld: " .. fine)
        
        -- Ziehe dem Spieler direkt Geld ab
    if xPlayer.getMoney() >= fine then
        xPlayer.removeMoney(fine)
        TriggerClientEvent('esx:showNotification', _source, ('Du wurdest mit %.1f km/h geblitzt! $%d wurden dir in bar abgezogen.'):format(speed, fine))
    else
        TriggerClientEvent('esx:showNotification', _source, ('Du wurdest mit %.1f km/h geblitzt, aber du hast nicht genug Bargeld für die Strafe ($%d).'):format(speed, fine))
    end

        else
        print("Fehler: xPlayer ist immer noch nil!")
    end
end)


RegisterCommand("testbill", function(source, args, rawCommand)
    local _source = source
    print("Spieler-ID (source): " .. tostring(_source))  -- Ausgabe der Spieler-ID

    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Überprüfe, ob der Spieler existiert
    if not xPlayer then
        print("Fehler: xPlayer konnte nicht geladen werden. Source: " .. tostring(_source))
        return
    end

    -- Spielername zur Bestätigung
    print("Spieler geladen: " .. xPlayer.getName())

    -- Test-Bußgeld
    local fine = 500
    local label = 'Testbußgeld'  -- Testbezeichnung

    -- Teste den Rechnungsversand
    print("Versuche, eine Test-Rechnung zu senden...")
    TriggerEvent('esx_billing:sendBill', _source, 'society_police', label, fine)
end, false)


