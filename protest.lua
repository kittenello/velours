local refs = {
    slowmotion = ref_ui("AA", "Other", "Slow motion"),
    OSAAA = ref_ui("AA", "Other", "On shot anti-aim"),
    Legmoves = ref_ui("AA", "Other", "Leg movement"),
    enabled = ref_ui("AA", "Anti-aimbot angles", "Enabled"),
    pitch = {ref_ui("AA", "Anti-aimbot angles", "pitch")},
    roll = ref_ui("AA", "Anti-aimbot angles", "roll"),
    yawBase = ref_ui("AA", "Anti-aimbot angles", "Yaw base"),
    yaw = {ref_ui("AA", "Anti-aimbot angles", "Yaw")},
    flLimit = ref_ui("AA", "Fake lag", "Limit"),
    flamount = ref_ui("AA", "Fake lag", "Amount"),
    flenabled = ref_ui("AA", "Fake lag", "Enabled"),
    flVariance = ref_ui("AA", "Fake lag", "Variance"),
    AAfake = ref_ui("AA", "Other", "Fake peek"),
    fsBodyYaw = ref_ui("AA", "anti-aimbot angles", "Freestanding Body Yaw"),
    edgeYaw = ref_ui("AA", "Anti-aimbot angles", "Edge yaw"),
    yawJitter = {ref_ui("AA", "Anti-aimbot angles", "Yaw jitter")},
    bodyYaw = {ref_ui("AA", "Anti-aimbot angles", "Body Yaw")},
    freeStand = {ref_ui("AA", "Anti-aimbot angles", "Freestanding")},
    os = {ref_ui("AA", "Other", "On shot anti-aim")},
    slow = {ref_ui("AA", "Other", "Slow motion")},
    fakeLag = {ref_ui("AA", "Fake lag", "Limit")},
    legMovement = ref_ui("AA", "Other", "Leg movement")
}

local binds = {
    legMovement = ui.multiReference("AA", "Other", "Leg movement"),
    slowmotion = ui.multiReference("AA", "Other", "Slow motion"),
    OSAAA = ui.multiReference("AA", "Other", "On shot anti-aim"),
    AAfake = ui.multiReference("AA", "Other", "Fake peek")
}

local vars = {
    localPlayer = 0,
    aaStates = {"Global", "Standing", "Running", "Moving", "Crouching", "Air", "Air+C", "Sneaking", "On FL", "On FS"},
    pStates = {"G", "S", "M", "SW", "C", "A", "AC", "CM", "FL", "FS"},
    sToInt = {["Global"] = 1, ["Standing"] = 2, ["Running"] = 3, ["Moving"] = 4, ["Crouching"] = 5, ["Air"] = 6, ["Air+C"] = 7, ["Sneaking"] = 8 , ["On FL"] = 9, ["On FS"] = 10},
    intToS = {[1] = "Global", [2] = "Standing", [3] = "Running", [4] = "Moving", [5] = "Crouching", [6] = "Air", [7] = "Air+C", [8] = "Sneaking", [9] = "On FL", [10] = "On FS"},
    currentTab = 1,
    activeState = 1,
    pState = 1,
    yaw = 0,
    sidemove = 0,
    m1_time = 0,
    choked = 0,
    lastState = 1,
    dt_state = 0,
    doubletap_time = 0
}

local aaBuilder = {}
for i = 1, #vars.aaStates do
    aaBuilder[i] = {
        enableState = switch(aa_tab, "\r\aF88BFFFF:3 ~ \aFFFFFFFFOverride " .. func.hex({menu_r, menu_g, menu_b}) .. vars.aaStates[i] .. func.hex({200,200,200})),
        stateDisablers = list(aa_tab, "\rDisablers\r", {"Standing", "Running", "Moving", "Crouching", "Air", "Air+C", "Sneaking"}),
        yaw = combo(aa_tab, "\r\aF88BFFFF:3 ~ \aFFFFFFFFYaw Mode\n", {"Offset", "Left / Right"}),
        yawStatic = slider(tab, container, "\nYaw\r", -180, 180, 0, true, "°", 1),
        yawLeft = slider(tab, container, "\n\aF88BFFFF:3 ~ \aFFFFFFFFLeft\nYaw", -90, 90, 0, true, "°", 1),
        yawRight = slider(tab, container, "\n\aF88BFFFF:3 ~ \aFFFFFFFFRight\nYaw", -90, 90, 0, true, "°", 1),
        yawJitter = ui.new_combobox("AA", "Anti-aimbot angles", "\r\aF88BFFFF:3 ~ \aFFFFFFFFYaw Modifier\r", "Off", "Center", "Skitter", "Random", "3-Way", "S-Way"),
        wayFirst = slider(tab, container, "\n\aF88BFFFF:3 ~ \aFFFFFFFFFirst yaw jitter\r", -180, 180, 0, true, "°", 1),
        waySecond = slider(tab, container, "\n\aF88BFFFF:3 ~ \aFFFFFFFFSecond yaw jitter\r", -180, 180, 0, true, "°", 1),
        wayThird = slider(tab, container, "\n\aF88BFFFF:3 ~ \aFFFFFFFFThird yaw jitter\r", -180, 180, 0, true, "°", 1),
        yawJitterStatic = slider(tab, container, "\n\aF88BFFFF:3 ~ \aFFFFFFFFOffset yaw jitter\r", 0, 90, 0, true, "°", 1),
        bodyYaw = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFBody Yaw\n", "Off", "Opposite", "Static", "Jitter"),
        bodyYawStatic = slider(tab, container, "\aF88BFFFF:3 ~ \aFFFFFFFFSide", -2, 2, 0, true, "°", 1),
        defensiveAntiAim = ui.new_checkbox("AA", "Anti-aimbot angles", func.hex({menu_r, menu_g, menu_b}) .. "\aF88BFFFF:3 ~ \aFFFFFFFFDefensive" .. func.hex({200, 200, 200}) ..  " Anti-Aim"),
        def_pitch = combo(aa_tab, "Pitch\n", "Off", "Custom", "Random", "3-way", "Dynamic", "S-Way", "Switch", "Flick"),
        def_pitchSlider = slider("AA", "Anti-aimbot angles", "\nPitch add", -89, 89, 0, true, "°", 1),
        def_3_1 = slider("AA", "Anti-aimbot angles", "\rFirst/Second/Third", -89, 89, 0, true, "°", 1),
        def_3_2 = slider("AA", "Anti-aimbot angles", "\nsecond", -89, 89, 0, true, "°", 1),
        def_3_3 = slider("AA", "Anti-aimbot angles", "\nthird", -89, 89, 0, true, "°", 1)
    }
end

local configTab = {
    list = ui.new_listbox(tab, container, "Configs", ""),
    name = ui.new_textbox(tab, container, "Config name", ""),
    load = ui.new_button(tab, container, "\aFFFFFFFF Load", function() end),
    save = ui.new_button(tab, container, "\aFFFFFFFF Save", function() end),
    delete = ui.new_button(tab, container, "\aFFFFFFFF Delete", function() end),
    create = ui.new_button("AA", "Other", "\aFFFFFFFF Create", function() end),
    import = ui.new_button("AA", "Other", "\aFFFFFFFF Import", function() end),
    export = ui.new_button("AA", "Other", "\aFFFFFFFF Export", function() end)
}

local velours = {}
velours.config_data = {}
velours.config_data.cfg_data = {
    anti_aim = {}
}

for i = 1, #vars.aaStates do
    velours.config_data.cfg_data.anti_aim[i] = {
        enableState = aaBuilder[i].enableState,
        stateDisablers = aaBuilder[i].stateDisablers,
        yaw = aaBuilder[i].yaw,
        yawStatic = aaBuilder[i].yawStatic,
        yawLeft = aaBuilder[i].yawLeft,
        yawRight = aaBuilder[i].yawRight,
        yawJitter = aaBuilder[i].yawJitter,
        wayFirst = aaBuilder[i].wayFirst,
        waySecond = aaBuilder[i].waySecond,
        wayThird = aaBuilder[i].wayThird,
        yawJitterStatic = aaBuilder[i].yawJitterStatic,
        bodyYaw = aaBuilder[i].bodyYaw,
        bodyYawStatic = aaBuilder[i].bodyYawStatic,
        defensiveAntiAim = aaBuilder[i].defensiveAntiAim,
        def_pitch = aaBuilder[i].def_pitch,
        def_pitchSlider = aaBuilder[i].def_pitchSlider,
        def_3_1 = aaBuilder[i].def_3_1,
        def_3_2 = aaBuilder[i].def_3_2,
        def_3_3 = aaBuilder[i].def_3_3
    }
end

client.set_event_callback("setup_command", function(cmd)
    if not ui.get(refs.enabled) then return end
    
    local state = vars.pState
    if not ui.get(aaBuilder[state].enableState) then return end

    if ui.get(aaBuilder[state].defensiveAntiAim) then
        if ui.get(aaBuilder[state].def_pitch) == "3-way" then
            local first = ui.get(aaBuilder[state].def_3_1)
            local second = ui.get(aaBuilder[state].def_3_2)
            local third = ui.get(aaBuilder[state].def_3_3)
            if tickcount() % 3 == 0 then
                ui.set(refs.pitch[1], "Custom")
                ui.set(refs.pitch[2], first)
            elseif tickcount() % 3 == 1 then
                ui.set(refs.pitch[1], "Custom")
                ui.set(refs.pitch[2], second)
            elseif tickcount() % 3 == 2 then
                ui.set(refs.pitch[1], "Custom")
                ui.set(refs.pitch[2], third)
            end
        elseif ui.get(aaBuilder[state].def_pitch) == "Custom" then
            ui.set(refs.pitch[1], "Custom")
            ui.set(refs.pitch[2], ui.get(aaBuilder[state].def_pitchSlider))
        end
    end

    local yaw_mode = ui.get(aaBuilder[state].yaw)
    if yaw_mode == "Offset" then
        ui.set(refs.yaw[1], "180")
        ui.set(refs.yaw[2], ui.get(aaBuilder[state].yawStatic))
    elseif yaw_mode == "Left / Right" then
        ui.set(refs.yaw[1], "180")
        ui.set(refs.yaw[2], anti_aim_get_desync() <= 0 and ui.get(aaBuilder[state].yawLeft) or ui.get(aaBuilder[state].yawRight))
    end

    local body_yaw = ui.get(aaBuilder[state].bodyYaw)
    if body_yaw ~= "Off" then
        ui.set(refs.bodyYaw[1], body_yaw)
        if body_yaw == "Static" then
            ui.set(refs.bodyYaw[2], ui.get(aaBuilder[state].bodyYawStatic))
        end
    end
end) 