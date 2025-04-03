
    local lua_name, lua_color, script_build, altrue, m_out_pos, m_time, m_alpha, panel_height, panel_offset, panel_color, text_color = "velours", {r = 255, g = 255, b = 255}, "stable", true, { ui.menu_position() }, globals.realtime(), 0, 25, 5, { 25, 25, 25, 200 }, { 255, 255, 255, 255 }
    local
    event_callback,
    unset_event_callback,
    label,
    switch,
        combo,
        slider,
        multi,
        tickcount,
            ref_ui =
            client.set_event_callback, client.unset_event_callback, ui.new_label, ui.new_checkbox, ui.new_combobox, ui.new_slider, ui.new_multiselect, globals.tickcount, ui.reference
            
    function try_require(module, msg)
        local success, result = pcall(require, module)
        if success then return result else return error(msg) end
    end
    a = function (...) return ... end

    local tooltips = {
        delay = {[1] = "Default"},
        delay_2 = {[2] = "Off", [3] = "Random"},
        bt = {[1] = "Small", [2] = "Medium", [3] = "Maximum", [4] = "Extreme"},
        def = {[14] = "Always on", [1] = "Flick", },
        pitch = {[-89] = "Up", [0] = "Zero", [89] = "Down"},
        body = {[-2] = "Full Left", [-1] = "Left", [0] = "None", [1] = "Right", [2] = "Full Right"},
        predict = {[1] = "Head", [2] = "Chest", [3] = "Legs"},
        lethal = {[92] = "Lethal"},
        viewmodel_fov = {[68] = "Fov"},
        viewmodel_x = {[0] = "X"},
        viewmodel_y = {[0] = "Y"},
        viewmodel_z = {[0] = "Z"}
    }

    local scrsize_x, scrsize_y = client.screen_size()
    local center_x, center_y = scrsize_x / 2, scrsize_y / 2
    local json = require("json")
    gram_create = function(value, count)
        local gram = {}
        for i = 1, count do
            gram[i] = value
        end
        return gram
    end
    gram_update = function(tab, value, forced)
        if forced or tab[#tab] ~= value then
            table.insert(tab, value)
            table.remove(tab, 1)
        end
    end
    get_average = function(tab) local elements, sum = 0, 0; for k, v in pairs(tab) do sum = sum + v; elements = elements + 1; end return sum / elements; end
    math.lerp = function (a, b, w) return a + (b - a) * w end
    bit, base64, antiaim_funcs, ffi, vector, http, clipboard, c_ent, csgo_weapons, steamworks, surface = try_require("bit"), try_require("gamesense/base64"), try_require("gamesense/antiaim_funcs"), try_require("ffi"), try_require("vector", "Missing vector"), try_require("gamesense/http"), try_require("gamesense/clipboard", "Download Clipboard library: https://gamesense.pub/forums/viewtopic.php?id=28678"), try_require("gamesense/entity", "Download Entity Object library: https://gamesense.pub/forums/viewtopic.php?id=27529"), try_require("gamesense/csgo_weapons", "Download CS:GO weapon data library: https://gamesense.pub/forums/viewtopic.php?id=18807"), try_require("gamesense/steamworks"), try_require("gamesense/surface")
    function ui.multiReference(tab, groupbox, name)
        local ref1, ref2, ref3 = ref_ui(tab, groupbox, name)
        return { ref1, ref2, ref3 }
    end
    local slider_data = {ref = 0, last_item = false, hovered_another = false}
    -- function get_glow_color()
    --     glow_time = glow_time + globals.frametime() * 2
    --     local r = math.floor(128 + 127 * math.sin(glow_time))
    --     local g = math.floor(128 + 127 * math.sin(glow_time + 2))
    --     local b = math.floor(128 + 127 * math.sin(glow_time + 4))
    --     return r, g, b
    -- end
    local rounding, o, queue = 6, 20, {}
    local rad, n = rounding + 2, 45
    local RoundedRect = function(x, y, w, h, radius, r, g, b, a) renderer.rectangle(x+radius,y,w-radius*2,radius,r,g,b,a)renderer.rectangle(x,y+radius,radius,h-radius*2,r,g,b,a)renderer.rectangle(x+radius,y+h-radius,w-radius*2,radius,r,g,b,a)renderer.rectangle(x+w-radius,y+radius,radius,h-radius*2,r,g,b,a)renderer.rectangle(x+radius,y+radius,w-radius*2,h-radius*2,r,g,b,a)renderer.circle(x+radius,y+radius,r,g,b,a,radius,180,0.25)renderer.circle(x+w-radius,y+radius,r,g,b,a,radius,90,0.25)renderer.circle(x+radius,y+h-radius,r,g,b,a,radius,270,0.25)renderer.circle(x+w-radius,y+h-radius,r,g,b,a,radius,0,0.25) end
    local OutlineGlow = function(x, y, w, h, radius, r, g, b, a) renderer.rectangle(x+2,y+radius+rad,1,h-rad*2-radius*2,r,g,b,a)renderer.rectangle(x+w-3,y+radius+rad,1,h-rad*2-radius*2,r,g,b,a)renderer.rectangle(x+radius+rad,y+2,w-rad*2-radius*2,1,r,g,b,a)renderer.rectangle(x+radius+rad,y+h-3,w-rad*2-radius*2,1,r,g,b,a)renderer.circle_outline(x+radius+rad,y+radius+rad,r,g,b,a,radius+rounding,180,0.25,1)renderer.circle_outline(x+w-radius-rad,y+radius+rad,r,g,b,a,radius+rounding,270,0.25,1)renderer.circle_outline(x+radius+rad,y+h-radius-rad,r,g,b,a,radius+rounding,90,0.25,1)renderer.circle_outline(x+w-radius-rad,y+h-radius-rad,r,g,b,a,radius+rounding,0,0.25,1) end
    local FadedRoundedGlow = function(x, y, w, h, radius, r, g, b, a, glow, r1, g1, b1) local n=a/255*n;renderer.rectangle(x+radius,y,w-radius*2,1,r,g,b,n)renderer.circle_outline(x+radius,y+radius,r,g,b,n,radius,180,0.25,1)renderer.circle_outline(x+w-radius,y+radius,r,g,b,n,radius,270,0.25,1)renderer.rectangle(x,y+radius,1,h-radius*2,r,g,b,n)renderer.rectangle(x+w-1,y+radius,1,h-radius*2,r,g,b,n)renderer.circle_outline(x+radius,y+h-radius,r,g,b,n,radius,90,0.25,1)renderer.circle_outline(x+w-radius,y+h-radius,r,g,b,n,radius,0,0.25,1)renderer.rectangle(x+radius,y+h-1,w-radius*2,1,r,g,b,n) for radius=4,glow do local radius=radius/2;OutlineGlow(x-radius,y-radius,w+radius*2,h+radius*2,radius,r1,g1,b1,glow-radius*2)end end
    local container_glow = function(x, y, w, h, r, g, b, a, alpha,r1, g1, b1, fn) if alpha*255>0 then renderer.blur(x,y,w,h)end;RoundedRect(x,y,w,h,rounding,17,17,17,a)FadedRoundedGlow(x,y,w,h,rounding,r,g,b,alpha*255,alpha*o,r1,g1,b1)if not fn then return end;fn(x+rounding,y+rounding,w-rounding*2,h-rounding*2.0) end

    -- local frametime, g_speed = globals.absoluteframetime(), 1
    -- local anim = {
    --     lerp = a(function (a, b, s, t)
    --     local c = a + (b - a) * frametime * (s or 8) * g_speed
    --     return math.abs(b - c) < (t or .005) and b or c
    --     end)
    -- }

        local menu_c = ui.reference("MISC", "Settings", "Menu color")
        menu_r, menu_g, menu_b, menu_a = 255, 192, 203, 255
        
    is_peeking = function ()
        local me = entity.get_local_player()
        if not me then return end
        local enemies = entity.get_players(true)
        if not enemies then
            return false
        end

        local predict_amt = 0.25
        local eye_position = vector(client.eye_position())
        local velocity_prop_local = vector(entity.get_prop(me, 'm_vecVelocity'))
        local predicted_eye_position = vector(eye_position.x + velocity_prop_local.x * predict_amt, eye_position.y + velocity_prop_local.y * predict_amt, eye_position.z + velocity_prop_local.z * predict_amt)
        for i = 1, #enemies do
            local player = enemies[i]
            local velocity_prop = vector(entity.get_prop(player, 'm_vecVelocity'))
            local origin = vector(entity.get_prop(player, 'm_vecOrigin'))
            local predicted_origin = vector(origin.x + velocity_prop.x * predict_amt, origin.y + velocity_prop.y * predict_amt, origin.z + velocity_prop.z * predict_amt)
            entity.get_prop(player, 'm_vecOrigin', predicted_origin)
            local head_origin = vector(entity.hitbox_position(player, 0))
            local predicted_head_origin = vector(head_origin.x + velocity_prop.x * predict_amt, head_origin.y + velocity_prop.y * predict_amt, head_origin.z + velocity_prop.z * predict_amt)
            local trace_entity, damage = client.trace_bullet(me, predicted_eye_position.x, predicted_eye_position.y, predicted_eye_position.z, predicted_head_origin.x, predicted_head_origin.y, predicted_head_origin.z)
            entity.get_prop( player, 'm_vecOrigin', origin )
            if damage > 0 then
                return true
            end
        end
        return false
    end

    local refs = {
        slowmotion = ref_ui("AA", "Other", "Slow motion"),
        OSAAA = ref_ui("AA", "Other", "On shot anti-aim"),
        Legmoves = ref_ui("AA", "Other", "Leg movement"),
        legit = ref_ui("LEGIT", "Aimbot", "Enabled"),
        minimum_damage_override = { ref_ui("Rage", "Aimbot", "Minimum damage override") },
        fakeDuck = ref_ui("RAGE", "Other", "Duck peek assist"),
        minimum_damage = ref_ui("Rage", "Aimbot", "Minimum damage"),
        hitChance = ref_ui("RAGE", "Aimbot", "Minimum hit chance"),
        safePoint = ref_ui("RAGE", "Aimbot", "Force safe point"),
        forceBaim = ref_ui("RAGE", "Aimbot", "Force body aim"),
        dtLimit = ref_ui("RAGE", "Aimbot", "Double tap fake lag limit"),
        quickPeek = {ref_ui("RAGE", "Other", "Quick peek assist")},
        delay_shot = {ref_ui("RAGE", "Other", "Delay shot")},
        dt = {ref_ui("RAGE", "Aimbot", "Double tap")},
        dormantEsp = ref_ui("VISUALS", "Player ESP", "Dormant"),
        air_strafe = ref_ui("Misc", "Movement", "Air strafe"),
        multi_points = ref_ui("RAGE", "Aimbot", "Multi-point scale"),
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
        legMovement = ref_ui("AA", "Other", "Leg movement"),
        indicators = {ref_ui("VISUALS", "Other ESP", "Feature indicators")},
        ping = {ref_ui("MISC", "Miscellaneous", "Ping spike")},
    }

    local ref = {
        aimbot = ref_ui('RAGE', 'Aimbot', 'Enabled'),
        doubletap = {
            main = { ref_ui('RAGE', 'Aimbot', 'Double tap') },
            fakelag_limit = ref_ui('RAGE', 'Aimbot', 'Double tap fake lag limit')
        }
    }

    local binds = {
        legMovement = ui.multiReference("AA", "Other", "Leg movement"),
        slowmotion = ui.multiReference("AA", "Other", "Slow motion"),
        OSAAA = ui.multiReference("AA", "Other", "On shot anti-aim"),
        AAfake = ui.multiReference("AA", "Other", "Fake peek"),
        
    }

    local vars = {
        localPlayer = 0,
        hitgroup_names = { 'Generic', 'Head', 'Chest', 'Stomach', 'Left arm', 'Right arm', 'Left leg', 'Right leg', 'Neck', '?', 'Gear' },
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
        dt_state = 0,
        doubletap_time = 0,
        breaker = {
            defensive = 0,
            defensive_check = 0,
            cmd = 0,
            last_origin = nil,
            origin = nil,
            tp_dist = 0,
            tp_data = gram_create(0,3)
        },
        mapname = globals.mapname()
    }

    local hitgroup_names = {'Generic', 'Head', 'Chest', 'Stomach', 'Left Arm', 'Right Arm', 'Left Leg', 'Right Leg', 'Neck', '?', 'Gear'}

    local L_hc = ui.get(refs.hitChance)

    local func = {
        easeInOut = function(t)
            return (t > 0.5) and 4*((t-1)^3)+1 or 4*t^3;
        end,
        rec = function(x, y, w, h, radius, color)
            radius = math.min(x/2, y/2, radius)
            local r, g, b, a = unpack(color)
            renderer.rectangle(x, y + radius, w, h - radius*2, r, g, b, a)
            renderer.rectangle(x + radius, y, w - radius*2, radius, r, g, b, a)
            renderer.rectangle(x + radius, y + h - radius, w - radius*2, radius, r, g, b, a)
            renderer.circle(x + radius, y + radius, r, g, b, a, radius, 180, 0.25)
            renderer.circle(x - radius + w, y + radius, r, g, b, a, radius, 90, 0.25)
            renderer.circle(x - radius + w, y - radius + h, r, g, b, a, radius, 0, 0.25)
            renderer.circle(x + radius, y - radius + h, r, g, b, a, radius, -90, 0.25)
        end,
        rec_outline = function(x, y, w, h, radius, thickness, color)
            radius = math.min(w/2, h/2, radius)
            local r, g, b, a = unpack(color)
            if radius == 1 then
                renderer.rectangle(x, y, w, thickness, r, g, b, a)
                renderer.rectangle(x, y + h - thickness, w , thickness, r, g, b, a)
            else
                renderer.rectangle(x + radius, y, w - radius*2, thickness, r, g, b, a)
                renderer.rectangle(x + radius, y + h - thickness, w - radius*2, thickness, r, g, b, a)
                renderer.rectangle(x, y + radius, thickness, h - radius*2, r, g, b, a)
                renderer.rectangle(x + w - thickness, y + radius, thickness, h - radius*2, r, g, b, a)
                renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, 0.25, thickness)
                renderer.circle_outline(x + radius, y + h - radius, r, g, b, a, radius, 90, 0.25, thickness)
                renderer.circle_outline(x + w - radius, y + radius, r, g, b, a, radius, -90, 0.25, thickness)
                renderer.circle_outline(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 0.25, thickness)
            end
        end,
        clamp = function(x, min, max)
            return x < min and min or x > max and max or x
        end,
        table_contains = function(tbl, value)
            for i = 1, #tbl do
                if tbl[i] == value then
                    return true
                end
            end
            return false
        end,
        setAATab = function(ref)
            ui.set_visible(refs.enabled, ref)
            ui.set_visible(refs.pitch[1], ref)
            ui.set_visible(refs.pitch[2], ref)
            ui.set_visible(refs.roll, ref)
            ui.set_visible(refs.slowmotion, ref)
            ui.set_visible(refs.Legmoves, ref)
            ui.set_visible(refs.yawBase, ref)
            ui.set_visible(refs.yaw[1], ref)
            ui.set_visible(refs.yaw[2], ref)
            ui.set_visible(refs.yawJitter[1], ref)
            ui.set_visible(refs.yawJitter[2], ref)
            ui.set_visible(refs.bodyYaw[1], ref)
            ui.set_visible(refs.bodyYaw[2], ref)
            ui.set_visible(refs.freeStand[1], ref)
            ui.set_visible(refs.freeStand[2], ref)
            ui.set_visible(refs.fsBodyYaw, ref)
            ui.set_visible(refs.edgeYaw, ref)
            ui.set_visible(refs.flLimit, ref)
            ui.set_visible(refs.flamount, ref)
            ui.set_visible(refs.flVariance, ref)
            ui.set_visible(refs.flenabled, ref)
            ui.set_visible(refs.AAfake, ref)
            ui.set_visible(refs.OSAAA, ref)
        end,
        resetAATab = function()
            ui.set(refs.OSAAa, false)
            ui.set(refs.enabled, false)
            ui.set(refs.pitch[1], "Off")
            ui.set(refs.pitch[2], 0)
            ui.set(refs.roll, 0)
            ui.set(refs.slowmotion, false)
            ui.set(refs.yawBase, "local view")
            ui.set(refs.yaw[1], "Off")
            ui.set(refs.yaw[2], 0)
            ui.set(refs.yawJitter[1], "Off")
            ui.set(refs.yawJitter[2], 0)
            ui.set(refs.bodyYaw[1], "Off")
            ui.set(refs.bodyYaw[2], 0)
            ui.set(refs.freeStand[1], false)
            ui.set(refs.freeStand[2], "On hotkey")
            ui.set(refs.fsBodyYaw, false)
            ui.set(refs.edgeYaw, false)
            ui.set(refs.flLimit, false)
            ui.set(refs.flamount, false)
            ui.set(refs.flenabled, false)
            ui.set(refs.flVariance, false)
            ui.set(refs.AAfake, false)
        end,
        lerp = function(start, vend, time)
            return start + (vend - start) * time
        end,
        vec_angles = function(angle_x, angle_y)
            local sy = math.sin(math.rad(angle_y))
            local cy = math.cos(math.rad(angle_y))
            local sp = math.sin(math.rad(angle_x))
            local cp = math.cos(math.rad(angle_x))
            return cp * cy, cp * sy, -sp
        end,
        hex = function(arg)
            local result = "\a"
            for key, value in next, arg do
                local output = ""
                while value > 0 do
                    local index = math.fmod(value, 16) + 1
                    value = math.floor(value / 16)
                    output = string.sub("0123456789ABCDEF", index, index) .. output 
                end
                if #output == 0 then 
                    output = "00" 
                elseif #output == 1 then 
                    output = "0" .. output 
                end 
                result = result .. output
            end 
            return result .. "FF"
        end,
        RGBAtoHEX = function(redArg, greenArg, blueArg, alphaArg)
            return string.format('%.2x%.2x%.2x%.2x', redArg, greenArg, blueArg, alphaArg)
        end,
        includes = function(tbl, value)
            for i = 1, #tbl do
                if tbl[i] == value then
                    return true
                end
            end
            return false
        end,
        -- time_to_ticks = function(t)
        --     return math.floor(0.5 + (t / globals.tickinterval()))
        -- end,
    }

    text_fade_animation = function(speed, r, g, b, a, text)
        local final_text = ''
        local curtime = globals.curtime()
        local max_length = 100

        for i = 0, math.min(#text, max_length) do
            local alpha = a * math.abs(1 * math.cos(2 * speed * curtime / 4 + i * 5 / 30))
            local color = func.RGBAtoHEX(r, g, b, alpha)
            final_text = final_text .. '\a' .. color .. text:sub(i, i)
        end

        if #text > max_length then
            final_text = final_text .. text:sub(max_length + 1)
        end

        return final_text
    end

    split = function(inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t = {}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
            if #t > 100 then
                break
            end
        end
        return t
    end
    color_text = function(string, r, g, b, a)
        local accent = "\a" .. func.RGBAtoHEX(r, g, b, a)
        local white = "\a" .. func.RGBAtoHEX(255, 255, 255, a)

        local str = ""
        for i, s in ipairs(split(string, "$")) do
            str = str .. (i % 2 ==( string:sub(1, 1) == "$" and 0 or 1) and white or accent) .. s
        end
        return str
    end

    local tab, container = "AA", "Anti-aimbot angles"

    local aa_tab, fl_tab, other_tab = "Anti-aimbot angles", "Fake lag", "Other"

    function switch(tab, name)
        return ui.new_checkbox("AA", tab, name)
    end
    function label(tab, name)
        return ui.new_label("AA", tab, name)
    end
    function list(tab, name, vl)
        return ui.new_multiselect("AA", tab, name, vl)
    end
    function combo(tab, name, ...)
        local vl_values = {...}
        return ui.new_combobox("AA", tab, name, table.unpack(vl_values))
    end 
    --[[function slider(tab, name, ...)
        local args = {...}
        return ui.new_slider("AA", tab, name, table.unpack(args))
    end]]
    local lableb321 = label(aa_tab, "\rvelours ~" .. func.hex({255, 192, 203}) .. script_build)
    local calar = ui.new_color_picker("AA", container, "\rvelours ~" .. func.hex({255, 192, 203}) .. script_build, lua_color.r, lua_color.g, lua_color.b, 255)


    local tabPicker = combo(aa_tab, "\nTab", "Main", "Anti-aim", "Settings")
    local aaTabs = combo(aa_tab, func.hex({255, 192, 203}) .. "Anti-aim" .. func.hex({255, 192, 203}) .. " ~ selector", {"Settings", "Builder"})
    local mTabs = combo(aa_tab, func.hex({255, 192, 203}) .. "Settings" .. func.hex({255, 192, 203}) .. " ~ selector", {"Visuals", "Miscellaneous"})
    --local iTabs = combo(aa_tab, func.hex({255, 192, 203}) .. "Main" .. func.hex({255, 192, 203}) .. " ~ selector", {"Configs/Main"})


    local menu = {
        aaTab = {
            pusto = label(aa_tab, " "),
            anti_knife = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFAvoid Backstab"),
            avoid_dist = slider(tab, container, "Distance", 50, 300, 150, true, "unints", 1),
            gesdsfdsasdn_label = label(fl_tab, "\v•\r \affc0cbffAnti-Aim Binds"),
            genasdfsdd_label_line = label(fl_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            label333 = label(fl_tab, "\aFFFFFFFF•  \aFFFFFFFFBinds"),
            freestandlabel = label(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFFreestand"),
            freestandHotkey = ui.new_hotkey("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFFreestand", true),
            legitAAHotkey = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFLegit AA"),
            m_left = ui.new_hotkey("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFManual left"),
            m_right = ui.new_hotkey("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFManual right"),
            m_forward = ui.new_hotkey("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFManual forward"),
            static_m = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFStatic Manuals"),
            edge_on_fd = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFEdge Yaw on FakeDuck"),
            safe_head = list(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFSafe Head", {"Air Knife hold", "Air Zeus hold"}),
            safe_flick = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFDefensive Safe Head"),
            safe_flick_mode = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFMode", {"Default", "Flick", "E spam"}),
            safe_flick_pitch = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFPitch", {"Fluculate", "Custom"}),
            safe_flick_pitch_value = slider(tab, container, "\npitch", -89, 89, 0, true, "°", 1, tooltips.pitch),
        },
        builderTab = {
            lableb = label(aa_tab, " "),
            lableb22 = label(fl_tab, " "),
            gesdsdsasdn_label = label(fl_tab, "\v•\r \affc0cbffAnti-Aim State"),
            genasdsdd_label_line = label(fl_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            state = combo(fl_tab, "\nAnti-aim state\r", vars.aaStates), 
        },
        visualsTab = {
            gen_label = label(aa_tab, "\v•\r \affc0cbffVisuals"),
            gen_label_line = label(aa_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            cros_ind = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFCrosshair Indicators"),
            min_ind = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFMin Damage Indicator"),
            min_ind_mode = combo(aa_tab, "\nselect", "Bind", "Always"),
            min_text = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFSize", "Default", "Pixel"),
            on_screen_logs = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFHit-Logs OnScreen"),
            on_screen_v = list(aa_tab, "\nA", {"Hit", "Miss", "Evaded"}),
            on_screen_max = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFMaximum", 1, 10, 4, true, nil, 1),
            arows_txt = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFArrows"),
            arows_txt_color = ui.new_color_picker("AA", container, "\aF88BFFFF:3 ~ \aFFFFFFFFArrows", lua_color.r, lua_color.g, lua_color.b, 255),
            arows_txt_offset = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFOffset", 30, 120, 50),
            snowball = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFForce Snowball Global"),
            snowflake_speed = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFSnowflake Speed", 1, 10, 5, true, "x"),
            snowflake_count = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFSnowflake Count", 10, 200, 10, true),
            animates_left_down = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFAnimate Left Down"),
            fireball = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFForce Fireball Global"),
            fireball_speed = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFFireball Speed", 1, 10, 5, true, "x"),
            fireball_count = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFFireball Count", 10, 200, 10, true),
            animate_left_down = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFAnimate Left Down"),
            gen_ljhjhagfgfbel = label(fl_tab, "\v•\r \affc0cbffRender"),
            gen_labejhjhlfggfgf_line = label(fl_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            
            fpsboost = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFFPS Optimization"),
            bul_trace = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFBullet Tracers"),
            bul_color = ui.new_color_picker("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFBullet Tracers Color", 255, 255, 255, 255),
            bul_dur = slider("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFDuration", 1, 15, 2, true, "s", 1),
            rgb_tracers = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFRGB Tracers"),
            rgb_speed = slider("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFRGB Speed", 1, 200, 100, true, "x"),
            tracers_width = slider("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFTracers Width", 1, 5, 2),
            zeus_warning = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFESP Zeus Warning"),
            slow_down = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFSlowdown indicator"),
            widgets_slow = list(fl_tab, "\n\aF88BFFFF:3 ~ \aFFFFFFFFSlowdown addictions", {"Blackout", "Dynamic color", "Show procents"}),
            widgets_slow_length = slider("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFLength / Width", 20,150,100),
            widgets_slow_width = slider("AA", "Fake lag", "\n\aF88BFFFF:3 ~ \aFFFFFFFFWidth", 1,15,4),
            ammo_low = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFLow Ammo Warning"),
            --gs_ind = switch(fl_tab, "\aF88BFFFF:3 ~ \a32CD32FF50$\aFFFFFFFF indicators"),
            --gs_redesign = switch(fl_tab, "\aF88BFFFF:3 ~ \a32CD32FF350$\aFFFFFFFF indicators"),
            trace_target = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFTrace Target"),
            trace_color = ui.new_color_picker("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFTrace Color"),
            grenade_radius = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFGrenades ESP Radius [BETA]"),
            smoke_radius = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFSmoke Radius"),
            smoke_radius_reference = ui.new_color_picker("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFSmoke Radius", 255, 255, 255, 255),
            molotov_radius = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFMolotov Radius"),
            molotov_radius_reference = ui.new_color_picker("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFMolotov Radius", 255, 255, 255, 255),
            fha8tsgsfas2 = label(aa_tab, func.hex({menu_r, menu_g, menu_b}) .. "               "),
            gen_ldfghghghgabel = label(aa_tab, "\v•\r \affc0cbffOther"),
            gen_labhgfhdgfel_line = label(aa_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            asp = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFOverride Aspect Ratio"),
            asp_v = slider("AA", container, "\aF88BFFFF:3 ~ \aFFFFFFFFValue", 10, 200, 100),
            third_ = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFThirdperson"),
            third_dis = slider("AA", container, "\n\aF88BFFFF:3 ~ \aFFFFFFFFDistance\r", 30, 140, 70),
            viewmodel_en = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFViewmodel Changer"),
            viewmodel_fov = slider("AA", container, "Fov / X / Y / Z", 0, 140, 68, true, "°", 1, tooltips.viewmodel_fov),
            viewmodel_x = slider("AA", container, "\nX", -100, 200, 0, true, "°", 1, tooltips.viewmodel_x),
            viewmodel_y = slider("AA", container, "\nY", -100, 200, 0, true, "°", 1, tooltips.viewmodel_y),
            viewmodel_z = slider("AA", container, "\nZ", -100, 200, 0, true, "°", 1, tooltips.viewmodel_z),
            custom_scope = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFCustom Scope Lines"),
            custom_color = ui.new_color_picker("AA", container, "\aF88BFFFF:3 ~ \aFFFFFFFFCustom Scope Lines", 255, 255, 255, 255),
            custom_initial_pos = slider("AA", container, "\na", 0, 400, 100, true, "px", 1),
            custom_offset = slider("AA", container, "\na", 0, 200, 10, true, "px", 1),
            lab1l1a2eb222 = label(aa_tab, " "),
            las12leb2b22 = label(aa_tab, " "),
            lab1f2lebz222 = label(aa_tab, " "),
            lab123lebx222 = label(aa_tab, " "),
            lab125lebs222 = label(aa_tab, " "),
            lab1l2eb2222 = label(aa_tab, " "),
            line12 = label(aa_tab, " "),
            line13 = label(aa_tab, " "),
            line14 = label(aa_tab, " "),
            line15 = label(aa_tab, " "),
            line16 = label(aa_tab, " "),
            line17 = label(aa_tab, " "),
            line18 = label(aa_tab, " "),
            line19 = label(aa_tab, " "),
            line121 = label(aa_tab, " "),
            line132 = label(aa_tab, " "),
            line143 = label(aa_tab, " "),
            line154 = label(aa_tab, " "),
            line165 = label(aa_tab, " "),
            line176 = label(aa_tab, " "),
            line187 = label(aa_tab, " "),
            line198 = label(aa_tab, " "),
            line182 = label(aa_tab, " "),
            line173 = label(aa_tab, " "),
            line164 = label(aa_tab, " "),
            line155 = label(aa_tab, " "),
            lines164 = label(aa_tab, " "),
            lines173 = label(aa_tab, " "),
            lines182 = label(aa_tab, " "),
            line191 = label(aa_tab, " "),
            line1217 = label(aa_tab, " "),
            line1326 = label(aa_tab, " "),
            line1435 = label(aa_tab, " "),
            line1545 = label(aa_tab, " "),
            line1654 = label(aa_tab, " "),
            line1763 = label(aa_tab, " "),
            line1872 = label(aa_tab, " "),
            line1981 = label(aa_tab, " "),
            line21 = label(fl_tab, " "),
            line22 = label(fl_tab, " "),
            line23 = label(fl_tab, " "),
            line24 = label(fl_tab, " "),
            line25 = label(fl_tab, " "),
            line26 = label(fl_tab, " "),
            line27 = label(fl_tab, " "),
            line28 = label(fl_tab, " "),
            line29 = label(fl_tab, " "),
            gen_laghghbel = label(other_tab, "\v•\r \affc0cbffAnimations"),
            gen_labeghghl_line = label(other_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            a_pitch = switch(other_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFPitch 0 on land"),
            a_body = switch(other_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFBody lean"),
            ap_move = combo(other_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFMove legs", {"None", "Static", "Jitter", "Moonwalk"}),
            ap_air = combo(other_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFAir legs", {"None", "Falling", "Moonwalk", "Kangaroo", "Earthquake"}),
            fu8ayafsyu8n = label(fl_tab, " "),
            b3837372 = label(aa_tab, "       "),
        },
        miscTab = {
            gedfsgsdfgn_lagdsfgdgdhghbel = label(fl_tab, "\v•\r \affc0cbffMiscellaneous"),
            gensdfg_labeghghl_line = label(fl_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            filtercons = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFConsole Filter"),
            clanTag = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFClantag"),
            clantag_mode = combo(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFMode", {"velours", "velours.lua"}),
            killsay = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFTrashTalk"),
            killsay_type = combo(fl_tab, "\n\aF88BFFFF:3 ~ \aFFFFFFFFTrashTalk Type", {"Default", "Ad", "Revenge", "Simple 1", "Delayed"}),
            killsay_add = list(fl_tab, "\n\aF88BFFFF:3 ~ \aFFFFFFFFTrashTalk Addiction", {"Miss"}),
            console_logs = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFConsole Hit-logs"),
            console_logs_custom_vibor = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFCustom '?' Miss Reason"),
            console_logs_resolver = combo(fl_tab, "\n\aF88BFFFF:3 ~ \aFFFFFFFFCustom '?' reason\r", {"resolver", "kitty :3", "desync", "lagcomp failure", "spread", "occlusion", "wallshot failure", "unprediction error", "unregistered shot"}),
            auto_smoke = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFAuto-Smoke [BETA]"),
            auto_smoke_bind = ui.new_hotkey("AA", "Fake lag", "\aF88BFFFF:3 ~ \aFFFFFFFFAuto-Smoke Hotkey"),
            auto_smoke_cam = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFNo Restore Camera"),
            settingsmatch = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFWarmup Settings"),
            settingsmatchqwe = combo(fl_tab,  "Settings for", {"Off", "Test CFG"}),
            lableb221 = label(fl_tab, " "),
            lableb222 = label(fl_tab, " "),
            lableb223 = label(fl_tab, " "),
            lableb224 = label(fl_tab, " "),
            lableb225 = label(fl_tab, " "),
            lableb226 = label(fl_tab, " "),
            lableb227 = label(fl_tab, " "),
            lableb2211 = label(fl_tab, " "),
            lableb2221 = label(fl_tab, " "),
            lableb2231 = label(fl_tab, " "),
            lableb2241 = label(fl_tab, " "),
            lableb2251 = label(fl_tab, " "),
            lableb2261 = label(fl_tab, " "),
            lableb2271 = label(fl_tab, " "),
            gasden_laghghbel = label(aa_tab, "\v•\r \affc0cbffOther"),
            gsaden_labeghghl_line = label(aa_tab, "\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"),
            jump_scout = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFJumpScout"),
            charge_dt = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFUnsafe Charge DT in Air"),
            bomb_fix = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFBlock E on BombSite"),
            fast_ladder = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFFast Ladder"),
            hidechatbox = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFHide Chat"),
            enablechina = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFHat Type", {"None", "Nimbus", "China"}),
            colorchinareal = ui.new_color_picker("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFHat Color", {255, 255, 255}),
            gradientchina = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFGradient Hat"),
            speedchina = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFSpeed Hat", 1, 10, 5),
            vgui_color_checkbox = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFConsole Modulation"),
            vgui_color = ui.new_color_picker("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFConsole Modulation Color", {255, 255, 255}),
            drop_grenades_helper = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFDrop Grenades Helper"),
            drop_grenades_hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFDrop Grenades Key"),
            lab1la2eb222 = label(aa_tab, " "),
            las12leb222 = label(aa_tab, " "),
            lab1f2leb222 = label(aa_tab, " "),
            lab123leb222 = label(aa_tab, " "),
            lab125leb222 = label(aa_tab, " "),
            lab1l2eb222 = label(aa_tab, " "),
        },
        extras = {
            text = ui.new_checkbox("LUA","B","Icon_extra"),
            icon = ui.new_checkbox("LUA","B","text_exetra"),
            gradient = ui.new_checkbox("LUA","B","gradient_extras"),
            length = slider("LUA","B", "legfnth_Extra", 20,150 ,100, true),
            width = slider("LUA","B", "width_extra", 1,15 ,4, true),
            text1 = ui.new_checkbox("LUA","B","Icon_extra1"),
            icon1 = ui.new_checkbox("LUA","B","text_exetra1"),
            gradient1 = ui.new_checkbox("LUA","B","gradient_extras1"),
            dynamic = ui.new_checkbox("LUA","B","dynamic_extras1"),
            length1=slider("LUA","B", "legfnth_Extra1", 20,150 ,100, true),
            width1=slider("LUA","B", "width_extra1", 1,15 ,4, true),
        },
        configTab = {
            label2 = label(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFLast update was \aFFFFFFFF 02.04.2025"),
            label3 = label(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFYour build is " .. func.hex({menu_r, menu_g, menu_b}) .. script_build),
            laggbegfhl900 = label(fl_tab, "       "),
            info_panel_pos = combo(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFInfo panel position", {"Up", "Down", "Off"}),
            label900 = label(fl_tab, "       "),
            dada = label(fl_tab, "  "),
            list = ui.new_listbox(tab, container, "Configs", ""),
            name = ui.new_textbox(tab, container, "Config name", ""),
            load = ui.new_button(tab, container, "\aFFFFFFFF Load", function() end),
            save = ui.new_button(tab, container, "\aFFFFFFFF Save", function() end),
            delete = ui.new_button(tab, container, "\aFFFFFFFF Delete", function() end),
            labelc = label(other_tab, "Create config"),
            create_name = ui.new_textbox("AA", "Other", "Config name", ""),
            create = ui.new_button("AA", "Other", "\aFFFFFFFF Create", function() end),
            import = ui.new_button("AA", "Other", "\aFFFFFFFF Import", function() end),
            export = ui.new_button("AA", "Other", "\aFFFFFFFF Export", function() end),
        },
    }

    local aaBuilder = {}
        for i = 1, #vars.aaStates do
            aaBuilder[i] = {
                label_huy = label(fl_tab, "   "),
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
                sway_speed = slider(tab, container, "\aF88BFFFF:3 ~ \aFFFFFFFFSpeed\n", 2, 16, 0, true, nil, 1),
                bodyYaw = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFBody Yaw\n", "Off", "Opposite", "Static", "Jitter"),
                bodyYawStatic = slider(tab, container, "\aF88BFFFF:3 ~ \aFFFFFFFFSide", -2, 2, 0, true, "°", 1, tooltips.body),
                delayed_body = slider(tab, container, "\aF88BFFFF:3 ~ \aFFFFFFFFDelay\r", 1, 11, 1, true, "t", 1, tooltips.delay),
                random_delay = slider(tab, container, "\aF88BFFFF:3 ~ \aFFFFFFFFRandomize delay\r", 1, 11, 1, true, "t", 1, {[1] = "Off"}),
                randomization = slider("AA", "Anti-aimbot angles", "\aF88BFFFF:3 ~ \aFFFFFFFFRandomization", 0, 100, 0, true, "%", 1),
        
                label_anti = label(aa_tab, "   "),
                --Min/Max \a808080FF• \aDCDCDCFF
                force_defensive = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFForce " .. func.hex({menu_r, menu_g, menu_b}) .. "Defensive"),
                defensive_mode = combo(aa_tab, "\n\aF88BFFFF:3 ~ \aFFFFFFFFMode", {"On peek", "Default", "Switch"}),
                defensive_delay = slider(tab, container, "\aF88BFFFF:3 ~ \aFFFFFFFFDefensive delay", 0, 50, 3, true, "%", 1, {[0] = "Default"}),

                defensiveAntiAim = ui.new_checkbox("AA", "Anti-aimbot angles", func.hex({menu_r, menu_g, menu_b}) .. "\aF88BFFFF:3 ~ \aFFFFFFFFDefensive" .. func.hex({200, 200, 200}) ..  " Anti-Aim"),
                def_pitch = combo(aa_tab, "Pitch\n", "Off", "Custom", "Random", "3-way", "Dynamic", "S-Way", "Switch", "Flick"),
                def_pitchSlider = slider("AA", "Anti-aimbot angles", "\nPitch add", -89, 89, 0, true, "°", 1, tooltips.pitch),
                def_pitch_s1 = slider("AA", "Anti-aimbot angles", func.hex({80, 80, 80}) .. "Min/Max" .. func.hex({menu_r, menu_g, menu_b}) .. " pitch", -89, 89, -89, true, "°", 1, tooltips.pitch),
                def_pitch_s2 = slider("AA", "Anti-aimbot angles", "\nTo", -89, 89, 89, true, "°", 1, tooltips.pitch),
                def_slow_gen = slider("AA", "Anti-aimbot angles", "Generate speed\n", 0, 10, 0, true, "", 0.1, {[0] = "Default", [2] = "Static"}),
                def_dyn_speed = slider("AA", "Anti-aimbot angles", "\rSpeed\n", 1, 20, 0, true, "", 1),
                def_jit_delay = slider("AA", "Anti-aimbot angles", "\rDelay\n", 2, 20, 0, true, "", 1),
                def_3_1 = slider("AA", "Anti-aimbot angles", "\rFirst/Second/Third", -89, 89, 0, true, "°", 1, tooltips.pitch),
                def_3_2 = slider("AA", "Anti-aimbot angles", "\nsecond", -89, 89, 0, true, "°", 1, tooltips.pitch),
                def_3_3 = slider("AA", "Anti-aimbot angles", "\nthird", -89, 89, 0, true, "°", 1, tooltips.pitch),
                
                def_yawMode = combo(aa_tab, "\rYaw\n", "Off", "Custom", "Spin", "Small-Spin", "Switch", "Random", "3-ways"),
                def_yawStatic = slider("AA", "Anti-aimbot angles", "\nOffset\r", -180, 180, 0, true, "°", 1),
                def_yaw_spin_range = ui.new_slider("AA", "Anti-aimbot angles", "Range\n", 0, 360, 180, true, "°", 1),
                def_yaw_spin_speed = ui.new_slider("AA", "Anti-aimbot angles", "Speed\n", -15, 15, 4, true, "t", 1),
                def_yaw_left = slider("AA", "Anti-aimbot angles", func.hex({80, 80, 80}) .. "Min/Max" .. func.hex({menu_r, menu_g, menu_b}) .. " yaw", -180, 180, -90, true, "°", 1),
                def_yaw_right = slider("AA", "Anti-aimbot angles", "\n", -180, 180, 90, true, "°", 1),
                def_yaw_random = slider("AA", "Anti-aimbot angles", "Randomization\n", 0, 180, 0, true, "%", 1, {[0] = "Off"}),
                def_yaw_switch_delay = slider("AA", "Anti-aimbot angles", "Delay\n", 2, 20, 2, true, "t", 1, {[2] = "Off"}),
                def_yaw_exploit_speed = slider("AA", "Anti-aimbot angles", "Speed\n", 1, 20, 1, true, "", 0.2),
                def_slow_gena = slider("AA", "Anti-aimbot angles", "Generate speed\n", 0, 10, 0, true, "", 0.1, {[0] = "Default", [2] = "Static"}),
                def_way_1 = slider("AA", "Anti-aimbot angles", "\nfirst", -180, 180, 0, true, "°", 1),
                def_way_2 = slider("AA", "Anti-aimbot angles", "\nsecond", -180, 180, 0, true, "°", 1),
                def_way_3 = slider("AA", "Anti-aimbot angles", "\nthird", -180, 180, 0, true, "°", 1),
        
                bidy = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFAdaptive Body Yaw"), 


                fl_enable = switch(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFCustom fake-lag"),
                fl_mode = combo(fl_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFFake lag mode", {"Maximum", "Random", "Fluculate [custom]"}),
                
                --anti brute
                antibrute_enable = switch(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFOverride " .. func.hex({menu_r, menu_g, menu_b}) .. vars.aaStates[i] .. func.hex({200,200,200}) .. " Anti-brute"),
                antibrute_aa = list(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFAnti-brute AA", {"Yaw", "Modifier", "Body Yaw"}),
                antibrute_yaw = slider("AA", "Anti-aimbot angles",  "\n\aF88BFFFF:3 ~ \aFFFFFFFFYaw", -60, 60, 0, true, "°", 1),
                antibrute_mod = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFModifier", {"None","Center", "Random", "S-Way", "Delayed"}),
                antibrute_mod_range = slider("AA", "Anti-aimbot angles",  "\n\aF88BFFFF:3 ~ \aFFFFFFFFModifier range", -70, 70, 0, true, "°", 1),
                antibrute_body = combo(aa_tab, "\aF88BFFFF:3 ~ \aFFFFFFFFBody Yaw Mode", {"None", "Static", "Jitter", "Delayed"}),
                antibrute_body_range = slider("AA", "Anti-aimbot angles", "\n\aF88BFFFF:3 ~ \aFFFFFFFFBody Range", -59, 59, 0, true, "°", 1),
            }
        end
    --client.exec("clear")

    event_callback("paint_ui", function()
        max_notifs = ui.get(menu.visualsTab.on_screen_max)
    end)
    local anim_time, data = 0.3,  {}
    local notifications = {
        new = function(string, r, g, b)
            if #data >= max_notifs then
                table.remove(data, 1)
            end
            table.insert(data, {
                time = globals.curtime(),
                string = string,
                color = {r, g, b, 255},
                fraction = 0
            })
        end,
        render = function()
            local x, y = client.screen_size()
            local to_remove = {}
            local Offset = 100
            local col1, col2, col3, col4 = ui.get(calar)
            
            for i = 1, #data do
                local notif = data[i]
                local data = {rounding = 8, size = 4, glow = 12, time = 3}
                if notif.time + data.time - globals.curtime() > 0 then
                    notif.fraction = func.clamp(notif.fraction + globals.frametime() / anim_time, 0, 1)
                else
                    notif.fraction = func.clamp(notif.fraction - globals.frametime() / anim_time, 0, 1)
                end
                if notif.fraction <= 0 and notif.time + data.time - globals.curtime() <= 0 then
                    table.insert(to_remove, i)
                else
                    table.remove(to_remove, i)
                end
                local fraction = func.easeInOut(notif.fraction)
                local r, g, b, a = unpack(notif.color)
                local string = color_text(notif.string, r, g, b, a * fraction)
                local strw, strh = renderer.measure_text("", string)
                local strw2 = renderer.measure_text("b", "")
                local alp = 150
                local paddingx, paddingy = 10, data.size
                local offsetY = 0
                Offset = Offset + (strh + paddingy * 2 + math.sqrt(data.glow / 10) * 10 + 5) * fraction
    
                -- Центрируем текст
                local textX = (x / 2) - (strw + strw2) / 2
    
                -- Добавлено для создания красивого фона
                container_glow(textX - paddingx, y - offsetY - strh / 2 - paddingy - Offset,
                              strw + strw2 + paddingx * 4, strh + paddingy * 3,
                              r * 0.5, g * 0.5, b * 0.5, alp, 1.3, col1, col2, col3, function(cx, cy, cw, ch)
                    renderer.text(textX + strw2 / 2, y - offsetY - Offset - 5, 
                    255, 255, 255, 255 * fraction, "b", 0, string)
                end)
            end
            for i = #to_remove, 1, -1 do
                table.remove(data, to_remove[i])
            end
        end,
        clear = function()
            data = {}
        end
    }

    my_font = surface.create_font("Verdana", 12, 500, 128)

    local lua = {
        database = {
            configs = "velours:configs"
        }
    }
    presets,slow_turtle = {}, renderer.load_svg('<svg width="800" height="800" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="iconify iconify--noto"><path d="M112.7 59.21s3.94-2.21 4.93-2.77c.99-.56 4.6-2.82 5.91-.84.77 1.16-.7 4.44-3.05 7.86-2.14 3.13-7.12 9.56-7.4 10.83-.28 1.27 1.11 6.36 1.53 8.33.42 1.97 1.74 6.71 1.17 8.54s-3.43 6.85-10.75 6.76c-5.82-.07-7.51-1.78-7.7-2.82-.14-.75-.56-3.24-.56-3.24s-4.79 2.96-7.04 4.08-8.31 4.22-8.31 4.22 1.17 5.35 1.36 7.51c.19 2.16.86 5.25-.28 7.32-1.03 1.88-4.25 5.02-11.83 4.97-5.92-.04-7.41-1.88-8.35-3-.94-1.13-1.13-6.48-1.13-7.6s-.19-5.07-.19-5.07-8.02-.4-12.86-.75c-4.38-.32-10.16-.99-10.16-.99s.21 2.33.42 4.01c.19 1.5.23 4.64-1.34 6.17-2.11 2.06-7.56 2.21-10.56 1.92-3-.28-7.18-1.83-8.4-4.55-1.22-2.72.38-6.29 1.03-8.35.58-1.81 1.6-4.41 1.22-5.16-.38-.75-4.04-1.69-9.29-6.95-5.26-5.26-12.13-23.52 3.28-36.23 15.49-12.76 43.81 1.1 45.31 2.04 1.54.96 53.04 3.76 53.04 3.76z" fill="#bdcf47"/><path d="M66.25 25.28c-13.93.62-24.38 7.52-29.57 15.06-3.1 4.5-4.65 7.74-4.65 7.74s4.81.14 9.15 2.46c5 2.67 10.8 5.56 14.61 18.13 2.87 9.5 3.98 18.53 11.44 20.52 8.45 2.25 28.16 1.13 37.59-8.02s11.26-16.05 8.87-25.06-13.17-25.05-28.16-29.28C79.06 25 72.58 25 66.25 25.28z" fill="#6e823a"/><path d="M111.93 51.32c-.42-.99-1.3-2.5-1.3-2.5s-.07 2.05-.25 3.13c-.28 1.76-1.25 5.42-1.81 4.88-1-.97-5.73-6.92-7.98-10.23-1.71-2.52-7.6-9.11-7.74-11.26-.07-1.06 1.27-4.65 1.27-4.65s-1.22-.7-2.35-1.34c-.88-.49-2.16-1.03-2.16-1.03s-.77 4.9-1.62 5.82c-.75.81-5.32 2.6-8.87 3.94-4.29 1.62-8.45 3.73-10 4.01-1.36.25-9.09-1.41-12-1.97-3.66-.7-9.18-2.26-10.45-3.17-1.48-1.06-3.07-3.78-3.07-3.78s-.89.61-1.78 1.31c-.88.69-2.02 2.06-2.02 2.06s2.31 2.32 2.44 3.18c.18 1.2-1.27 2.83-2.46 4.38-.72.93-2.75 4.85-2.75 4.85s.97.09 2.15.63c1.23.57 2.38 1.16 2.38 1.16s2.97-6.9 4.9-7.53c1.65-.54 6.3.99 9.68 1.69 4.79.99 9.64 1.87 10.66 3.17 1.06 1.34 2.06 6.68 3.03 11.19C70.89 64.2 73.64 77.02 73 78c-.63.99-5.7.63-8.59.28-2.45-.3-6.41-1.76-6.41-1.76s.58 2.11.77 2.67c.28.81 1.16 3.06 1.16 3.06s5.67 2.5 22.42.95 25.03-12.96 27.38-18.02c3.14-6.78 3.54-10.39 3.54-10.39s-.92-2.48-1.34-3.47zM96.65 73.21c-4.24 2.67-15.2 5.49-17.18 4.43-1.58-.85-3.94-13.94-5.07-19.78-.72-3.74-2.45-9.42-1.41-11.19.7-1.2 4.79-2.99 7.81-4.4 2.87-1.33 6.97-3.13 8.17-2.99 1.7.2 5.35 6.12 9.01 11.19 3.66 5.07 7.67 10.35 7.74 12.18.09 1.84-4.7 7.82-9.07 10.56z" fill="#484e23"/><path d="M41.18 65.86c.5 2.83-.95 5.75-4.07 6.02-2.56.22-4.59-1.57-5.09-4.4s1.14-5.49 3.68-5.94c2.52-.45 4.98 1.48 5.48 4.32zm-18.36.25c.07 2.84-2.42 5.69-5.5 5.11-2.53-.48-3.99-2.73-3.71-5.55.29-2.82 2.59-4.9 5.15-4.65s3.99 2.13 4.06 5.09zm7.95 10.48c1.16-.79 3.1-2.67 4.36-1.06 1.27 1.62-.92 3.1-2.18 4.01-1.27.92-4.08 3.17-6.12 3.17-1.9 0-4.79-2.32-6.62-3.87-1.49-1.26-2.18-2.89-1.34-3.87s2.14-.62 3.24.35c1.27 1.13 3.72 3.38 4.72 3.38.98.01 2.39-1.05 3.94-2.11z" fill="#2a2b28"/></svg>', 100, 100)


    local db = {
        lua = "beta",
    }

    local data = database.read(db.lua)

    if not data then
        data = {
            configs = {},
            stats = {
                killed = 0, evaded = 0, loaded = 1
            },
        }
        database.write(db.lua, data)
    end

    if not data.stats then
        data.stats = {
            killed = 0, evaded = 0, loaded = 1
        }
    end

    if not data.stats.evaded then
        data.stats.evaded = 0
    end

    if not data.stats.killed then
        data.stats.killed = 0
    end

    if not data.stats.loaded then
        data.stats.loaded = 1
    end

    data.stats.loaded = data.stats.loaded + 1

    my = {
        entity = entity.get_local_player()
    }

    database.write(db.lua, data)


    function traverse_table_on(tbl, prefix)
        prefix = prefix or ""
        local stack = {{tbl, prefix}}

        while #stack > 0 do
            local current = table.remove(stack)
            local current_tbl = current[1]
            local current_prefix = current[2]

            for key, value in pairs(current_tbl) do
                local full_key = current_prefix .. key
                if type(value) == "table" then
                    table.insert(stack, {value, full_key .. "."})
                else
                    ui.set_visible(value, true)
                end
            end
        end
    end

    function traverse_table(tbl, prefix, set_visible)
        prefix = prefix or ""
        local stack = {{tbl, prefix}}
        local visited = {}

        while #stack > 0 do
            local current = table.remove(stack)
            local current_tbl = current[1]
            local current_prefix = current[2]

            if not visited[current_tbl] then
                visited[current_tbl] = true

                for key, value in pairs(current_tbl) do
                    local full_key = current_prefix .. key
                    if type(value) == "table" then
                        table.insert(stack, {value, full_key .. "."})
                    else
                        ui.set_visible(value, set_visible)
                    end
                end
            end
        end
    end

    local isEnabled, saved = true, true
    event_callback("paint_ui", function()
        vars.activeState = vars.sToInt[ui.get(menu.builderTab.state)]
        ui.set_visible(tabPicker, isEnabled)
        ui.set_visible(aaTabs, ui.get(tabPicker) == "Anti-aim" and isEnabled)
        ui.set_visible(mTabs, ui.get(tabPicker) == "Settings" and isEnabled)
        --ui.set_visible(iTabs, ui.get(tabPicker) == "Main" and isEnabled)
        traverse_table(binds)
        local isAATab = ui.get(tabPicker) == "Anti-aim" and ui.get(aaTabs) == "Settings"
        local isBuilderTab = ui.get(tabPicker) == "Anti-aim" and ui.get(aaTabs) == "Builder"
        local isVisualsTab = ui.get(tabPicker) == "Settings" and ui.get(mTabs) == "Visuals"
        local isMiscTab = ui.get(tabPicker) == "Settings" and ui.get(mTabs) == "Miscellaneous"
        local isCFGTab = ui.get(tabPicker) == "Main"
        --local isINFOTab = ui.get(tabPicker) == "Main" and ui.get(iTabs) == "Configs/Main"
        for i = 1, #vars.aaStates do
            local stateEnabled = ui.get(aaBuilder[i].enableState)
            ui.set_visible(aaBuilder[i].label_huy, vars.activeState == i and i~=1 and isBuilderTab and isEnabled)
            ui.set_visible(aaBuilder[i].enableState, vars.activeState == i and i~=1 and isBuilderTab and isEnabled)
            ui.set_visible(aaBuilder[i].force_defensive, vars.activeState == i and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].defensive_mode, vars.activeState == i and ui.get(aaBuilder[i].force_defensive) and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].defensive_delay, vars.activeState == i and ui.get(aaBuilder[i].force_defensive) and ui.get(aaBuilder[i].defensive_mode) == "Switch" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].stateDisablers, vars.activeState == 9 and i == 9 and isBuilderTab and ui.get(aaBuilder[9].enableState) and isEnabled)
            ui.set_visible(aaBuilder[i].yaw, (vars.activeState == i and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].yawStatic, vars.activeState == i and ui.get(aaBuilder[i].yaw) == "Offset" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].yawLeft, (vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and (ui.get(aaBuilder[i].yaw) == "Left / Right") and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].yawRight, vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and (ui.get(aaBuilder[i].yaw) == "Left / Right") and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].yawJitter, vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].wayFirst, vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and ui.get(aaBuilder[i].yawJitter) == "3-Way"  and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].waySecond, vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and ui.get(aaBuilder[i].yawJitter) == "3-Way"  and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].wayThird, vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and ui.get(aaBuilder[i].yawJitter) == "3-Way"  and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].yawJitterStatic, vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and ui.get(aaBuilder[i].yawJitter) ~= "Off" and ui.get(aaBuilder[i].yawJitter) ~= "3-Way" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].sway_speed, vars.activeState == i and ui.get(aaBuilder[i].yaw) ~= "Off" and ui.get(aaBuilder[i].yawJitter) == "S-Way" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].bodyYaw, vars.activeState == i and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].bodyYawStatic, vars.activeState == i and ui.get(aaBuilder[i].bodyYaw) ~= "Off" and ui.get(aaBuilder[i].bodyYaw) ~= "Opposite" and ui.get(aaBuilder[i].bodyYaw) ~= "Jitter" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].delayed_body, vars.activeState == i and ui.get(aaBuilder[i].bodyYaw) == "Jitter" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].random_delay, vars.activeState == i and ui.get(aaBuilder[i].bodyYaw) == "Jitter" and ui.get(aaBuilder[i].delayed_body)~=1 and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].randomization, vars.activeState == i and isBuilderTab and stateEnabled and isEnabled)
            
            ui.set_visible(aaBuilder[i].defensiveAntiAim, vars.activeState == i and isBuilderTab and stateEnabled and isEnabled)

            ui.set_visible(aaBuilder[i].def_pitch, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_pitchSlider , ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and ui.get(aaBuilder[i].def_pitch) == "Custom" and isEnabled))
            ui.set_visible(aaBuilder[i].def_pitch_s1 , ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and (ui.get(aaBuilder[i].def_pitch) == "Random" or ui.get(aaBuilder[i].def_pitch) == "Switch" or ui.get(aaBuilder[i].def_pitch) == "Flick" or ui.get(aaBuilder[i].def_pitch) == "Dynamic" or ui.get(aaBuilder[i].def_pitch) == "S-Way") and isEnabled))
            ui.set_visible(aaBuilder[i].def_pitch_s2 , ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and (ui.get(aaBuilder[i].def_pitch) == "Random" or ui.get(aaBuilder[i].def_pitch) == "Switch" or ui.get(aaBuilder[i].def_pitch) == "Flick" or ui.get(aaBuilder[i].def_pitch) == "Dynamic" or ui.get(aaBuilder[i].def_pitch) == "S-Way") and isEnabled))
            ui.set_visible(aaBuilder[i].def_slow_gen, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and ui.get(aaBuilder[i].def_pitch) == "Random" and isEnabled))
            ui.set_visible(aaBuilder[i].def_dyn_speed, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and (ui.get(aaBuilder[i].def_pitch) == "Dynamic" or ui.get(aaBuilder[i].def_pitch) == "S-Way") and isEnabled))
            ui.set_visible(aaBuilder[i].def_jit_delay, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and ui.get(aaBuilder[i].def_pitch) == "Switch" and isEnabled))
            ui.set_visible(aaBuilder[i].def_3_1, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and ui.get(aaBuilder[i].def_pitch) == "3-way" and isEnabled))
            ui.set_visible(aaBuilder[i].def_3_2, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and ui.get(aaBuilder[i].def_pitch) == "3-way" and isEnabled))
            ui.set_visible(aaBuilder[i].def_3_3, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and ui.get(aaBuilder[i].def_pitch) == "3-way" and isEnabled))
            ui.set_visible(aaBuilder[i].def_yawMode, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_yawStatic, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and (ui.get(aaBuilder[i].def_yawMode) == "Custom") and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_yaw_spin_range, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and ui.get(aaBuilder[i].def_yawMode) == "Spin" and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_yaw_spin_speed, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and ui.get(aaBuilder[i].def_yawMode) == "Spin" and isBuilderTab and stateEnabled and isEnabled))

            ui.set_visible(aaBuilder[i].def_yaw_left, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and (ui.get(aaBuilder[i].def_yawMode) == "Switch" or ui.get(aaBuilder[i].def_yawMode) == "Random" or ui.get(aaBuilder[i].def_yawMode) == "Small-Spin") and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_yaw_right, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and (ui.get(aaBuilder[i].def_yawMode) == "Switch" or ui.get(aaBuilder[i].def_yawMode) == "Random" or ui.get(aaBuilder[i].def_yawMode) == "Small-Spin") and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_yaw_switch_delay, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and ui.get(aaBuilder[i].def_yawMode) == "Switch" and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_yaw_random, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and (ui.get(aaBuilder[i].def_yawMode) == "Switch" or ui.get(aaBuilder[i].def_yawMode) == "Custom") and isBuilderTab and stateEnabled and isEnabled))

            ui.set_visible(aaBuilder[i].def_yaw_exploit_speed, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and (ui.get(aaBuilder[i].def_yawMode) == "Small-Spin") and isBuilderTab and stateEnabled and isEnabled))
            
            ui.set_visible(aaBuilder[i].def_slow_gena, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and ui.get(aaBuilder[i].def_yawMode) == "Random" and isBuilderTab and stateEnabled and isEnabled))
            
            ui.set_visible(aaBuilder[i].def_way_1, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and ui.get(aaBuilder[i].def_yawMode) == "3-ways" and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_way_2, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and ui.get(aaBuilder[i].def_yawMode) == "3-ways" and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].def_way_3, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and ui.get(aaBuilder[i].def_yawMode) == "3-ways" and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].bidy, ui.get(aaBuilder[i].defensiveAntiAim) and (vars.activeState == i and isBuilderTab and stateEnabled and isEnabled))
            ui.set_visible(aaBuilder[i].label_anti, vars.activeState == i and isBuilderTab and stateEnabled and isEnabled)

            ui.set_visible(aaBuilder[i].fl_enable, vars.activeState == i and isBuilderTab and stateEnabled and isEnabled and not i==9)
            ui.set_visible(aaBuilder[i].fl_mode, vars.activeState == i and ui.get(aaBuilder[i].fl_enable) and isBuilderTab and stateEnabled and isEnabled and not i==9)

            ui.set_visible(aaBuilder[i].antibrute_enable, vars.activeState == i and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].antibrute_aa, vars.activeState == i and ui.get(aaBuilder[i].antibrute_enable) and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].antibrute_yaw, vars.activeState == i and ui.get(aaBuilder[i].antibrute_enable) and func.includes(ui.get(aaBuilder[i].antibrute_aa), "Yaw") and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].antibrute_mod, vars.activeState == i and ui.get(aaBuilder[i].antibrute_enable) and func.includes(ui.get(aaBuilder[i].antibrute_aa), "Modifier") and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].antibrute_mod_range, vars.activeState == i and ui.get(aaBuilder[i].antibrute_enable) and func.includes(ui.get(aaBuilder[i].antibrute_aa), "Modifier") and ui.get(aaBuilder[i].antibrute_mod) ~= "-" and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].antibrute_body, vars.activeState == i and ui.get(aaBuilder[i].antibrute_enable) and func.includes(ui.get(aaBuilder[i].antibrute_aa), "Body Yaw") and isBuilderTab and stateEnabled and isEnabled)
            ui.set_visible(aaBuilder[i].antibrute_body_range, vars.activeState == i and ui.get(aaBuilder[i].antibrute_enable) and func.includes(ui.get(aaBuilder[i].antibrute_aa), "Body Yaw") and ui.get(aaBuilder[i].antibrute_body) ~= "-"and isBuilderTab and stateEnabled and isEnabled)
            
            
        --[[ui.set_enabled(aaBuilder[i].antibrute_enable, false)
        ui.set_enabled(aaBuilder[i].antibrute_aa, false)
        ui.set_enabled(aaBuilder[i].antibrute_yaw, false)
        ui.set_enabled(aaBuilder[i].antibrute_mod, false)
        ui.set_enabled(aaBuilder[i].antibrute_mod_range, false)
        ui.set_enabled(aaBuilder[i].antibrute_body, false)
        ui.set_enabled(aaBuilder[i].antibrute_body_range, false)]]
        end

        for i, feature in pairs(menu.aaTab) do
            ui.set_visible(feature, isAATab and isEnabled)
        end

        for i, feature in pairs(menu.builderTab) do
            ui.set_visible(feature, isBuilderTab and isEnabled)
        end

        for i, feature in pairs(menu.visualsTab) do
            if type(feature) ~= "table" then
                ui.set_visible(feature, isVisualsTab and isEnabled)
            end
        end
        
        for i, feature in pairs(menu.miscTab) do
            if type(feature) ~= "table" then
                ui.set_visible(feature, isMiscTab and isEnabled)
            end
        end

        ui.set_visible(menu.miscTab.clantag_mode, ui.get(menu.miscTab.clanTag) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.killsay_type, ui.get(menu.miscTab.killsay) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.killsay_add, ui.get(menu.miscTab.killsay) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.console_logs_resolver, ui.get(menu.miscTab.console_logs_custom_vibor) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.auto_smoke_bind, ui.get(menu.miscTab.auto_smoke) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.auto_smoke_cam, ui.get(menu.miscTab.auto_smoke) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.colorchinareal, ui.get(menu.miscTab.enablechina) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.gradientchina, ui.get(menu.miscTab.enablechina) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.speedchina, ui.get(menu.miscTab.gradientchina) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.drop_grenades_hotkey, ui.get(menu.miscTab.drop_grenades_helper) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.settingsmatchqwe, ui.get(menu.miscTab.settingsmatch) and (isMiscTab and isEnabled))
        ui.set_visible(menu.miscTab.vgui_color, ui.get(menu.miscTab.vgui_color_checkbox) and (isMiscTab and isEnabled))
        ui.set_visible(menu.visualsTab.molotov_radius_reference, ui.get(menu.visualsTab.grenade_radius) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.smoke_radius_reference, ui.get(menu.visualsTab.grenade_radius) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.smoke_radius, ui.get(menu.visualsTab.grenade_radius) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.molotov_radius, ui.get(menu.visualsTab.grenade_radius) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.asp_v, ui.get(menu.visualsTab.asp) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.animates_left_down, ui.get(menu.visualsTab.snowball) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.snowflake_count, ui.get(menu.visualsTab.snowball) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.snowflake_speed, ui.get(menu.visualsTab.snowball) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.animate_left_down, ui.get(menu.visualsTab.fireball) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.fireball_count, ui.get(menu.visualsTab.fireball) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.fireball_speed, ui.get(menu.visualsTab.fireball) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.bul_dur, ui.get(menu.visualsTab.bul_trace) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.bul_color, ui.get(menu.visualsTab.bul_trace) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.rgb_tracers, ui.get(menu.visualsTab.bul_trace) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.rgb_speed, ui.get(menu.visualsTab.rgb_tracers) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.tracers_width, ui.get(menu.visualsTab.bul_trace) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.min_ind_mode, ui.get(menu.visualsTab.min_ind) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.min_text, ui.get(menu.visualsTab.min_ind) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.third_dis, ui.get(menu.visualsTab.third_) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.on_screen_v, ui.get(menu.visualsTab.on_screen_logs) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.visualsTab.on_screen_max, ui.get(menu.visualsTab.on_screen_logs) and (isVisualsTab and isEnabled))
        ui.set_visible(menu.aaTab.avoid_dist, ui.get(menu.aaTab.anti_knife) and isAATab)
        ui.set_visible(menu.aaTab.safe_flick, isAATab and (func.includes(ui.get(menu.aaTab.safe_head), "Knife") or func.includes(ui.get(menu.aaTab.safe_head), "Air Zeus hold")))
        ui.set_visible(menu.aaTab.safe_flick_mode, isAATab and (ui.get(menu.aaTab.safe_flick) and (func.includes(ui.get(menu.aaTab.safe_head), "Knife") or func.includes(ui.get(menu.aaTab.safe_head), "Air Zeus hold"))))
        ui.set_visible(menu.aaTab.safe_flick_pitch, isAATab and (ui.get(menu.aaTab.safe_flick) and ui.get(menu.aaTab.safe_flick_mode) == "E spam" and (func.includes(ui.get(menu.aaTab.safe_head), "Knife") or func.includes(ui.get(menu.aaTab.safe_head), "Air Zeus hold"))))
        ui.set_visible(menu.aaTab.safe_flick_pitch_value, isAATab and (ui.get(menu.aaTab.safe_flick) and ui.get(menu.aaTab.safe_flick_mode) == "E spam" and (ui.get(menu.aaTab.safe_flick_pitch) == "Custom") and (func.includes(ui.get(menu.aaTab.safe_head), "Knife") or func.includes(ui.get(menu.aaTab.safe_head), "Air Zeus hold"))))

        ui.set_visible(menu.visualsTab.viewmodel_fov, ui.get(menu.visualsTab.viewmodel_en) and isVisualsTab)
        ui.set_visible(menu.visualsTab.viewmodel_x, ui.get(menu.visualsTab.viewmodel_en) and isVisualsTab)
        ui.set_visible(menu.visualsTab.viewmodel_y, ui.get(menu.visualsTab.viewmodel_en) and isVisualsTab)
        ui.set_visible(menu.visualsTab.viewmodel_z, ui.get(menu.visualsTab.viewmodel_en) and isVisualsTab)
        ui.set_visible(menu.visualsTab.widgets_slow, ui.get(menu.visualsTab.slow_down) and isVisualsTab)
        ui.set_visible(menu.visualsTab.widgets_slow_length, ui.get(menu.visualsTab.slow_down) and isVisualsTab)
        ui.set_visible(menu.visualsTab.widgets_slow_width, ui.get(menu.visualsTab.slow_down) and isVisualsTab)

        ui.set_visible(menu.visualsTab.arows_txt_color, ui.get(menu.visualsTab.arows_txt) and isVisualsTab)
        ui.set_visible(menu.visualsTab.arows_txt_offset, ui.get(menu.visualsTab.arows_txt) and isVisualsTab)

        ui.set_visible(menu.visualsTab.custom_color, ui.get(menu.visualsTab.custom_scope) and isVisualsTab)
        ui.set_visible(menu.visualsTab.custom_initial_pos, ui.get(menu.visualsTab.custom_scope) and isVisualsTab)
        ui.set_visible(menu.visualsTab.custom_offset, ui.get(menu.visualsTab.custom_scope) and isVisualsTab)

        ui.set(lableb321, text_fade_animation(3, 255,192,203, 255, "velours ~ " .. script_build))
        for i, feature in pairs(menu.configTab) do
            ui.set_visible(feature, isCFGTab and isEnabled)
            ui.set_visible(menu.configTab.name, false)
        end

        for i, feature in pairs(menu.extras) do
            ui.set_visible(feature, false)
        end

        if not isEnabled and not saved then
            func.resetAATab()
            ui.set(refs.fsBodyYaw, isEnabled)
            ui.set(refs.enabled, isEnabled)
            saved = true
        elseif isEnabled and saved then
            ui.set(refs.fsBodyYaw, not isEnabled)
            ui.set(refs.enabled, isEnabled)
            saved = false
        end
        func.setAATab(not isEnabled)
    end)


    local velours = {}

    velours.config_data = {}
    velours.config_data.cfg_data = {
        anti_aim = {
            -- 1
            aaBuilder[1].enableState;
            aaBuilder[1].stateDisablers;
            aaBuilder[1].yaw;
            aaBuilder[1].yawStatic;
            aaBuilder[1].yawLeft;
            aaBuilder[1].yawRight;
            aaBuilder[1].yawJitter;
            aaBuilder[1].wayFirst;
            aaBuilder[1].waySecond;
            aaBuilder[1].wayThird;
            aaBuilder[1].yawJitterStatic;
            aaBuilder[1].sway_speed;
            aaBuilder[1].bodyYaw;
            aaBuilder[1].bodyYawStatic;
            aaBuilder[1].delayed_body;
            aaBuilder[1].randomization;
            aaBuilder[1].force_defensive;
            aaBuilder[1].defensive_mode;
            aaBuilder[1].defensiveAntiAim;
            aaBuilder[1].def_pitch;
            aaBuilder[1].def_pitchSlider;
            aaBuilder[1].def_pitch_s1;
            aaBuilder[1].def_pitch_s2;
            aaBuilder[1].def_slow_gen;
            aaBuilder[1].def_dyn_speed;
            aaBuilder[1].def_jit_delay;
            aaBuilder[1].def_3_1;
            aaBuilder[1].def_3_2;
            aaBuilder[1].def_3_3;
            aaBuilder[1].def_yawMode;
            aaBuilder[1].def_yaw_spin_gs_mode;
            aaBuilder[1].def_yawStatic;
            aaBuilder[1].def_yaw_spin_range;
            aaBuilder[1].def_yaw_spin_speed;
            aaBuilder[1].def_yaw_spin_tick;
            aaBuilder[1].def_yaw_left;
            aaBuilder[1].def_yaw_right;
            aaBuilder[1].def_yaw_switch_delay;
            aaBuilder[1].def_yaw_exploit_speed;
            aaBuilder[1].def_slow_gena;
            aaBuilder[1].def_way_1;
            aaBuilder[1].def_way_2;
            aaBuilder[1].def_way_3;
            aaBuilder[1].bidy;
            aaBuilder[1].label_anti;
            aaBuilder[1].antibrute_enable;
            aaBuilder[1].antibrute_aa;
            aaBuilder[1].antibrute_yaw;
            aaBuilder[1].antibrute_mod;
            aaBuilder[1].antibrute_mod_range;
            aaBuilder[1].antibrute_body;
            aaBuilder[1].antibrute_body_range;

            -- 2
            aaBuilder[2].enableState;
            aaBuilder[2].stateDisablers;
            aaBuilder[2].yaw;
            aaBuilder[2].yawStatic;
            aaBuilder[2].yawLeft;
            aaBuilder[2].yawRight;
            aaBuilder[2].yawJitter;
            aaBuilder[2].wayFirst;
            aaBuilder[2].waySecond;
            aaBuilder[2].wayThird;
            aaBuilder[2].yawJitterStatic;
            aaBuilder[2].sway_speed;
            aaBuilder[2].bodyYaw;
            aaBuilder[2].bodyYawStatic;
            aaBuilder[2].delayed_body;
            aaBuilder[2].randomization;
            aaBuilder[2].force_defensive;
            aaBuilder[2].defensive_mode;
            aaBuilder[2].defensiveAntiAim;
            aaBuilder[2].def_pitch;
            aaBuilder[2].def_pitchSlider;
            aaBuilder[2].def_pitch_s1;
            aaBuilder[2].def_pitch_s2;
            aaBuilder[2].def_slow_gen;
            aaBuilder[2].def_dyn_speed;
            aaBuilder[2].def_jit_delay;
            aaBuilder[2].def_3_1;
            aaBuilder[2].def_3_2;
            aaBuilder[2].def_3_3;
            aaBuilder[2].def_yawMode;
            aaBuilder[2].def_yaw_spin_gs_mode;
            aaBuilder[2].def_yawStatic;
            aaBuilder[2].def_yaw_spin_range;
            aaBuilder[2].def_yaw_spin_speed;
            aaBuilder[2].def_yaw_spin_tick;
            aaBuilder[2].def_yaw_left;
            aaBuilder[2].def_yaw_right;
            aaBuilder[2].def_yaw_switch_delay;
            aaBuilder[2].def_yaw_exploit_speed;
            aaBuilder[2].def_slow_gena;
            aaBuilder[2].def_way_1;
            aaBuilder[2].def_way_2;
            aaBuilder[2].def_way_3;
            aaBuilder[2].bidy;
            aaBuilder[2].label_anti;
            aaBuilder[2].antibrute_enable;
            aaBuilder[2].antibrute_aa;
            aaBuilder[2].antibrute_yaw;
            aaBuilder[2].antibrute_mod;
            aaBuilder[2].antibrute_mod_range;
            aaBuilder[2].antibrute_body;
            aaBuilder[2].antibrute_body_range;

            --3
            aaBuilder[3].enableState;
            aaBuilder[3].stateDisablers;
            aaBuilder[3].yaw;
            aaBuilder[3].yawStatic;
            aaBuilder[3].yawLeft;
            aaBuilder[3].yawRight;
            aaBuilder[3].yawJitter;
            aaBuilder[3].wayFirst;
            aaBuilder[3].waySecond;
            aaBuilder[3].wayThird;
            aaBuilder[3].yawJitterStatic;
            aaBuilder[3].sway_speed;
            aaBuilder[3].bodyYaw;
            aaBuilder[3].bodyYawStatic;
            aaBuilder[3].delayed_body;
            aaBuilder[3].randomization;
            aaBuilder[3].force_defensive;
            aaBuilder[3].defensive_mode;
            aaBuilder[3].defensiveAntiAim;
            aaBuilder[3].def_pitch;
            aaBuilder[3].def_pitchSlider;
            aaBuilder[3].def_pitch_s1;
            aaBuilder[3].def_pitch_s2;
            aaBuilder[3].def_slow_gen;
            aaBuilder[3].def_dyn_speed;
            aaBuilder[3].def_jit_delay;
            aaBuilder[3].def_3_1;
            aaBuilder[3].def_3_2;
            aaBuilder[3].def_3_3;
            aaBuilder[3].def_yawMode;
            aaBuilder[3].def_yaw_spin_gs_mode;
            aaBuilder[3].def_yawStatic;
            aaBuilder[3].def_yaw_spin_range;
            aaBuilder[3].def_yaw_spin_speed;
            aaBuilder[3].def_yaw_spin_tick;
            aaBuilder[3].def_yaw_left;
            aaBuilder[3].def_yaw_right;
            aaBuilder[3].def_yaw_switch_delay;
            aaBuilder[3].def_yaw_exploit_speed;
            aaBuilder[3].def_slow_gena;
            aaBuilder[3].def_way_1;
            aaBuilder[3].def_way_2;
            aaBuilder[3].def_way_3;
            aaBuilder[3].bidy;
            aaBuilder[3].label_anti;
            aaBuilder[3].antibrute_enable;
            aaBuilder[3].antibrute_aa;
            aaBuilder[3].antibrute_yaw;
            aaBuilder[3].antibrute_mod;
            aaBuilder[3].antibrute_mod_range;
            aaBuilder[3].antibrute_body;
            aaBuilder[3].antibrute_body_range;

            --4
            aaBuilder[4].enableState;
            aaBuilder[4].stateDisablers;
            aaBuilder[4].yaw;
            aaBuilder[4].yawStatic;
            aaBuilder[4].yawLeft;
            aaBuilder[4].yawRight;
            aaBuilder[4].yawJitter;
            aaBuilder[4].wayFirst;
            aaBuilder[4].waySecond;
            aaBuilder[4].wayThird;
            aaBuilder[4].yawJitterStatic;
            aaBuilder[4].sway_speed;
            aaBuilder[4].bodyYaw;
            aaBuilder[4].bodyYawStatic;
            aaBuilder[4].delayed_body;
            aaBuilder[4].randomization;
            aaBuilder[4].force_defensive;
            aaBuilder[4].defensive_mode;
            aaBuilder[4].defensiveAntiAim;
            aaBuilder[4].def_pitch;
            aaBuilder[4].def_pitchSlider;
            aaBuilder[4].def_pitch_s1;
            aaBuilder[4].def_pitch_s2;
            aaBuilder[4].def_slow_gen;
            aaBuilder[4].def_dyn_speed;
            aaBuilder[4].def_jit_delay;
            aaBuilder[4].def_3_1;
            aaBuilder[4].def_3_2;
            aaBuilder[4].def_3_3;
            aaBuilder[4].def_yawMode;
            aaBuilder[4].def_yaw_spin_gs_mode;
            aaBuilder[4].def_yawStatic;
            aaBuilder[4].def_yaw_spin_range;
            aaBuilder[4].def_yaw_spin_speed;
            aaBuilder[4].def_yaw_spin_tick;
            aaBuilder[4].def_yaw_left;
            aaBuilder[4].def_yaw_right;
            aaBuilder[4].def_yaw_switch_delay;
            aaBuilder[4].def_yaw_exploit_speed;
            aaBuilder[4].def_slow_gena;
            aaBuilder[4].def_way_1;
            aaBuilder[4].def_way_2;
            aaBuilder[4].def_way_3;
            aaBuilder[4].bidy;
            aaBuilder[4].label_anti;
            aaBuilder[4].antibrute_enable;
            aaBuilder[4].antibrute_aa;
            aaBuilder[4].antibrute_yaw;
            aaBuilder[4].antibrute_mod;
            aaBuilder[4].antibrute_mod_range;
            aaBuilder[4].antibrute_body;
            aaBuilder[4].antibrute_body_range;

            --5
            aaBuilder[5].enableState;
            aaBuilder[5].stateDisablers;
            aaBuilder[5].yaw;
            aaBuilder[5].yawStatic;
            aaBuilder[5].yawLeft;
            aaBuilder[5].yawRight;
            aaBuilder[5].yawJitter;
            aaBuilder[5].wayFirst;
            aaBuilder[5].waySecond;
            aaBuilder[5].wayThird;
            aaBuilder[5].yawJitterStatic;
            aaBuilder[5].sway_speed;
            aaBuilder[5].bodyYaw;
            aaBuilder[5].bodyYawStatic;
            aaBuilder[5].delayed_body;
            aaBuilder[5].randomization;
            aaBuilder[5].force_defensive;
            aaBuilder[5].defensive_mode;
            aaBuilder[5].defensiveAntiAim;
            aaBuilder[5].def_pitch;
            aaBuilder[5].def_pitchSlider;
            aaBuilder[5].def_pitch_s1;
            aaBuilder[5].def_pitch_s2;
            aaBuilder[5].def_slow_gen;
            aaBuilder[5].def_dyn_speed;
            aaBuilder[5].def_jit_delay;
            aaBuilder[5].def_3_1;
            aaBuilder[5].def_3_2;
            aaBuilder[5].def_3_3;
            aaBuilder[5].def_yawMode;
            aaBuilder[5].def_yaw_spin_gs_mode;
            aaBuilder[5].def_yawStatic;
            aaBuilder[5].def_yaw_spin_range;
            aaBuilder[5].def_yaw_spin_speed;
            aaBuilder[5].def_yaw_spin_tick;
            aaBuilder[5].def_yaw_left;
            aaBuilder[5].def_yaw_right;
            aaBuilder[5].def_yaw_switch_delay;
            aaBuilder[5].def_yaw_exploit_speed;
            aaBuilder[5].def_slow_gena;
            aaBuilder[5].def_way_1;
            aaBuilder[5].def_way_2;
            aaBuilder[5].def_way_3;
            aaBuilder[5].bidy;
            aaBuilder[5].label_anti;
            aaBuilder[5].antibrute_enable;
            aaBuilder[5].antibrute_aa;
            aaBuilder[5].antibrute_yaw;
            aaBuilder[5].antibrute_mod;
            aaBuilder[5].antibrute_mod_range;
            aaBuilder[5].antibrute_body;
            aaBuilder[5].antibrute_body_range;

            --6
            aaBuilder[6].enableState;
            aaBuilder[6].stateDisablers;
            aaBuilder[6].yaw;
            aaBuilder[6].yawStatic;
            aaBuilder[6].yawLeft;
            aaBuilder[6].yawRight;
            aaBuilder[6].yawJitter;
            aaBuilder[6].wayFirst;
            aaBuilder[6].waySecond;
            aaBuilder[6].wayThird;
            aaBuilder[6].yawJitterStatic;
            aaBuilder[6].sway_speed;
            aaBuilder[6].bodyYaw;
            aaBuilder[6].bodyYawStatic;
            aaBuilder[6].delayed_body;
            aaBuilder[6].randomization;
            aaBuilder[6].force_defensive;
            aaBuilder[6].defensive_mode;
            aaBuilder[6].defensiveAntiAim;
            aaBuilder[6].def_pitch;
            aaBuilder[6].def_pitchSlider;
            aaBuilder[6].def_pitch_s1;
            aaBuilder[6].def_pitch_s2;
            aaBuilder[6].def_slow_gen;
            aaBuilder[6].def_dyn_speed;
            aaBuilder[6].def_jit_delay;
            aaBuilder[6].def_3_1;
            aaBuilder[6].def_3_2;
            aaBuilder[6].def_3_3;
            aaBuilder[6].def_yawMode;
            aaBuilder[6].def_yaw_spin_gs_mode;
            aaBuilder[6].def_yawStatic;
            aaBuilder[6].def_yaw_spin_range;
            aaBuilder[6].def_yaw_spin_speed;
            aaBuilder[6].def_yaw_spin_tick;
            aaBuilder[6].def_yaw_left;
            aaBuilder[6].def_yaw_right;
            aaBuilder[6].def_yaw_switch_delay;
            aaBuilder[6].def_yaw_exploit_speed;
            aaBuilder[6].def_slow_gena;
            aaBuilder[6].def_way_1;
            aaBuilder[6].def_way_2;
            aaBuilder[6].def_way_3;
            aaBuilder[6].bidy;
            aaBuilder[6].label_anti;
            aaBuilder[6].antibrute_enable;
            aaBuilder[6].antibrute_aa;
            aaBuilder[6].antibrute_yaw;
            aaBuilder[6].antibrute_mod;
            aaBuilder[6].antibrute_mod_range;
            aaBuilder[6].antibrute_body;
            aaBuilder[6].antibrute_body_range;

            --7
            aaBuilder[7].enableState;
            aaBuilder[7].stateDisablers;
            aaBuilder[7].yaw;
            aaBuilder[7].yawStatic;
            aaBuilder[7].yawLeft;
            aaBuilder[7].yawRight;
            aaBuilder[7].yawJitter;
            aaBuilder[7].wayFirst;
            aaBuilder[7].waySecond;
            aaBuilder[7].wayThird;
            aaBuilder[7].yawJitterStatic;
            aaBuilder[7].sway_speed;
            aaBuilder[7].bodyYaw;
            aaBuilder[7].bodyYawStatic;
            aaBuilder[7].delayed_body;
            aaBuilder[7].randomization;
            aaBuilder[7].force_defensive;
            aaBuilder[7].defensive_mode;
            aaBuilder[7].defensiveAntiAim;
            aaBuilder[7].def_pitch;
            aaBuilder[7].def_pitchSlider;
            aaBuilder[7].def_pitch_s1;
            aaBuilder[7].def_pitch_s2;
            aaBuilder[7].def_slow_gen;
            aaBuilder[7].def_dyn_speed;
            aaBuilder[7].def_jit_delay;
            aaBuilder[7].def_3_1;
            aaBuilder[7].def_3_2;
            aaBuilder[7].def_3_3;
            aaBuilder[7].def_yawMode;
            aaBuilder[7].def_yaw_spin_gs_mode;
            aaBuilder[7].def_yawStatic;
            aaBuilder[7].def_yaw_spin_range;
            aaBuilder[7].def_yaw_spin_speed;
            aaBuilder[7].def_yaw_spin_tick;
            aaBuilder[7].def_yaw_left;
            aaBuilder[7].def_yaw_right;
            aaBuilder[7].def_yaw_switch_delay;
            aaBuilder[7].def_yaw_exploit_speed;
            aaBuilder[7].def_slow_gena;
            aaBuilder[7].def_way_1;
            aaBuilder[7].def_way_2;
            aaBuilder[7].def_way_3;
            aaBuilder[7].bidy;
            aaBuilder[7].label_anti;
            aaBuilder[7].antibrute_enable;
            aaBuilder[7].antibrute_aa;
            aaBuilder[7].antibrute_yaw;
            aaBuilder[7].antibrute_mod;
            aaBuilder[7].antibrute_mod_range;
            aaBuilder[7].antibrute_body;
            aaBuilder[7].antibrute_body_range;

            --8
            aaBuilder[8].enableState;
            aaBuilder[8].stateDisablers;
            aaBuilder[8].yaw;
            aaBuilder[8].yawStatic;
            aaBuilder[8].yawLeft;
            aaBuilder[8].yawRight;
            aaBuilder[8].yawJitter;
            aaBuilder[8].wayFirst;
            aaBuilder[8].waySecond;
            aaBuilder[8].wayThird;
            aaBuilder[8].yawJitterStatic;
            aaBuilder[8].sway_speed;
            aaBuilder[8].bodyYaw;
            aaBuilder[8].bodyYawStatic;
            aaBuilder[8].delayed_body;
            aaBuilder[8].randomization;
            aaBuilder[8].force_defensive;
            aaBuilder[8].defensive_mode;
            aaBuilder[8].defensiveAntiAim;
            aaBuilder[8].def_pitch;
            aaBuilder[8].def_pitchSlider;
            aaBuilder[8].def_pitch_s1;
            aaBuilder[8].def_pitch_s2;
            aaBuilder[8].def_slow_gen;
            aaBuilder[8].def_dyn_speed;
            aaBuilder[8].def_jit_delay;
            aaBuilder[8].def_3_1;
            aaBuilder[8].def_3_2;
            aaBuilder[8].def_3_3;
            aaBuilder[8].def_yawMode;
            aaBuilder[8].def_yaw_spin_gs_mode;
            aaBuilder[8].def_yawStatic;
            aaBuilder[8].def_yaw_spin_range;
            aaBuilder[8].def_yaw_spin_speed;
            aaBuilder[8].def_yaw_spin_tick;
            aaBuilder[8].def_yaw_left;
            aaBuilder[8].def_yaw_right;
            aaBuilder[8].def_yaw_switch_delay;
            aaBuilder[8].def_yaw_exploit_speed;
            aaBuilder[8].def_slow_gena;
            aaBuilder[8].def_way_1;
            aaBuilder[8].def_way_2;
            aaBuilder[8].def_way_3;
            aaBuilder[8].bidy;
            aaBuilder[8].label_anti;
            aaBuilder[8].antibrute_enable;
            aaBuilder[8].antibrute_aa;
            aaBuilder[8].antibrute_yaw;
            aaBuilder[8].antibrute_mod;
            aaBuilder[8].antibrute_mod_range;
            aaBuilder[8].antibrute_body;
            aaBuilder[8].antibrute_body_range;

            --9
            aaBuilder[9].enableState;
            aaBuilder[9].stateDisablers;
            aaBuilder[9].yaw;
            aaBuilder[9].yawStatic;
            aaBuilder[9].yawLeft;
            aaBuilder[9].yawRight;
            aaBuilder[9].yawJitter;
            aaBuilder[9].wayFirst;
            aaBuilder[9].waySecond;
            aaBuilder[9].wayThird;
            aaBuilder[9].yawJitterStatic;
            aaBuilder[9].sway_speed;
            aaBuilder[9].bodyYaw;
            aaBuilder[9].bodyYawStatic;
            aaBuilder[9].delayed_body;
            aaBuilder[9].randomization;
            aaBuilder[9].force_defensive;
            aaBuilder[9].defensive_mode;
            aaBuilder[9].defensiveAntiAim;
            aaBuilder[9].def_pitch;
            aaBuilder[9].def_pitchSlider;
            aaBuilder[9].def_pitch_s1;
            aaBuilder[9].def_pitch_s2;
            aaBuilder[9].def_slow_gen;
            aaBuilder[9].def_dyn_speed;
            aaBuilder[9].def_jit_delay;
            aaBuilder[9].def_3_1;
            aaBuilder[9].def_3_2;
            aaBuilder[9].def_3_3;
            aaBuilder[9].def_yawMode;
            aaBuilder[9].def_yaw_spin_gs_mode;
            aaBuilder[9].def_yawStatic;
            aaBuilder[9].def_yaw_spin_range;
            aaBuilder[9].def_yaw_spin_speed;
            aaBuilder[9].def_yaw_spin_tick;
            aaBuilder[9].def_yaw_left;
            aaBuilder[9].def_yaw_right;
            aaBuilder[9].def_yaw_switch_delay;
            aaBuilder[9].def_yaw_exploit_speed;
            aaBuilder[9].def_slow_gena;
            aaBuilder[9].def_way_1;
            aaBuilder[9].def_way_2;
            aaBuilder[9].def_way_3;
            aaBuilder[9].bidy;
            aaBuilder[9].label_anti;
            aaBuilder[9].antibrute_enable;
            aaBuilder[9].antibrute_aa;
            aaBuilder[9].antibrute_yaw;
            aaBuilder[9].antibrute_mod;
            aaBuilder[9].antibrute_mod_range;
            aaBuilder[9].antibrute_body;
            aaBuilder[9].antibrute_body_range;

            --10
            aaBuilder[10].enableState;
            aaBuilder[10].stateDisablers;
            aaBuilder[10].yaw;
            aaBuilder[10].yawStatic;
            aaBuilder[10].yawLeft;
            aaBuilder[10].yawRight;
            aaBuilder[10].yawJitter;
            aaBuilder[10].wayFirst;
            aaBuilder[10].waySecond;
            aaBuilder[10].wayThird;
            aaBuilder[10].yawJitterStatic;
            aaBuilder[10].sway_speed;
            aaBuilder[10].bodyYaw;
            aaBuilder[10].bodyYawStatic;
            aaBuilder[10].delayed_body;
            aaBuilder[10].randomization;
            aaBuilder[10].force_defensive;
            aaBuilder[10].defensive_mode;
            aaBuilder[10].defensiveAntiAim;
            aaBuilder[10].def_pitch;
            aaBuilder[10].def_pitchSlider;
            aaBuilder[10].def_pitch_s1;
            aaBuilder[10].def_pitch_s2;
            aaBuilder[10].def_slow_gen;
            aaBuilder[10].def_dyn_speed;
            aaBuilder[10].def_jit_delay;
            aaBuilder[10].def_3_1;
            aaBuilder[10].def_3_2;
            aaBuilder[10].def_3_3;
            aaBuilder[10].def_yawMode;
            aaBuilder[10].def_yaw_spin_gs_mode;
            aaBuilder[10].def_yawStatic;
            aaBuilder[10].def_yaw_spin_range;
            aaBuilder[10].def_yaw_spin_speed;
            aaBuilder[10].def_yaw_spin_tick;
            aaBuilder[10].def_yaw_left;
            aaBuilder[10].def_yaw_right;
            aaBuilder[10].def_yaw_switch_delay;
            aaBuilder[10].def_yaw_exploit_speed;
            aaBuilder[10].def_slow_gena;
            aaBuilder[10].def_way_1;
            aaBuilder[10].def_way_2;
            aaBuilder[10].def_way_3;
            aaBuilder[10].bidy;
            aaBuilder[10].label_anti;
            aaBuilder[10].antibrute_enable;
            aaBuilder[10].antibrute_aa;
            aaBuilder[10].antibrute_yaw;
            aaBuilder[10].antibrute_mod;
            aaBuilder[10].antibrute_mod_range;
            aaBuilder[10].antibrute_body;
            aaBuilder[10].antibrute_body_range
        },
        aa_other = {
            menu.aaTab.anti_knife;
            menu.aaTab.avoid_dist;
            menu.aaTab.freestandHotkey;
            menu.aaTab.legitAAHotkey;
            menu.aaTab.m_left;
            menu.aaTab.m_right;
            menu.aaTab.static_m;
            menu.aaTab.edge_on_fd;
            menu.aaTab.safe_head;
            menu.aaTab.safe_flick;
            menu.aaTab.safe_flick_mode;
            menu.aaTab.safe_flick_pitch;
            menu.aaTab.safe_flick_pitch_value
        },
        visuals = {
            menu.visualsTab.cros_ind;
            menu.visualsTab.min_ind;
            menu.visualsTab.min_ind_mode;
            menu.visualsTab.fpsboost;
            menu.visualsTab.bul_trace;
            menu.visualsTab.bul_color;
            menu.visualsTab.bul_dur;
            menu.visualsTab.tracers_width;
            menu.visualsTab.rgb_tracers;
            menu.visualsTab.rgb_speed;
            menu.visualsTab.viewmodel_en;
            menu.visualsTab.viewmodel_x;
            menu.visualsTab.viewmodel_y;
            menu.visualsTab.viewmodel_z;
            menu.visualsTab.custom_scope;
            menu.visualsTab.custom_color;
            menu.visualsTab.custom_initial_pos;
            menu.visualsTab.custom_offset;
            menu.visualsTab.grenade_radius;
            menu.visualsTab.molotov_radius_reference;
            menu.visualsTab.smoke_radius_reference;
            menu.visualsTab.smoke_radius;
            menu.visualsTab.molotov_radius;

            menu.visualsTab.zeus_warning;
            menu.visualsTab.ammo_low;
            menu.visualsTab.snowball;
            menu.visualsTab.snowflake_speed;
            menu.visualsTab.snowflake_count;
            menu.visualsTab.animates_left_down;
            menu.visualsTab.third_;
            menu.visualsTab.third_dis;
            menu.visualsTab.trace_color;
            menu.visualsTab.trace_target;
            menu.visualsTab.min_text;
            menu.visualsTab.asp;
            menu.visualsTab.asp_v;
            menu.visualsTab.gs_ind;
            menu.visualsTab.arows_txt;
            menu.visualsTab.arows_txt_color;
            menu.visualsTab.arows_txt_offset;
            menu.visualsTab.on_screen_logs;
            menu.visualsTab.slow_down;
            menu.visualsTab.on_screen_v;
            menu.visualsTab.widgets_slow;
            menu.visualsTab.widgets_slow_length;
            menu.visualsTab.widgets_slow_width;
        },
        misc = {
            menu.miscTab.fast_ladder;
            menu.miscTab.jump_scout;
            menu.miscTab.charge_dt;
            menu.miscTab.filtercons;
            menu.miscTab.clanTag;
            menu.miscTab.clantag_mode;
            menu.miscTab.kill_say;
            menu.miscTab.console_logs;
            menu.miscTab.console_logs_custom_vibor;
            menu.miscTab.console_logs_resolver;
            menu.miscTab.bomb_fix;
            menu.miscTab.hidechatbox;
            menu.miscTab.enablechina;
            menu.miscTab.colorchinareal;
            menu.miscTab.gradientchina;
            menu.miscTab.speedchina;
            menu.miscTab.vgui_color_checkbox;
            menu.miscTab.vgui_color;
            menu.miscTab.auto_smoke;
            menu.miscTab.auto_smoke_cam;
            menu.miscTab.auto_smoke_bind;
        }
    }


    --#region configs

    ui.set_callback(menu.configTab.export, function ()
        local Code = {{}, {}, {}, {}}; 

        for _, main in pairs(velours.config_data.cfg_data.anti_aim) do
            if ui.get(main) ~= nil then
                table.insert(Code[1], tostring(ui.get(main)))
            end
        end

        for _, main in pairs(velours.config_data.cfg_data.aa_other) do
            if ui.get(main) ~= nil then
                table.insert(Code[2], tostring(ui.get(main)))
            end
        end

        for _, main in pairs(velours.config_data.cfg_data.visuals) do
            if ui.get(main) ~= nil then
                table.insert(Code[3], tostring(ui.get(main)))
            end
        end

        for _, main in pairs(velours.config_data.cfg_data.misc) do
            if ui.get(main) ~= nil then
                table.insert(Code[4], tostring(ui.get(main)))
            end
        end

        clipboard.set(base64.encode(json.stringify(Code)))
    end);

    ui.set_callback(menu.configTab.import, function()
        local protected = function()
            local clipboard_data = clipboard.get()
            local decoded_data = base64.decode(clipboard_data)
    
            if not decoded_data then
                error("Error: Data after decode = nil.")
                return
            end
    
            local status, json_data = pcall(json.parse, decoded_data)
    
            if not status then
                error("[DEBUG] Error by parsin g JSON: " .. json_data)
                return
            end
    
            -- Сопоставление индексов с названиями секций
            local sections = {
                [1] = "anti_aim",
                [2] = "aa_other",
                [3] = "visuals",
                [4] = "misc"
            }
    
            -- Обработка каждой секции конфига
            for index, values in pairs(json_data) do
                local section_name = sections[index]
                if section_name and velours.config_data.cfg_data[section_name] then
                    local section_data = velours.config_data.cfg_data[section_name]
                    local i = 1
                    for _, value in pairs(values) do
                        local config_item = next(section_data, nil)
                        for _ = 2, i do
                            config_item = next(section_data, config_item)
                        end
    
                        if config_item and section_data[config_item] then
                            pcall(function()
                                if value == "true" then
                                    ui.set(section_data[config_item], true)
                                elseif value == "false" then
                                    ui.set(section_data[config_item], false)
                                else
                                    ui.set(section_data[config_item], value)
                                end
                            end)
                        end
                        i = i + 1
                    end
                end
            end
        end
    
        local status, message = pcall(protected)
        if not status then
            notifications.new("Error import config.", 255, 0, 0)
            return
        end
        notifications.new("Config imported successfully", 0, 255, 0)
    end)



    function getConfig(name)
        local database = database.read(lua.database.configs) or {}

        
        for i, v in pairs(database) do
            if v.name == name then
                return {
                    config = v.config,
                    index = i
                }
            end
        end

        
        for i, v in pairs(presets) do
            if v.name == name then
                return {
                    config = v.config,
                    index = i
                }
            end
        end

        return nil
    end
    function saveConfig(menu, name)
        local db = database.read(lua.database.configs) or {}
        local config = {}

        
        if name:match("[^%w%s%p]") ~= nil then
            return
        end

        
        for category, data in pairs(velours.config_data.cfg_data) do
            config[category] = {}
            for key, element in pairs(data) do
                config[category][key] = ui.get(element)
            end
        end

        
        local cfg = getConfig(name)

        if not cfg then
            
            table.insert(db, { name = name, config = config })
        else
            db[cfg.index].config = config
        end

        database.write(lua.database.configs, db)
    end

    function deleteConfig(name)
        local db = database.read(lua.database.configs) or {}

        for i, v in pairs(db) do
            if v.name == name then
                table.remove(db, i)
                break
            end
        end

        for i, v in pairs(presets) do
            if v.name == name then
                return false
            end
        end

        database.write(lua.database.configs, db)
        return true
    end

    function getConfigList()
        local database = database.read(lua.database.configs) or {}
        local config = {}

        for i, v in pairs(presets) do
            table.insert(config, v.name)
        end

        for i, v in pairs(database) do
            table.insert(config, v.name)
        end

        return config
    end

    function typeFromString(input)
        if type(input) ~= "string" then return input end

        local value = input:lower()

        if value == "true" then
            return true
        elseif value == "false" then
            return false
        elseif tonumber(value) ~= nil then
            return tonumber(value)
        else
            return tostring(input)
        end
    end
    function loadSettings(config)
        for category, data in pairs(config) do
            for key, value in pairs(data) do
                local element = velours.config_data.cfg_data[category][key]
                if element then
                    ui.set(element, value)
                else
                    print("[DEBUG] Element not found: " .. category .. "." .. key)
                end
            end
        end
    end
    function importSettings()
        local clipboard_data = clipboard.get()
        if clipboard_data then
            local config = json.parse(clipboard_data)
            loadSettings(config)
        end
    end
    function exportSettings(name)
        local config = {}

        for category, data in pairs(velours.config_data.cfg_data) do
            config[category] = {}
            for key, element in pairs(data) do
                config[category][key] = ui.get(element)
            end
        end

        clipboard.set(json.stringify(config))
    end
    function loadConfig(name)
        local config = getConfig(name)
        if config then
            loadSettings(config.config)
        else
            error("Config not found: " .. name)
        end
    end

    --#endregion configs


    vec_add = function(a, b) return { a[1] + b[1], a[2] + b[2], a[3] + b[3] } end

    function extrapolate_position(ent, origin, ticks)
        local tickinterval = globals.tickinterval()
        local velocity = { entity.get_prop(ent, 'm_vecVelocity') }
        local gravity = cvar.sv_gravity:get_float() * tickinterval

        local predicted_pos = origin

        for i = 1, ticks do
            predicted_pos = {
                predicted_pos[1] + velocity[1] * tickinterval,
                predicted_pos[2] + velocity[2] * tickinterval,
                predicted_pos[3] + (velocity[3] - gravity) * tickinterval
            }
        end

        return predicted_pos
    end

    function getspeed(player_index)
        return vector(entity.get_prop(player_index, "m_vecVelocity")):length()
    end



    local mx,my = client.screen_size()
    local dbs = {
        defensive_x = database.read("def_indicator_x") or mx / 2, 
        defensive_y = database.read("def_indicator_y") or my / 2 - 100,
        slow_x = database.read("slow_indicator_x") or mx / 2, 
        slow_y = database.read("slow_indicator_y") or my / 2 - 200,
        is_dragging = false,
        defensive_menu = false,
        slow_menu = false,
        size = 0,
        should_drag = false,
        last_item = "Slow",
        not_last_item = "Slow",
    }

    func.in_air = (function(player)
        if player == nil then return end
        local flags = entity.get_prop(player, "m_fFlags")
        if flags == nil then return end
        if bit.band(flags, 1) == 0 then
            return true
        end
        return false
    end)

    function is_vulnerable()
        for _, v in ipairs(entity.get_players(true)) do
            local flags = (entity.get_esp_data(v)).flags

            if bit.band(flags, bit.lshift(1, 11)) ~= 0 then
                return true
            end
        end

        return false
    end

    function get_velocity(player)
        local x,y,z = entity.get_prop(player, "m_vecVelocity")
        if x == nil then return end
        return math.sqrt(x*x + y*y + z*z)
    end


    animate_text = function(time, string, r, g, b, a)
        local t_out, t_out_iter = { }, 1

        local l = string:len( ) - 1

        local r_add = (0 - r) * 0.5
        local g_add = (0 - g) * 0.5
        local b_add = (0 - b) * 0.5
        local a_add = (255 - a) * 0.5

        for i = 1, #string do
            local iter = (i - 1)/(#string - 1) + time
            t_out[t_out_iter] = "\a" .. func.RGBAtoHEX( r + r_add * math.abs(math.cos( iter )), g + g_add * math.abs(math.cos( iter )), b + b_add * math.abs(math.cos( iter )), a + a_add * math.abs(math.cos( iter )) )

            t_out[t_out_iter + 1] = string:sub( i, i )

            t_out_iter = t_out_iter + 2
        end

        return t_out
    end

    glow_module = function(x, y, w, h, width, rounding, accent, accent_inner)
        local thickness = 1
        local Offset = 1
        local r, g, b, a = unpack(accent)
        if accent_inner then
            func.rec(x, y, w, h + 1, rounding, accent_inner)
        end
        for k = 0, width do
            if a * (k/width)^(1) > 5 then
                local accent = {r, g, b, a * (k/width)^(2)}
                func.rec_outline(x + (k - width - Offset)*thickness, y + (k - width - Offset) * thickness, w - (k - width - Offset)*thickness*2, h + 1 - (k - width - Offset)*thickness*2, rounding + thickness * (width - k + Offset), thickness, accent)
            end
        end
    end

    local last_update_time = globals.realtime()
    local static_random_value = -50


    function generate_slow_random(min, max, interval)
        local current_time = globals.realtime()

        if current_time - last_update_time >= interval then
            static_random_value = client.random_int(min * 1, max * 1)
            last_update_time = current_time
        end

        return static_random_value
    end

    local last_update_time2 = globals.realtime()
    local static_random_value2 = 0

    function generate_slow_random2(min, max, interval)
        local current_time = globals.realtime()

        if current_time - last_update_time2 >= interval then
            static_random_value2 = client.random_int(min * 1, max * 1)
            last_update_time2 = current_time
        end

        return static_random_value2
    end

    local last_update_time3 = globals.realtime()
    local last_update_time4 = globals.realtime()
    function value_to_0(value, interval)
        if last_update_time3 - last_update_time4 >= interval then
            value = 0
            last_update_time4 = last_update_time3
        end

        if value == 0 and last_update_time3 - last_update_time4 >= interval then
            last_update_time4 = last_update_time3
        elseif value ~= 0 and last_update_time3 - last_update_time4 >= interval then
            value = value
        end
    end


    local aa = {
        ignore = false,
        manualAA= 0,
        input = 0,
    }


    vars.last_press = 0
    vars.aa_dir = 0
    vars.pitch = 0

    event_callback("player_connect_full", function() 
        aa.ignore = false
        aa.manualAA= 0
        aa.input = 0
        vars.last_press = 0
        vars.aa_dir = 0
    end) 


    local delsw, a_bodydel, delaa, d_sw, bodydel, last_switch_time = false, false, false, false, false,  globals.curtime()



    event_callback("run_command", function(cmd)
        vars.breaker.cmd = cmd.command_number
        if cmd.chokedcommands == 0 then
            vars.breaker.origin = vector(entity.get_origin(entity.get_local_player()))
            if vars.breaker.last_origin ~= nil then
                vars.breaker.tp_dist = (vars.breaker.origin - vars.breaker.last_origin):length2dsqr()
                gram_update(vars.breaker.tp_data, vars.breaker.tp_dist, true)
            end
            vars.breaker.last_origin = vars.breaker.origin
        end
    end)

    event_callback("predict_command", function(cmd)
        if cmd.command_number == vars.breaker.cmd then
            local tickbase = entity.get_prop(entity.get_local_player(), "m_nTickBase")
            vars.breaker.defensive = math.abs(tickbase - vars.breaker.defensive_check)
            vars.breaker.defensive_check = math.max(tickbase, vars.breaker.defensive_check)
            vars.breaker.cmd = 0
        end
    end)


    local local_player, callback_reg, dt_charged = entity.get_local_player(), false, false

    function check_charge()
        local m_nTickBase = entity.get_prop(entity.get_local_player(), 'm_nTickBase')
        local client_latency = client.latency()
        local shift = math.floor(m_nTickBase - globals.tickcount() - 3 - toticks(client_latency) * .5 + .5 * (client_latency * 10))

        local wanted = -14 + (ui.get(ref.doubletap.fakelag_limit) - 1) + 3 

        dt_charged = shift <= wanted
    end

    local ae, should_shoot, delay_w, del_jit = true, false, false, false
    local is_math, start_timer, slow_turtle_pos, clicked, can_press_under, elect_svg = false, 0, 0, false, false, renderer.load_svg("<svg id=\"svg\" version=\"1.1\" width=\"608\" height=\"689\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" ><g id=\"svgg\"><path id=\"path0\" d=\"M185.803 18.945 C 184.779 19.092,182.028 23.306,174.851 35.722 C 169.580 44.841,157.064 66.513,147.038 83.882 C 109.237 149.365,100.864 163.863,93.085 177.303 C 88.686 184.901,78.772 202.072,71.053 215.461 C 63.333 228.849,53.959 245.069,50.219 251.505 C 46.480 257.941,43.421 263.491,43.421 263.837 C 43.421 264.234,69.566 264.530,114.025 264.635 L 184.628 264.803 181.217 278.618 C 179.342 286.217,174.952 304.128,171.463 318.421 C 167.974 332.714,160.115 364.836,153.999 389.803 C 147.882 414.770,142.934 435.254,143.002 435.324 C 143.127 435.452,148.286 428.934,199.343 364.145 C 215.026 344.243,230.900 324.112,234.619 319.408 C 238.337 314.704,254.449 294.276,270.423 274.013 C 286.397 253.750,303.090 232.582,307.519 226.974 C 340.870 184.745,355.263 166.399,355.263 166.117 C 355.263 165.937,323.554 165.789,284.798 165.789 C 223.368 165.789,214.380 165.667,214.701 164.831 C 215.039 163.949,222.249 151.366,243.554 114.474 C 280.604 50.317,298.192 19.768,298.267 19.444 C 298.355 19.064,188.388 18.576,185.803 18.945 \" stroke=\"none\" fill=\"#fff200\" fill-rule=\"evenodd\"></path></g></svg>", 25, 25)

    -- set_spin = function()
    --     ui.set(refs.pitch[1], "Off")
    --     ui.set(refs.yawBase, "At targets")
    --     ui.set(refs.yaw[1], "Spin")
    --     ui.set(refs.yaw[2], 50)
    --     ui.set(refs.yawJitter[1], "Off")
    --     ui.set(refs.yawJitter[2], 0)
    --     ui.set(refs.bodyYaw[1], "Static")
    --     ui.set(refs.bodyYaw[2], 0)
    --     ui.set(refs.fsBodyYaw, false)
    --     ui.set(refs.edgeYaw, false)
    --     ui.set(refs.roll, 0)
    --     aa.ignore = true
    -- end
    -- local def_e, def_su, chat_spammer = true, false, {}

    -- hours, minutes = client.system_time()
    -- text, get_name, nickname, username, fps = string.format("%02d:%02d", hours, minutes), panorama.loadstring([[ return MyPersonaAPI.GetName() ]]), entity.get_player_name(), globals.frametime()
    last_fps, update_interval, frame_count, lastmiss, bruteforce_reset, shot_time = 0, 60, 0, 0, true, 0



    local last_sim_time = 0
    local defensive_until = 0

    is_defensive_active = function()
        local tickcount = globals.tickcount()
        local sim_time = toticks(entity.get_prop(entity.get_local_player(), "m_flSimulationTime"))
        local sim_diff = sim_time - last_sim_time

        if sim_diff < 0 then
            defensive_until = tickcount + math.abs(sim_diff) - toticks(client.latency())
        end

        last_sim_time = sim_time

        return defensive_until > tickcount
    end

    def_switch = false

    -- function dt_es()
    --     return antiaim_funcs.get_double_tap()
    -- end
    main_aa = function(cmd)
        vars.localPlayer = entity.get_local_player()

        if not vars.localPlayer or not entity.is_alive(vars.localPlayer) then return end
        local flags = entity.get_prop(vars.localPlayer, "m_fFlags")
        local onground = bit.band(flags, 1) ~= 0 and cmd.in_jump == 0
        local valve = entity.get_prop(entity.get_game_rules(), "m_bIsValveDS")
        local origin = vector(entity.get_prop(vars.localPlayer, "m_vecOrigin"))
        local camera = vector(client.camera_angles())
        local eye = vector(client.eye_position())
        local velocity = vector(entity.get_prop(vars.localPlayer, "m_vecVelocity"))
        local weapon = entity.get_player_weapon()
        local pStill = math.sqrt(velocity.x ^ 2 + velocity.y ^ 2) < 5
        local bodyYaw = entity.get_prop(vars.localPlayer, "m_flPoseParameter", 11) * 120 - 60
        local tp_amount = get_average(vars.breaker.tp_data)/get_velocity(entity.get_local_player())*100 
        local is_defensive = (vars.breaker.defensive > 1) and not (tp_amount >= 25 and vars.breaker.defensive >= 13)

        local isSlow = ui.get(refs.slow[1]) and ui.get(refs.slow[2])
        local isOs = ui.get(refs.os[1]) and ui.get(refs.os[2])
        local isFd = ui.get(refs.fakeDuck)
        local isDt = ui.get(refs.dt[1]) and ui.get(refs.dt[2])
        local isFl = ui.get(ref_ui("AA", "Fake lag", "Enabled"))
        local isFs1 = ui.get(menu.aaTab.freestandHotkey)
        local legitAA = false
        local man_aa = ui.get(menu.aaTab.m_left) or ui.get(menu.aaTab.m_right)

        vars.pState = 1
        if pStill then vars.pState = 2 end
        if not pStill then vars.pState = 3 end
        if isSlow then vars.pState = 4 end
        if entity.get_prop(vars.localPlayer, "m_flDuckAmount") > 0.1 then vars.pState = 5 end
        if not pStill and entity.get_prop(vars.localPlayer, "m_flDuckAmount") > 0.1 then vars.pState = 8 end
        if not onground then vars.pState = 6 end
        if not onground and entity.get_prop(vars.localPlayer, "m_flDuckAmount") > 0.1 then vars.pState = 7 end
        if isFs1 then vars.pState = 10 end


        if ui.get(aaBuilder[9].enableState) and not func.table_contains(ui.get(aaBuilder[9].stateDisablers), vars.intToS[vars.pState]) and isDt == false and isOs == false and isFl == true then
            vars.pState = 9
        end

        if ui.get(aaBuilder[vars.pState].enableState) == false and vars.pState ~= 1 then
            vars.pState = 1
        end

        if (tickcount() % ui.get(aaBuilder[vars.pState].def_yaw_switch_delay)) == 1 then
            dele = not dele
        end

        if (tickcount() % math.random(1, 12) == 1) then
            delaa = not delaa
        end

        if tickcount() % 2 == 1 then
            del_jit = not del_jit
        end

        if (globals.tickcount() % ui.get(aaBuilder[vars.pState].def_jit_delay)) == 1 then
            d_sw = not d_sw
        end

        local da_value = ui.get(aaBuilder[vars.pState].delayed_body)
        local ra_value =ui.get(aaBuilder[vars.pState].random_delay)

        if (globals.tickcount() % (math.random(da_value, da_value + (ra_value-1)) * 2)) == 1 then
            bodydel = not bodydel
        end

        if (globals.tickcount() % 6) == 1 then
            a_bodydel = not a_bodydel
        end

        if (globals.tickcount() % 14) == 1 then
            def_switch = not def_switch
        end


        ui.set(refs.yawBase, "At targets")

        
        if ui.get(menu.aaTab.freestandHotkey) then
            ui.set(refs.freeStand[2], "Always on")
            ui.set(refs.freeStand[1], true)
        else
            ui.set(refs.freeStand[1], false)
            ui.set(refs.freeStand[2], "On hotkey")
        end
        local nextAttack = entity.get_prop(vars.localPlayer, "m_flNextAttack")
        local nextPrimaryAttack = entity.get_prop(entity.get_player_weapon(vars.localPlayer), "m_flNextPrimaryAttack")
        local dtActive = false
        if nextPrimaryAttack ~= nil then
            dtActive = not (math.max(nextPrimaryAttack, nextAttack) > globals.curtime())
        end

        local side = bodyYaw > 0 and 1 or -1

        safe_head = function()
            ui.set(refs.pitch[1], "Down")
            ui.set(refs.yawBase, "At targets")
            ui.set(refs.yaw[1], "180")
            ui.set(refs.yaw[2], 0)
            ui.set(refs.yawJitter[1], "Off")
            ui.set(refs.yawJitter[2], 0)
            ui.set(refs.bodyYaw[1], "Static")
            ui.set(refs.bodyYaw[2], 0)
            ui.set(refs.fsBodyYaw, false)
            --ui.set(refs.edgeYaw, false)
            ui.set(refs.roll, 0)
            aa.ignore = true
        end

        get_distance = function() 
            local result = math.huge;
            local heightDifference = 0;
            local localplayer = entity.get_local_player();
            local entities = entity.get_players(true);
        
            for i = 1, #entities do
            local ent = entities[i];
            local ent_origin = { entity.get_origin(ent) }
            local lp_origin = { entity.get_origin(localplayer) }
            if ent ~= localplayer and entity.is_alive(ent) then
                local distance = (vector(ent_origin[1], ent_origin[2], ent_origin[3]) - vector(lp_origin[1], lp_origin[2], lp_origin[3])):length2d();
                if distance < result then 
                    result = distance; 
                    heightDifference = ent_origin[3] - lp_origin[3];
                end
            end
            end
        
            return math.floor(result/10), math.floor(heightDifference);
        end

        local distance_to_enemy = {get_distance()}

        if ae and (func.includes(ui.get(menu.aaTab.safe_head), "Air Zeus hold") and vars.pState == 7 and entity.get_classname(entity.get_player_weapon(vars.localPlayer)) == "CWeaponTaser") or (func.includes(ui.get(menu.aaTab.safe_head), "Air Knife hold") and vars.pState == 7 and entity.get_classname(entity.get_player_weapon(vars.localPlayer)) == "CKnife") then
            if not ui.get(menu.aaTab.safe_flick) then
                safe_head()
            elseif ui.get(menu.aaTab.safe_flick) == true then
                cmd.force_defensive = true
                if not is_defensive then
                    ui.set(refs.pitch[1], "Down")
                    ui.set(refs.yawBase, "At targets")
                    ui.set(refs.yaw[1], "180")
                    ui.set(refs.yaw[2], 0)
                    ui.set(refs.yawJitter[1], "Off")
                    ui.set(refs.yawJitter[2], 0)
                    ui.set(refs.bodyYaw[1], "Static")
                    ui.set(refs.bodyYaw[2], 0)
                    ui.set(refs.fsBodyYaw, false)
                    --ui.set(refs.edgeYaw, false)
                    ui.set(refs.roll, 0)
                    aa.ignore = true
                elseif is_defensive then
                    if ui.get(menu.aaTab.safe_flick_mode) == "Flick" then
                        ui.set(refs.pitch[1], "Down")
                        ui.set(refs.yawBase, "At targets")
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], 90)
                        ui.set(refs.yawJitter[1], "Off")
                        ui.set(refs.yawJitter[2], 1)
                        ui.set(refs.bodyYaw[1], "Static")
                        ui.set(refs.bodyYaw[2], 0)
                        ui.set(refs.fsBodyYaw, false)
                        --ui.set(refs.edgeYaw, false)
                        ui.set(refs.roll, 0)
                        aa.ignore = true
                    elseif ui.get(menu.aaTab.safe_flick_mode) == "Default" then
                        ui.set(refs.pitch[1], "Down")
                        ui.set(refs.yawBase, "At targets")
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.roll, 0)
                        aa.ignore = true
                    elseif ui.get(menu.aaTab.safe_flick_mode) == "E spam" then
                        if ui.get(menu.aaTab.safe_flick_pitch) == "Fluculate" then
                            local speed = 8
                            local range = 80
                            ui.set(refs.pitch[1], "Custom")
                            ui.set(refs.pitch[2], (-math.sin(globals.curtime() * speed) * range))
                        elseif ui.get(menu.aaTab.safe_flick_pitch) == "Custom" then
                            ui.set(refs.pitch[1], "Custom")
                            ui.set(refs.pitch[2], ui.get(menu.aaTab.safe_flick_pitch_value))
                        end
                        ui.set(refs.yawBase, "At targets")
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], 180)
                        ui.set(refs.yawJitter[1], "Off")
                        ui.set(refs.yawJitter[2], 1)
                        ui.set(refs.bodyYaw[1], "Off")
                        ui.set(refs.bodyYaw[2], 0)
                        ui.set(refs.fsBodyYaw, false)
                        --ui.set(refs.edgeYaw, false)
                        ui.set(refs.roll, 0)
                        aa.ignore = true
                    end
                end
            end
        else
            aa.ignore = false
        end

        if not (ui.get(menu.aaTab.legitAAHotkey) and cmd.in_use == 1) and aa.ignore == false then
            if ui.get(aaBuilder[vars.pState].enableState) then
            if ui.get(aaBuilder[vars.pState].force_defensive) then
                if ui.get(aaBuilder[vars.pState].defensive_mode) == "Default" then 
                    cmd.force_defensive = true
                elseif ui.get(aaBuilder[vars.pState].defensive_mode) == "Switch" then
                    if ui.get(aaBuilder[vars.pState].defensive_delay) ~= 0 then
                        if globals.tickcount() % ui.get(aaBuilder[vars.pState].defensive_delay) == 0 then
                            cmd.force_defensive = true
                        end
                    else
                        cmd.force_defensive = true
                    end
                elseif ui.get(aaBuilder[vars.pState].defensive_mode) == "On peek" and is_peeking() then
                    cmd.allow_send_packet = false
                    cmd.force_defensive = true
                end
            else
                if --[[l_peek() or ]]isOs then
                    cmd.force_defensive = true
                else
                    cmd.force_defensive = false
                end
            end
                if ui.get(aaBuilder[vars.pState].defensiveAntiAim) and ((isDt and is_defensive_active()) or isOs and is_defensive_active()) then
                    if ui.get(aaBuilder[vars.pState].def_pitch) == "3-way" then
                        local first = ui.get(aaBuilder[vars.pState].def_3_1)
                        local second = ui.get(aaBuilder[vars.pState].def_3_2)
                        local third = ui.get(aaBuilder[vars.pState].def_3_3)
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
                    elseif ui.get(aaBuilder[vars.pState].def_pitch) == "Custom" then
                        ui.set(refs.pitch[1], "Custom")
                        ui.set(refs.pitch[2], ui.get(aaBuilder[vars.pState].def_pitchSlider))
                    elseif ui.get(aaBuilder[vars.pState].def_pitch) == "Switch" then
                        ui.set(refs.pitch[1], "Custom")
                        ui.set(refs.pitch[2], d_sw and ui.get(aaBuilder[vars.pState].def_pitch_s1) or ui.get(aaBuilder[vars.pState].def_pitch_s2))
                    elseif ui.get(aaBuilder[vars.pState].def_pitch) == "Dynamic" then
                        local min_value = ui.get(aaBuilder[vars.pState].def_pitch_s1)
                        local max_value = ui.get(aaBuilder[vars.pState].def_pitch_s2)
                        local speed = ui.get(aaBuilder[vars.pState].def_dyn_speed)
                        local delay = 3
                        local last_update = 0
                        
                        local function get_pitch_value()
                            local midpoint = (min_value + max_value) / 2
                            local amplitude = (max_value - min_value) / 2
                            return midpoint + math.sin(globals.curtime() * speed) * amplitude
                        end
                        
                        local function update_pitch()
                            if globals.curtime() - last_update >= delay then
                                ui.set(refs.pitch[1], "Custom")
                                ui.set(refs.pitch[2], get_pitch_value())
                                last_update = globals.curtime()
                            end
                        end
                        
                        update_pitch()
                    elseif ui.get(aaBuilder[vars.pState].def_pitch) == "Random" then
                        local first = ui.get(aaBuilder[vars.pState].def_pitch_s1)
                        local second = ui.get(aaBuilder[vars.pState].def_pitch_s2)
                        local speed = ui.get(aaBuilder[vars.pState].def_slow_gen)
                        ui.set(refs.pitch[1], "Custom")
                        ui.set(refs.pitch[2], generate_slow_random2(first, second, speed / 10))
                    elseif ui.get(aaBuilder[vars.pState].def_pitch) == "S-Way" then
                        local min_value = ui.get(aaBuilder[vars.pState].def_pitch_s1)
                        local max_value = ui.get(aaBuilder[vars.pState].def_pitch_s2)
                        local speed = ui.get(aaBuilder[vars.pState].def_dyn_speed) * 60
                        local delay = 1
                        local last_update = 0
                        
                        local function get_pitch_value()
                            local t = globals.curtime() * speed
                            local range = max_value - min_value
                            local progress = t % range
                            return min_value + progress
                        end
                        
                        local function update_pitch()
                            if globals.curtime() - last_update >= delay then
                                ui.set(refs.pitch[1], "Custom")
                                ui.set(refs.pitch[2], get_pitch_value())
                                last_update = globals.curtime()
                            end
                        end
                        
                        update_pitch()
                    elseif ui.get(aaBuilder[vars.pState].def_pitch) == "Flick" then
                        ui.set(refs.pitch[1], "Custom")
                        if globals.tickcount() % math.random(15, 20) > 1 then
                            ui.set(refs.pitch[2], ui.get(aaBuilder[vars.pState].def_pitch_s1))
                        else
                            ui.set(refs.pitch[2], ui.get(aaBuilder[vars.pState].def_pitch_s2))
                        end
                    end
                    
                    if ui.get(aaBuilder[vars.pState].def_yawMode) == "Switch" then
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], dele and ui.get(aaBuilder[vars.pState].def_yaw_left) or ui.get(aaBuilder[vars.pState].def_yaw_right))
                        ui.set(refs.yawJitter[1], "Random")
                        ui.set(refs.yawJitter[2], ui.get(aaBuilder[vars.pState].def_yaw_random))
                    elseif ui.get(aaBuilder[vars.pState].def_yawMode) == "Custom" then
                        ui.set(refs.yawJitter[1], "Random")
                        ui.set(refs.yawJitter[2], ui.get(aaBuilder[vars.pState].def_yaw_random))
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], ui.get(aaBuilder[vars.pState].def_yawStatic))
                    elseif ui.get(aaBuilder[vars.pState].def_yawMode) == "3-ways" then
                        ui.set(refs.yaw[1], "180")
                        local ways = {
                            ui.get(aaBuilder[vars.pState].def_way_1),
                            ui.get(aaBuilder[vars.pState].def_way_2),
                            ui.get(aaBuilder[vars.pState].def_way_3)
                        }

                        ui.set(refs.yaw[2], ways[(tickcount() % 3) + 1] )
                        ui.set(refs.yawJitter[1], "Off")
                        ui.set(refs.yawJitter[2], 0)
                    elseif ui.get(aaBuilder[vars.pState].def_yawMode) == "Small-Spin" then
                        local angle1 = ui.get(aaBuilder[vars.pState].def_yaw_left)
                        local angle2 = ui.get(aaBuilder[vars.pState].def_yaw_right)
                        local speed = ui.get(aaBuilder[vars.pState].def_yaw_exploit_speed) / 3
                        
                        local mid = (angle1 + angle2) / 2
                        local amplitude = (angle2 - angle1) / 2
                        local yaw_value = mid + math.sin(globals.curtime() * speed) * amplitude
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], yaw_value)
                        ui.set(refs.yawJitter[1], "Off")
                        ui.set(refs.yawJitter[2], 0)
                    elseif ui.get(aaBuilder[vars.pState].def_yawMode) == "Spin" then
                        local speed = ui.get(aaBuilder[vars.pState].def_yaw_spin_speed) / 4
                        local range = ui.get(aaBuilder[vars.pState].def_yaw_spin_range)
                        local spined = math.lerp(-range * 0.5, range * 0.5, math.sin(globals.curtime() * speed % 1))
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], spined)
                        ui.set(refs.yawJitter[1], "Off")
                        ui.set(refs.yawJitter[2], 0)
                    elseif ui.get(aaBuilder[vars.pState].def_yawMode) == "Random" then
                        local first = ui.get(aaBuilder[vars.pState].def_yaw_left)
                        local second = ui.get(aaBuilder[vars.pState].def_yaw_right)
                        local speed = ui.get(aaBuilder[vars.pState].def_slow_gena)
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], generate_slow_random(first, second, speed / 10))
                        ui.set(refs.yawJitter[1], "Off")
                        ui.set(refs.yawJitter[2], 0)
                    end
                    
                    if ui.get(aaBuilder[vars.pState].bidy) then
                        if ui.get(aaBuilder[vars.pState].bodyYaw) == "Static" or ui.get(aaBuilder[vars.pState].bodyYaw) == "Jitter" or ui.get(aaBuilder[vars.pState].bodyYaw) == "Opposite" then
                            ui.set(refs.bodyYaw[1], "Off")
                        end
                    else
                        if ui.get(aaBuilder[vars.pState].bodyYaw) == "Static" then
                            ui.set(refs.bodyYaw[1], "Static")
                            ui.set(refs.bodyYaw[2], (ui.get(aaBuilder[vars.pState].bodyYawStatic)))
                        elseif ui.get(aaBuilder[vars.pState].bodyYaw) == "Jitter" then
                            if ui.get(aaBuilder[vars.pState].delayed_body) == 1 then
                                ui.set(refs.bodyYaw[1], "Jitter")
                                ui.set(refs.bodyYaw[2], 2)
                            elseif ui.get(aaBuilder[vars.pState].delayed_body) ~= 1 then
                                ui.set(refs.bodyYaw[1], "Static")
                                ui.set(refs.bodyYaw[2], bodydel and -1 or 1)
                            end
                        elseif ui.get(aaBuilder[vars.pState].bodyYaw) == "Opposite" then
                            ui.set(refs.bodyYaw[1], "Opposite")
                        end
                    end
            
                else
                    ui.set(refs.pitch[1], "Down")

                    if ui.get(aaBuilder[vars.pState].yaw) == "Left / Right" then
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2],(side == 1 and (ui.get(aaBuilder[vars.pState].yawLeft) - math.random(0, ui.get(aaBuilder[vars.pState].randomization))) or (ui.get(aaBuilder[vars.pState].yawRight) + math.random(0, ui.get(aaBuilder[vars.pState].randomization)))))
                    elseif ui.get(aaBuilder[vars.pState].yaw) == "Offset" then
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], ui.get(aaBuilder[vars.pState].yawStatic))
                    end


                    if ui.get(aaBuilder[vars.pState].yawJitter) == "3-Way" then
                        ui.set(refs.yawJitter[1], "Center")
                        local ways = {
                            ui.get(aaBuilder[vars.pState].wayFirst),
                            ui.get(aaBuilder[vars.pState].waySecond),
                            ui.get(aaBuilder[vars.pState].wayThird)
                        }

                        ui.set(refs.yawJitter[2], ways[(tickcount() % 3) + 1] )
                    elseif ui.get(aaBuilder[vars.pState].yawJitter) == "S-Way" then
                        local speed = ui.get(aaBuilder[vars.pState].sway_speed) / 2
                        local min_value = 0
                        local max_value = ui.get(aaBuilder[vars.pState].yawJitterStatic)


                        local function get_pitch_value()
                            local midpoint = (min_value + max_value) / 2
                            local amplitude = (max_value - min_value) / 2
                            return midpoint + math.sin(globals.curtime() * speed) * amplitude
                        end

                        ui.set(refs.yawJitter[1], "Center")
                        ui.set(refs.yawJitter[2], get_pitch_value())
                    else
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yawJitter[1], ui.get(aaBuilder[vars.pState].yawJitter))
                        ui.set(refs.yawJitter[2], ui.get(aaBuilder[vars.pState].yawJitterStatic) + math.random(0, ui.get(aaBuilder[vars.pState].randomization)))
                    end

                    if ui.get(aaBuilder[vars.pState].bodyYaw) == "Jitter" then
                        if ui.get(aaBuilder[vars.pState].delayed_body) == 1 then
                            ui.set(refs.bodyYaw[1], "Jitter")
                            ui.set(refs.bodyYaw[2], 2)
                        elseif ui.get(aaBuilder[vars.pState].delayed_body) ~= 1 then
                            ui.set(refs.bodyYaw[1], "Static")
                            ui.set(refs.bodyYaw[2], bodydel and -1 or 1)
                        end
                    elseif ui.get(aaBuilder[vars.pState].bodyYaw) == "Static" then
                        local value = ui.get(aaBuilder[vars.pState].bodyYawStatic)
                        ui.set(refs.bodyYaw[1], "Static")
                        if value == -2 then
                            ui.set(refs.bodyYaw[2], -180)
                        elseif value == -1 then
                            ui.set(refs.bodyYaw[2], -1)
                        elseif value == 0 then
                            ui.set(refs.bodyYaw[2], 0)
                        elseif value == 1 then
                            ui.set(refs.bodyYaw[2], 1)
                        elseif value == 2 then
                            ui.set(refs.bodyYaw[2], 180)
                        end
                    else
                        ui.set(refs.bodyYaw[1], ui.get(aaBuilder[vars.pState].bodyYaw))
                        ui.set(refs.bodyYaw[2], ui.get(aaBuilder[vars.pState].bodyYawStatic))
                    end
            
                    if ui.get(aaBuilder[vars.pState].fl_enable) and not isFD then
                        if ui.get(aaBuilder[vars.pState].fl_mode) == "Maximum" then
                            ui.set(refs.flLimit, 15)
                            ui.set(refs.flamount, "Maximum")
                            ui.set(refs.flVariance, 0)
                            ui.set(refs.flenabled, true)
                        elseif ui.get(aaBuilder[vars.pState].fl_mode) == "Random" then
                            ui.set(refs.flLimit, math.random(1, 14))
                            ui.set(refs.flamount, "Maximum")
                            ui.set(refs.flVariance, 50)
                            ui.set(refs.flenabled, true)
                        elseif ui.get(aaBuilder[vars.pState].fl_mode) == "Fluculate [custom]" then
                            local speed = 4
                            local range = 20
                            ui.set(refs.flamount, "Maximum")
                            ui.set(refs.flLimit, (math.sin(globals.curtime() * speed) * 6.5) + 7.5)
                            ui.set(refs.flVariance, 0)
                            ui.set(refs.flenabled, true)
                        end
                    elseif ui.get(aaBuilder[vars.pState].fl_enable) and isFD then
                        ui.set(refs.flLimit, 15)
                        ui.set(refs.flamount, "Maximum")
                        ui.set(refs.flVariance, 0)
                        ui.set(refs.flenabled, true)
                    end

                    ui.set(refs.fsBodyYaw, false)
                end
            elseif not ui.get(aaBuilder[vars.pState].enableState) then
                ui.set(refs.pitch[1], "Off")
                ui.set(refs.yawBase, "At targets")
                ui.set(refs.yaw[1], "180")
                ui.set(refs.yaw[2], 0)
                ui.set(refs.yawJitter[1], "Off")
                ui.set(refs.yawJitter[2], 0)
                ui.set(refs.bodyYaw[1], "Off")
                ui.set(refs.bodyYaw[2], 0)
                ui.set(refs.fsBodyYaw, false)
                --ui.set(refs.edgeYaw, false)
                ui.set(refs.roll, 0)
            end
        elseif (ui.get(menu.aaTab.legitAAHotkey) and cmd.in_use == 1) and aa.ignore == false then
            if entity.get_classname(entity.get_player_weapon(vars.localPlayer)) == "CC4" then 
                return 
            end
            
            local should_disable = false
            local planted_bomb = entity.get_all("CPlantedC4")[1]
        
            if planted_bomb ~= nil then
                bomb_distance = vector(entity.get_origin(vars.localPlayer)):dist(vector(entity.get_origin(planted_bomb)))
                
                if bomb_distance <= 64 and entity.get_prop(vars.localPlayer, "m_iTeamNum") == 3 then
                    should_disable = true
                end
            end
        
            local pitch, yaw = client.camera_angles()
            local direct_vec = vector(func.vec_angles(pitch, yaw))
        
            local eye_pos = vector(client.eye_position())
            local fraction, ent = client.trace_line(vars.localPlayer, eye_pos.x, eye_pos.y, eye_pos.z, eye_pos.x + (direct_vec.x * 8192), eye_pos.y + (direct_vec.y * 8192), eye_pos.z + (direct_vec.z * 8192))
        
            if ent ~= nil and ent ~= -1 then
                if entity.get_classname(ent) == "CPropDoorRotating" then
                    should_disable = true
                elseif entity.get_classname(ent) == "CHostage" then
                    should_disable = true
                end
            end
            
            if should_disable ~= true then
                ui.set(refs.pitch[1], "Off")
                ui.set(refs.yaw[1], "180")
                ui.set(refs.yaw[2], 180)
                ui.set(refs.yawJitter[1], "Center")
                ui.set(refs.yawJitter[2], 0)
                if ui.get(aaBuilder[vars.pState].bodyYaw) == "Static" then
                    ui.set(refs.bodyYaw[1], "Static")
                    ui.set(refs.bodyYaw[2], (ui.get(aaBuilder[vars.pState].bodyYawStatic)))
                elseif ui.get(aaBuilder[vars.pState].bodyYaw) == "Jitter" then
                    ui.set(refs.bodyYaw[1], "Static")
                    ui.set(refs.bodyYaw[2], bodydel and -1 or 1)
                elseif ui.get(aaBuilder[vars.pState].bodyYaw) == "Opposite" then
                    ui.set(refs.bodyYaw[1], "Opposite")
                end
                ui.set(refs.fsBodyYaw, true)
                ui.set(refs.edgeYaw, false)
                ui.set(refs.roll, 0)
                ui.set(refs.yawBase, "Local view")
                ui.set(refs.freeStand[1], false)
                ui.set(refs.freeStand[2], "On hotkey")
                cmd.in_use = 0
                cmd.roll = 0
            end
        end

        ui.set(menu.aaTab.m_left, "On hotkey")
            ui.set(menu.aaTab.m_right, "On hotkey")
            ui.set(menu.aaTab.m_forward, "On hotkey")
            if vars.last_press + 0.22 < globals.curtime() then
                if vars.aa_dir == 0 then
                    if ui.get(menu.aaTab.m_left) then
                        vars.aa_dir = 1
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_right) then
                        vars.aa_dir = 2
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_forward) then
                        vars.aa_dir = 3
                        vars.last_press = globals.curtime()
                    end
                elseif vars.aa_dir == 1 then
                    if ui.get(menu.aaTab.m_right) then
                        vars.aa_dir = 2
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_forward) then
                        vars.aa_dir = 3
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_left) then
                        vars.aa_dir = 0
                        vars.last_press = globals.curtime()
                    end
                elseif vars.aa_dir == 2 then
                    if ui.get(menu.aaTab.m_left) then
                        vars.aa_dir = 1
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_forward) then
                        vars.aa_dir = 3
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_right) then
                        vars.aa_dir = 0
                        vars.last_press = globals.curtime()
                    end
                elseif vars.aa_dir == 3 then
                    if ui.get(menu.aaTab.m_forward) then
                        vars.aa_dir = 0
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_left) then
                        vars.aa_dir = 1
                        vars.last_press = globals.curtime()
                    elseif ui.get(menu.aaTab.m_right) then
                        vars.aa_dir = 2
                        vars.last_press = globals.curtime()
                    end
                end
            end
            if vars.aa_dir == 1 or vars.aa_dir == 2 or vars.aa_dir == 3 then
                if vars.aa_dir == 1 then
                    cmd.force_defensive = false
                    ui.set(refs.yawBase, "Local view")
                    ui.set(refs.yaw[1], "180")
                    ui.set(refs.yaw[2], -90)
                    if ui.get(menu.aaTab.static_m) then
                        ui.set(refs.yawJitter[1], "Center")
                        ui.set(refs.yawJitter[2], 0)
                        ui.set(refs.bodyYaw[1], "Off")
                    end
                    ui.set(refs.pitch[1], "Down")
                    aa.ignore = true
                elseif vars.aa_dir == 2 then
                    cmd.force_defensive = false
                    ui.set(refs.yawBase, "local view")
                    ui.set(refs.yaw[1], "180")
                    ui.set(refs.yaw[2], 90)
                    if ui.get(menu.aaTab.static_m) then
                        ui.set(refs.yawJitter[1], "Center")
                        ui.set(refs.yawJitter[2], 0)
                        ui.set(refs.bodyYaw[1], "Off")
                    end
                    ui.set(refs.pitch[1], "Down")
                    aa.ignore = true
                elseif vars.aa_dir == 3 then
                    cmd.force_defensive = false
                    ui.set(refs.yawBase, "local view")
                    ui.set(refs.yaw[1], "180")
                    ui.set(refs.yaw[2], 180)
                    if ui.get(menu.aaTab.static_m) then
                        ui.set(refs.yawJitter[1], "Center")
                        ui.set(refs.yawJitter[2], 0)
                        ui.set(refs.bodyYaw[1], "Off")
                    end
                    ui.set(refs.pitch[1], "Down")
                    aa.ignore = true
                end
            end

        if ui.get(menu.miscTab.bomb_fix) then
            if cmd.in_use == 0 then
                return
            end
            local me = entity.get_local_player()
            if me == nil then
                return
            end
            local m_bInBombZone = entity.get_prop(me, "m_bInBombZone")
            if m_bInBombZone == 1 then
                cmd.in_use = 0
            end
        end
        

        local self = entity.get_local_player()

        local players = entity.get_players(true)
        local eye_x, eye_y, eye_z = client.eye_position()
        returnthat = false 
        if ui.get(menu.aaTab.anti_knife) ~= false then
            if players ~= nil then
                for i, enemy in pairs(players) do
                    local head_x, head_y, head_z = entity.hitbox_position(players[i], 5)
                    local wx, wy = renderer.world_to_screen(head_x, head_y, head_z)
                    local fractions, entindex_hit = client.trace_line(self, eye_x, eye_y, eye_z, head_x, head_y, head_z)
        
                    if ui.get(menu.aaTab.avoid_dist) >= vector(entity.get_prop(enemy, 'm_vecOrigin')):dist(vector(entity.get_prop(self, 'm_vecOrigin'))) and entity.is_alive(enemy) and entity.get_player_weapon(enemy) ~= nil and entity.get_classname(entity.get_player_weapon(enemy)) == 'CKnife' and (entindex_hit == players[i] or fractions == 1) and not entity.is_dormant(players[i]) then
                        ui.set(refs.pitch[1], "Down")
                        ui.set(refs.yaw[1], "180")
                        ui.set(refs.yaw[2], 180)
                        ui.set(refs.yawBase, "At targets")
                        ui.set(refs.bodyYaw[1], "Static")
                        ui.set(refs.bodyYaw[2], 1)
                        ui.set(refs.yawJitter[1], "Off")

                        aa.ignore = true
                        ae = false
                        returnthat = true
                    else 
                        ae = true
                        aa.ignore = false
                    end
                end
            end
        end

        if ui.get(menu.aaTab.edge_on_fd) and isFd then
            ui.set(refs.edgeYaw, true)
        else
            ui.set(refs.edgeYaw, false)
        end

    end

    fastladder = function(cmd)
        if not ui.get(menu.miscTab.fast_ladder) then return end
        local me = entity.get_local_player()
        if not me then return end

        local move_type = entity.get_prop(me, 'm_MoveType')
        local weapon = entity.get_player_weapon(me)
        local throw = entity.get_prop(weapon, 'm_fThrowTime')

        if move_type ~= 9 then
            return
        end

        if weapon == nil then
            return
        end

        if throw ~= nil and throw ~= 0 then
            return
        end

        if cmd.forwardmove > 0 then
            if cmd.pitch < 45 then
                cmd.pitch = 89
                cmd.in_moveright = 1
                cmd.in_moveleft = 0
                cmd.in_forward = 0
                cmd.in_back = 1

                if cmd.sidemove == 0 then
                    cmd.yaw = cmd.yaw + 90
                end

                if cmd.sidemove < 0 then
                    cmd.yaw = cmd.yaw + 150
                end

                if cmd.sidemove > 0 then
                    cmd.yaw = cmd.yaw + 30
                end
            end
        elseif cmd.forwardmove < 0 then
            cmd.pitch = 89
            cmd.in_moveleft = 1
            cmd.in_moveright = 0
            cmd.in_forward = 1
            cmd.in_back = 0

            if cmd.sidemove == 0 then
                cmd.yaw = cmd.yaw + 90
            end

            if cmd.sidemove > 0 then
                cmd.yaw = cmd.yaw + 150
            end

            if cmd.sidemove < 0 then
                cmd.yaw = cmd.yaw + 30
            end
        end
    end
    -- anti-brute анти

    function GetClosestPoint(A, B, P)
        a_to_p = { P[1] - A[1], P[2] - A[2] }
        a_to_b = { B[1] - A[1], B[2] - A[2] }

        atb2 = a_to_b[1]^2 + a_to_b[2]^2

        atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
        t = atp_dot_atb / atb2
        
        return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
    end



    --брут
    event_callback("bullet_impact", function(cmd)
        if ui.get(aaBuilder[vars.pState].antibrute_enable) == false then return end
        
        --if not entity.is_alive(entity.get_local_player()) then return end
        local ent = client.userid_to_entindex(cmd.userid)
        if ent ~= client.current_threat() then return end
        if entity.is_dormant(ent) or not entity.is_enemy(ent) then return end

        local ent_origin = { entity.get_prop(ent, "m_vecOrigin") }
        ent_origin[3] = ent_origin[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
        local local_head = { entity.hitbox_position(entity.get_local_player(), 0) }
        local closest = GetClosestPoint(ent_origin, { cmd.x, cmd.y, cmd.z }, local_head)
        local delta = { local_head[1]-closest[1], local_head[2]-closest[2] }
        local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)

        if bruteforce then return end
        if math.abs(delta_2d) <= 60 and globals.curtime() - lastmiss > 0.015 then
            lastmiss = globals.curtime()
            bruteforce = true
            shot_time = globals.realtime()
            notifications.new("Anti Bruteforce Switched due to shot", 255, 255, 255)
        end
    end)

    function Returner()
        brut3 = true
        return brut3
    end

    client.set_event_callback("setup_command", function(cmd)
        if bruteforce and ui.get(aaBuilder[vars.pState].antibrute_enable) then
            client.set_event_callback("paint_ui", Returner)
            unset_event_callback("setup_command", main_aa)
            bruteforce = false
            bruteforce_reset = false
            set_brute = true
            aa.ignore = true
        else
            if shot_time + 3 < globals.realtime() or not ui.get(aaBuilder[vars.pState].antibrute_enable) then
                client.unset_event_callback("paint_ui", Returner)
                event_callback("setup_command", main_aa)
                set_brute = false
                brut3 = false
                bruteforce_reset = true
                set_brute = false
                aa.ignore = false
            end
        end
        return shot_time
    end)

    client.set_event_callback("setup_command", function(cmd)
        ground_check = cmd.in_jump == 0
        if set_brute == false then return end
        ui.set(refs.pitch[1], "Down")
        aa.ignore = true
        if func.table_contains(ui.get(aaBuilder[vars.pState].antibrute_aa), "Yaw") then
            ui.set(refs.yaw[1], "180")
            ui.set(refs.yaw[2], ui.get(aaBuilder[vars.pState].antibrute_yaw))
        end
        if func.table_contains(ui.get(aaBuilder[vars.pState].antibrute_aa), "Modifier") then
            if ui.get(aaBuilder[vars.pState].antibrute_mod) == "Center" then
                ui.set(refs.yawJitter[1], "Center")
                ui.set(refs.yawJitter[2], ui.get(aaBuilder[vars.pState].antibrute_mod_range))
            elseif ui.get(aaBuilder[vars.pState].antibrute_mod) == "Random" then
                ui.set(refs.yawJitter[1], "Random")
                ui.set(refs.yawJitter[2], ui.get(aaBuilder[vars.pState].antibrute_mod_range))
            elseif ui.get(aaBuilder[vars.pState].antibrute_mod) == "S-Way" then
                local speed = 4
                local range = ui.get(aaBuilder[vars.pState].antibrute_mod_range)
                ui.set(refs.yawJitter[1], "Center")
                ui.set(refs.yawJitter[2], math.sin(globals.curtime() * speed) * range)
            elseif ui.get(aaBuilder[vars.pState].antibrute_mod) == "Delayed" then
                ui.set(refs.yaw[1], "180")
                ui.set(refs.yaw[2], a_bodydel and -ui.get(aaBuilder[vars.pState].antibrute_mod_range) or ui.get(aaBuilder[vars.pState].antibrute_mod_range))
            end
                

        end
        if func.table_contains(ui.get(aaBuilder[vars.pState].antibrute_aa), "Body Yaw") then
            if ui.get(aaBuilder[vars.pState].antibrute_body) == "Static" then
                ui.set(refs.bodyYaw[1], "Static")
                ui.set(refs.bodyYaw[2], ui.get(aaBuilder[vars.pState].antibrute_body_range))
            elseif ui.get(aaBuilder[vars.pState].antibrute_body) == "Jitter" then
                ui.set(refs.bodyYaw[1], "Jitter")
                ui.set(refs.bodyYaw[2], ui.get(aaBuilder[vars.pState].antibrute_body_range))
            elseif ui.get(aaBuilder[vars.pState].antibrute_body) == "Delayed" then
                ui.set(refs.bodyYaw[1], "Static")
                ui.set(refs.bodyYaw[2], a_bodydel and -1 or 1)
            end
        end
    end)

    local hitboxes = {
        ind = {
            1, 
            2, 
            3, 
            4, 
            5, 
            6, 
            7
        }, 

        name = {
            "head", 
            "chest", 
            "stomach", 
            "left_arm", 
            "right_arm", 
            "left_leg", 
            "right_leg"
        }
    }

    local bot_data = {
        start_position = vector(0,0,0),
        cache_eye_left = vector(0,0,0), 
        cache_eye_right = vector(0,0,0),
        left_trace_active,
        right_trace_active,
        peekbot_active,
        calculate_wall_dist_left = 0, 
        calculate_wall_dist_right = 0,
        set_location = true,
        shot_fired = false,
        reload_timer = 0,
        reached_max_distance = false,
        should_return = false,
        tracer_position,
        lerp_distance = 0
    }


    local ground_ticks = 0
    event_callback("pre_render", function(cmd)
        if not entity.get_local_player() then return end
        local flags = entity.get_prop(entity.get_local_player(), "m_fFlags")
        ground_ticks = bit.band(flags, 1) == 0 and 0 or (ground_ticks < 5 and ground_ticks + 1 or ground_ticks)
        local self = entity.get_local_player()
        local self_index = c_ent.new(self)
        local self_anim_state = self_index:get_anim_state()
        local onground = bit.band(flags, 1) ~= 0

        local function jitter_value()
            local current_time = globals.tickcount() / 10
            local jitter_frequency = 7
            local jitter_factor = 0.5 + 0.5 * math.sin(current_time * jitter_frequency)
            return jitter_factor * 100
        end

        if ui.get(menu.visualsTab.ap_move) == "Jitter" and onground then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, tickcount() % 4 > 1 and 0 or 1)
            ui.set(refs.legMovement, "Always slide")
        elseif ui.get(menu.visualsTab.ap_move) == "Static" and onground then
            ui.set(refs.legMovement, "Always slide")
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
        elseif ui.get(menu.visualsTab.ap_move) == "Moonwalk" and onground then
            ui.set(refs.legMovement, "Never slide")
            if not legsSaved then
                legsSaved = ui.get(refs.legMovement)
            end
            ui.set_visible(refs.legMovement, false)
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 7)
            me = c_ent.get_local_player()
            flags = me:get_prop("m_fFlags")
            onground = bit.band(flags, 1) ~= 0
            if onground then
                my_animlayer = me:get_anim_overlay(6)
                my_animlayer.weight = 1
                my_animlayer.cycle = globals.realtime() * 0.5 % 1
            end
        end

        if ui.get(menu.visualsTab.ap_air) == "Falling" and not onground then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 6) 
        elseif ui.get(menu.visualsTab.ap_air) == "Moonwalk" and not onground then
            ui.set(refs.legMovement, "Never slide")
            if not legsSaved then
                legsSaved = ui.get(refs.legMovement)
            end
            ui.set_visible(refs.legMovement, false)
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 7)
            me = c_ent.get_local_player()
            flags = me:get_prop("m_fFlags")
            onground = bit.band(flags, 1) ~= 0
            if not onground then
                my_animlayer = me:get_anim_overlay(6)
                my_animlayer.weight = 1
                my_animlayer.cycle = globals.realtime() * 0.5 % 1
            end
        elseif ui.get(menu.visualsTab.ap_air) == "Kangaroo" and not onground then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 2)/2, 2)
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 2)/2, 1)
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 2)/2, 2)
        elseif ui.get(menu.visualsTab.ap_air) == "Earthquake" and not onground then
            local self_anim_overlay = self_index:get_anim_overlay(12)
            if not self_anim_overlay then return end

            if globals.tickcount() % 90 > 1 then
                self_anim_overlay.weight = jitter_value() / 100
            end
        end


        if ui.get(menu.visualsTab.a_pitch) then
            ground_ticks = bit.band(flags, 1) == 1 and ground_ticks + 1 or 0

            if ground_ticks > 5 and ground_ticks < 80 then
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
            end
        end

        if ui.get(menu.visualsTab.a_body) then
            local self_anim_overlay = self_index:get_anim_overlay(12)
            if not self_anim_overlay then
                return
            end

            local x_velocity = entity.get_prop(self, "m_vecVelocity[0]")
            if math.abs(x_velocity) >= 3 then
                self_anim_overlay.weight = 1
            end
        end

    end)



    local alpha, scopedFraction, acatelScoped, dtModifier, barMoveY, activeFraction, inactiveFraction, defensiveFraction, hideFraction, hideInactiveFraction, dtPos, osPos, mainIndClr, dtClr, chargeClr, chargeInd, psClr, dtInd, qpInd, fdInd, spInd, baInd, fsInd, osInd, psInd, wAlpha, interval = 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, {y = 0}, {y = 0}, {r = 0, g = 0, b = 0, a = 0}, {r = 0, g = 0, b = 0, a = 0}, {r = 0, g = 0, b = 0, a = 0}, {w = 0, x = 0, y = 25}, {r = 0, g = 0, b = 0, a = 0}, {w = 0, x = 0, y = 25}, {w = 0, x = 0, y = 25, a = 0}, {w = 0, x = 0, y = 25, a = 0}, {w = 0, x = 0, y = 25, a = 0}, {w = 0, x = 0, y = 25, a = 0}, {w = 0, x = 0, y = 25, a = 0}, {w = 0, x = 0, y = 25, a = 0}, {w = 0, x = 0, y = 25}, 0, 0

    -- data = {}

    -- local aa_dir, m_iSide = 0, 0

    -- e_manuals = function()
    --     local m_iSide = 0 

    --     local isLeft = ui.get(menu.aaTab.m_left)
    --     local isRight = ui.get(menu.aaTab.m_right)

        
    --     if isLeft and isRight then
            
    --         ui.set(menu.aaTab.m_right, false)
    --         m_iSide = 1 
    --     elseif isLeft then
    --         m_iSide = 1 
    --     elseif isRight then
    --         m_iSide = 2 
    --     end

        
    --     if not isLeft and not isRight then
    --         m_iSide = 0 
    --     end

    --     return m_iSide
    -- end

    --сд

    local current_damage = 0
    local target_damage = 0
    local anim_start_time = 0
    local anim_duration = 3


    local last_fps = 0
    local update_interval = 60
    local frame_count = 0

    function get_fps()
        frame_count = frame_count + 1

        if frame_count >= update_interval then
            last_fps = 1.0 / globals.frametime()
            frame_count = 0
        end

        return last_fps
    end

    function get_rate()
        return 1.0 / globals.tickinterval()
    end

    local glow_time = 0
    function get_glow_color()
        glow_time = glow_time + globals.frametime() * 2
        local r = math.floor(128 + 127 * math.sin(glow_time))
        local g = math.floor(128 + 127 * math.sin(glow_time + 2))
        local b = math.floor(128 + 127 * math.sin(glow_time + 4))
        return r, g, b
    end

    function RenderRoundRectangle(x, y, w, h, radius, color)
        if color[4] <= 0 then
            return
        end

        renderer.rectangle(x, y + radius, radius, h - radius * 2, color[1], color[2], color[3], color[4])
        renderer.rectangle(x + radius, y, w - radius * 2, radius, color[1], color[2], color[3], color[4])
        renderer.rectangle(x + radius, y + h - radius, w - radius * 2, radius, color[1], color[2], color[3], color[4])
        renderer.rectangle(x + w - radius, y + radius, radius, h - radius * 2, color[1], color[2], color[3], color[4])

        renderer.rectangle(x + radius, y + radius, w - radius * 2, h - radius * 2, color[1], color[2], color[3], color[4])

        renderer.circle(x + radius, y + radius, color[1], color[2], color[3], color[4], radius, 180, 0.25)
        renderer.circle(x + radius, y + h - radius, color[1], color[2], color[3], color[4], radius, 270, 0.25)
        renderer.circle(x + w - radius, y + radius, color[1], color[2], color[3], color[4], radius, 90, 0.25)
        renderer.circle(x + w - radius, y + h - radius, color[1], color[2], color[3], color[4], radius, 0, 0.25)
    end

    function RenderBlurredLine(x, y, w, h, r, g, b, a, blur_strength)
        blur_strength = 0.2
        local blur_alpha = math.floor(a / (blur_strength * 2))

        for i = -blur_strength, blur_strength do
            for j = -blur_strength, blur_strength do
                if i ~= 0 or j ~= 0 then
                    renderer.rectangle(x + i, y + j, w, h, r, g, b, blur_alpha)
                end
            end
        end

        renderer.rectangle(x, y, w, h, r, g, b, a)
    end

    dragg = (function()
        local a = {}
        local b, c, d, e, f, g, h, i, j, k, l, m, n, o

        local p = {
            __index = {
                drag = function(self, ...)
                    local q, r = self:get()
                    local s, t = a.drag(q, r, ...)
                    if q ~= s or r ~= t then
                        self:set(s, t)
                    end
                    return s, t
                end,
                set = function(self, q, r)
                    local j, k = client.screen_size()
                    ui.set(self.x_reference, q / j * self.res)
                    ui.set(self.y_reference, r / k * self.res)
                end,
                get = function(self)
                    local j, k = client.screen_size()
                    return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
                end
            }
        }

        function a.new(u, v, w, x)
            x = x or 10000
            local j, k = client.screen_size()
            local y = ui.new_slider('LUA', 'A', u .. ' window position', 0, x, v / j * x)
            local z = ui.new_slider('LUA', 'A', '\n' .. u .. ' window position y', 0, x, w / k * x)
            ui.set_visible(y, false)
            ui.set_visible(z, false)
            return setmetatable({ name = u, x_reference = y, y_reference = z, res = x }, p)
        end

        function a.drag(q, r, A, B, C, D, E)
            if globals.framecount() ~= b then
                c = ui.is_menu_open()
                f, g = d, e
                d, e = ui.mouse_position()
                i = h
                h = client.key_state(0x01) == true
                m = l
                l = {}
                o = n
                n = false
                j, k = client.screen_size()
            end

            if c and i ~= nil then
                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                    n = true
                    q, r = q + d - f, r + e - g
                    if not D then
                        q = math.max(0, math.min(j - A, q))
                        r = math.max(0, math.min(k - B, r))
                    end
                end
            end

            table.insert(l, { q, r, A, B })
            return q, r, A, B
        end

        return a
    end)()

    dragg2 = (function()
        local a = {}
        local b, c, d, e, f, g, h, i, j, k, l, m, n, o

        local p = {
            __index = {
                drag = function(self, ...)
                    local q, r = self:get()
                    local s, t = a.drag(q, r, ...)
                    if q ~= s or r ~= t then
                        self:set(s, t)
                    end
                    return s, t
                end,
                set = function(self, q, r)
                    local j, k = client.screen_size()
                    ui.set(self.x_reference, q / j * self.res)
                    ui.set(self.y_reference, r / k * self.res)
                end,
                get = function(self)
                    local j, k = client.screen_size()
                    return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
                end
            }
        }

        function a.new(u, v, w, x)
            x = x or 10000
            local j, k = client.screen_size()
            local y = ui.new_slider('LUA', 'A', u .. ' window position', 0, x, v / j * x)
            local z = ui.new_slider('LUA', 'A', '\n' .. u .. ' window position y', 0, x, w / k * x)
            ui.set_visible(y, false)
            ui.set_visible(z, false)
            return setmetatable({ name = u, x_reference = y, y_reference = z, res = x }, p)
        end

        function a.drag(q, r, A, B, C, D, E)
            if globals.framecount() ~= b then
                c = ui.is_menu_open()
                f, g = d, e
                d, e = ui.mouse_position()
                i = h
                h = client.key_state(0x01) == true
                m = l
                l = {}
                o = n
                n = false
                j, k = client.screen_size()
            end

            if c and i ~= nil then
                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                    n = true
                    q, r = q + d - f, r + e - g
                    if not D then
                        q = math.max(0, math.min(j - A, q))
                        r = math.max(0, math.min(k - B, r))
                    end
                end
            end

            table.insert(l, { q, r, A, B })
            return q, r, A, B
        end

        return a
    end)()

    dragg3 = (function()
        local a = {}
        local b, c, d, e, f, g, h, i, j, k, l, m, n, o

        local p = {
            __index = {
                drag = function(self, ...)
                    local q, r = self:get()
                    local s, t = a.drag(q, r, ...)
                    if q ~= s or r ~= t then
                        self:set(s, t)
                    end
                    return s, t
                end,
                set = function(self, q, r)
                    local j, k = client.screen_size()
                    ui.set(self.x_reference, q / j * self.res)
                    ui.set(self.y_reference, r / k * self.res)
                end,
                get = function(self)
                    local j, k = client.screen_size()
                    return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
                end
            }
        }

        function a.new(u, v, w, x)
            x = x or 10000
            local j, k = client.screen_size()
            local y = ui.new_slider('LUA', 'A', u .. ' window position', 0, x, v / j * x)
            local z = ui.new_slider('LUA', 'A', '\n' .. u .. ' window position y', 0, x, w / k * x)
            ui.set_visible(y, false)
            ui.set_visible(z, false)
            return setmetatable({ name = u, x_reference = y, y_reference = z, res = x }, p)
        end

        function a.drag(q, r, A, B, C, D, E)
            if globals.framecount() ~= b then
                c = ui.is_menu_open()
                f, g = d, e
                d, e = ui.mouse_position()
                i = h
                h = client.key_state(0x01) == true
                m = l
                l = {}
                o = n
                n = false
                j, k = client.screen_size()
            end

            if c and i ~= nil then
                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                    n = true
                    q, r = q + d - f, r + e - g
                    if not D then
                        q = math.max(0, math.min(j - A, q))
                        r = math.max(0, math.min(k - B, r))
                    end
                end
            end

            table.insert(l, { q, r, A, B })
            return q, r, A, B
        end

        return a
    end)()

    local screen_x, screen_y = client.screen_size()
    local hud_x = screen_x / 2
    local hud_y = screen_y / 2

    local watermarkDraggable = dragg.new("Watermark", hud_x+hud_x - 320, hud_y -  hud_y + 30)
    local fpsDraggable = dragg2.new("FPS", hud_x+hud_x - 210, hud_y - hud_y + 30)
    local timeDraggable = dragg3.new("Time", hud_x+hud_x - 106, hud_y - hud_y + 30)


    event_callback("paint", function()
        -- print("Memory usage:", collectgarbage("count"))
        local local_player = entity.get_local_player()
        vars.localPlayer = entity.get_local_player()
        if local_player == nil or entity.is_alive(local_player) == false then return end
        local sizeX, sizeY = client.screen_size()
        local weapon = entity.get_player_weapon(local_player)
        local bodyYaw = entity.get_prop(local_player, "m_flPoseParameter", 11) * 120 - 60
        local side = bodyYaw > 0 and 1 or -1
        local state = "Running"
        local mainClr = {}
        mainClr.r, mainClr.g, mainClr.b, mainClr.a = ui.get(calar)
        local fake = math.floor(antiaim_funcs.get_desync(1))
        


        local scopeLevel = entity.get_prop(weapon, 'm_zoomLevel')
        local scoped = entity.get_prop(local_player, 'm_bIsScoped') == 1
        local resumeZoom = entity.get_prop(local_player, 'm_bResumeZoom') == 1
        local isValid = weapon ~= nil and scopeLevel ~= nil
        local act = isValid and scopeLevel > 0 and scoped and not resumeZoom
        local time = globals.frametime() * 30

        if act then
            if scopedFraction < 1 then
                scopedFraction = func.lerp(scopedFraction, 1 + 0.1, time)
            else
                scopedFraction = 1
            end
        else
            scopedFraction = func.lerp(scopedFraction, 0, time)
        end


        local dpi = 0
        local globalFlag = "cd-"
        local globalMoveY = 0
        local indX, indY = renderer.measure_text(globalFlag, "DT")
        indY = globalFlag == "cd-" and indY - 3 or indY - 2

        local nextAttack = entity.get_prop(vars.localPlayer, "m_flNextAttack")
        local nextPrimaryAttack = entity.get_prop(entity.get_player_weapon(vars.localPlayer), "m_flNextPrimaryAttack")
        local dtActive = false
        if nextPrimaryAttack ~= nil then
            dtActive = not (math.max(nextPrimaryAttack, nextAttack) > globals.curtime())
        end
        local isCharged = dtActive
        local isFs = ui.get(menu.aaTab.freestandHotkey)
        local isBa = ui.get(refs.forceBaim)
        local isSp = ui.get(refs.safePoint)
        local isQp = ui.get(refs.quickPeek[2])
        local isSlow = ui.get(refs.slow[1]) and ui.get(refs.slow[2])
        local isOs = ui.get(refs.os[1]) and ui.get(refs.os[2])
        local isFd = ui.get(refs.fakeDuck)
        local isDt = ui.get(refs.dt[1]) and ui.get(refs.dt[2])

        local state = vars.intToS[vars.pState]:upper()

        

        if ui.get(menu.visualsTab.cros_ind) then
            local strike_w, strike_h = renderer.measure_text("-cd", lua_name )
            local ate = animate_text(globals.curtime(), "velours.lua :3", 255, 192, 203, 255)

            renderer.text(sizeX/2 + ((strike_w + 2)/2) * scopedFraction, sizeY/2 + 20 - dpi/10, 155, 0, 0, 0, "-cd", nil, unpack(ate))

            local count = 0

            if isDt and dtActive and isDefensive == false then
                activeFraction = func.clamp(activeFraction + globals.frametime()/0.15, 0, 1)
                if dtPos.y < indY * count then
                    dtPos.y = func.lerp(dtPos.y, indY * count + 0.1, time)
                else
                    dtPos.y = indY * count
                end
                count = count + 1
            else
                activeFraction = func.clamp(activeFraction - globals.frametime()/0.15, 0, 1)
            end

            if isDt and dtActive and isDefensive then
                defensiveFraction = func.clamp(defensiveFraction + globals.frametime()/0.15, 0, 1)
                if dtPos.y < indY * count then
                    dtPos.y = func.lerp(dtPos.y, indY * count + 0.1, time)
                else
                    dtPos.y = indY * count
                end
                count = count + 1
            else
                defensiveFraction = func.clamp(defensiveFraction - globals.frametime()/0.15, 0, 1)
                isDefensive = false
            end

            if isDt and not dtActive then
                inactiveFraction = func.clamp(inactiveFraction + globals.frametime()/0.15, 0, 1)
                if dtPos.y < indY * count then
                    dtPos.y = func.lerp(dtPos.y, indY * count + 0.1, time)
                else
                    dtPos.y = indY * count
                end
                count = count + 1
            else
                inactiveFraction = func.clamp(inactiveFraction - globals.frametime()/0.15, 0, 1)
            end

            if isOs and ui.get(ref_ui("Rage", "Other", "Silent aim")) and isDt then
                hideInactiveFraction = func.clamp(hideInactiveFraction + globals.frametime()/0.15, 0, 1)
                if osPos.y < indY * count then
                    osPos.y = func.lerp(osPos.y, indY * count + 0.1, time)
                else
                    osPos.y = indY * count
                end
                count = count + 1
            else
                hideInactiveFraction = func.clamp(hideInactiveFraction - globals.frametime()/0.15, 0, 1)
            end

            if isOs and ui.get(ref_ui("Rage", "Other", "Silent aim")) and not isDt then
                hideFraction = func.clamp(hideFraction + globals.frametime()/0.15, 0, 1)
                if osPos.y < indY * count then
                    osPos.y = func.lerp(osPos.y, indY * count + 0.1, time)
                else
                    osPos.y = indY * count
                end
                count = count + 1
            else
                hideFraction = func.clamp(hideFraction - globals.frametime()/0.15, 0, 1)
            end

            local globalMarginX, globalMarginY = renderer.measure_text("-cd", "DSAD")
            globalMarginY = globalMarginY - 2
            local dt_size = renderer.measure_text("-cd", "DT")
            local ready_size = renderer.measure_text("-cd", " ")
            renderer.text(sizeX/2 + ((dt_size + ready_size + 2)/2) * scopedFraction, sizeY/2 + 30 + globalMarginY + dtPos.y, 255, 255, 255, activeFraction * 255, "-cd", dt_size + activeFraction * ready_size + 1, "\a" .. func.RGBAtoHEX(5, 255, 5, 255 * activeFraction) .. "DT ", "\a" .. func.RGBAtoHEX(5, 255, 5, 255 * activeFraction) .. " ")
            
            local charging_size = renderer.measure_text("-cd", " ")
            local ret = animate_text(globals.curtime(), " ", 255, 0, 0, 255)
            renderer.text(sizeX/2 + ((dt_size + charging_size + 2)/2) * scopedFraction, sizeY/2 + 30 + globalMarginY + dtPos.y, 255, 255, 255, inactiveFraction * 255, "-cd", dt_size + inactiveFraction * charging_size + 1, "\a" .. func.RGBAtoHEX(255, 0, 0, 255 * inactiveFraction) .. "DT ", unpack(ret))

            local defensive_size = renderer.measure_text("-cd", "DEFENSIVE")
            local def = animate_text(globals.curtime(), "DEFENSIVE", mainClr.r, mainClr.g, mainClr.b, 255)
            renderer.text(sizeX/2 + ((dt_size + defensive_size + 2)/2) * scopedFraction, sizeY/2 + 30 + globalMarginY + dtPos.y, 255, 255, 255, defensiveFraction * 255, "-cd", dt_size + defensiveFraction * defensive_size + 1, "DT ", unpack(def))

            local hide_size = renderer.measure_text("-cd", "OSAA ")
            local active_size = renderer.measure_text("-cd", "ACTIVE")
            renderer.text(sizeX/2 + ((hide_size + active_size + 2)/2) * scopedFraction, sizeY/2 + 30 + globalMarginY + osPos.y, 255, 255, 255, hideFraction * 255, "-cd", hide_size + hideFraction * active_size + 1, "OSAA ", "\a" .. func.RGBAtoHEX(255, 255, 0, 255 * hideFraction) .. "ACTIVE")
            
            local inactive_size = renderer.measure_text("-cd", "INACTIVE")
            local osin = animate_text(globals.curtime(), "INACTIVE", 255, 0, 0, 255)
            renderer.text(sizeX/2 + ((hide_size + inactive_size + 2)/2) * scopedFraction, sizeY/2 + 30 + globalMarginY + osPos.y, 255, 255, 255, hideInactiveFraction * 255, "-cd", hide_size + hideInactiveFraction * inactive_size + 1, "OSAA ", unpack(osin))
        
            local state_size = renderer.measure_text("-cd", '' .. string.upper(state) .. '')
            renderer.text(sizeX/2 + ((state_size + 2)/2) * scopedFraction, sizeY/2 + 30 , 255, 255, 255, 255, "-cd", 0, '' .. string.upper(state) .. '')
        end
        


        if ui.get(menu.visualsTab.min_ind_mode) ~= "-" and entity.get_classname(weapon) ~= "CKnife"  then
            local new_damage = ui.get(refs.minimum_damage)
            if ui.get(refs.minimum_damage_override[1]) and ui.get(refs.minimum_damage_override[2]) then
                new_damage = ui.get(refs.minimum_damage_override[3])
            end
        
            if new_damage ~= target_damage then
                target_damage = new_damage
                anim_start_time = globals.realtime()
            end
        
            local progress = (globals.realtime() - anim_start_time) / anim_duration
            progress = math.min(progress, 1)
        
            current_damage = lerp(current_damage, target_damage, progress)
        
            if ui.get(menu.visualsTab.min_ind) and ui.get(menu.visualsTab.min_ind_mode) == "Always" then
                if ui.get(menu.visualsTab.min_text) == "Pixel" then
                    renderer.text(sizeX / 2 + 5, sizeY / 2 - 7, 255, 255, 255, 255, "-cd", 0, math.floor(current_damage))
                elseif ui.get(menu.visualsTab.min_text) == "Default" then
                    renderer.text(sizeX / 2 + 3, sizeY / 2 - 15, 255, 255, 255, 255, "", 0, math.floor(current_damage))
                end
            elseif ui.get(menu.visualsTab.min_ind) and ui.get(refs.minimum_damage_override[1]) and ui.get(refs.minimum_damage_override[2]) and ui.get(menu.visualsTab.min_ind_mode) == "Bind" then
                if ui.get(menu.visualsTab.min_text) == "Pixel" then
                    renderer.text(sizeX / 2 + 3, sizeY / 2 - 7, 255, 255, 255, 255, "-cd", 0, math.floor(current_damage))
                elseif ui.get(menu.visualsTab.min_text) == "Default" then
                    renderer.text(sizeX / 2 + 3, sizeY / 2 - 15, 255, 255, 255, 255, "", 0, math.floor(current_damage))
                end
            end
        else
            anim_start_time = 0
            current_damage = 0
            target_damage = 0
        end
    end)





    --#region jumpscout

    function jumpscout(cmd)
        if ui.get(menu.miscTab.jump_scout) then
            local vel_x, vel_y = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
            local vel = math.sqrt(vel_x^2 + vel_y^2)
            ui.set(refs.air_strafe, not (cmd.in_jump and (vel < 10)) or ui.is_menu_open())
        end
    end
        
    --#end region jumpscout

    --#region chargedt

    function charge_dt()
        local isDt = ui.get(refs.dt[1]) and ui.get(refs.dt[2])
                
        if ui.get(menu.miscTab.charge_dt) then
            if not ui.get(ref.doubletap.main[2]) or not ui.get(ref.doubletap.main[1]) then
                ui.set(ref.aimbot, true)

                if callback_reg then
                    unset_event_callback('run_command', check_charge)
                    callback_reg = false
                end
                return
            end
            
            local_player = entity.get_local_player()
            
            if not callback_reg then
                event_callback('run_command', check_charge)
                callback_reg = true
            end
            
            local threat = client.current_threat()
            
            if not dt_charged
            and threat
            and bit.band(entity.get_prop(local_player, 'm_fFlags'), 1) == 0
            and bit.band(entity.get_esp_data(threat).flags, bit.lshift(1, 11)) == 2048 then
                ui.set(ref.aimbot, false)
            else
                ui.set(ref.aimbot, true)
            end
        end
    end

    --#eng region chargedt

    --#end region ragebot


    local skeetclantag = ui.reference('MISC', 'MISCELLANEOUS', 'Clan tag spammer')

    local duration = 30
    local clantags = {

    'T',
    'TG',
    'TG:',
    'TG: ',
    'TG: v',
    'TG: ve',
    'TG: vel',
    'TG: velo',
    'TG: velou',
    'TG: velour',
    'TG: velours',
    'TG: veloursc',
    'TG: velourscs',
    'TG: velourscsg',
    'TG: velourscsgo',
    'TG: velourscsg',
    'TG: velourscs',
    'TG: veloursc',
    'TG: velours',
    'TG: velour',
    'TG: velou',
    'TG: velo',
    'TG: vel',
    'TG: ve',
    'TG: v',
    'TG: ',
    'TG:',
    'TG',
    'T',

    }

    local clantagik = {
        'i',
        'i ',
        'i u',
        'i us',
        'i use',
        'i use ',
        'i use v',
        'i use ve',
        'i use vel',
        'i use velo',
        'i use velou',
        'i use velour',
        'i use velours',
        'i use velours.',
        'i use velours.l',
        'i use velours.lu',
        'i use velours.lua',
        'i use velours.lu',
        'i use velours.l',
        'i use velours.',
        'i use velours',
        'i use velour',
        'i use velou',
        'i use velo',
        'i use vel',
        'i use ve',
        'i use v',
        'i use ',
        'i use',
        'i us',
        'i u',
        'i ',
        'i',
    }

    local empty = {''}
    local clantag_prev
    event_callback('net_update_end', function()
        if ui.get(skeetclantag) then 
            return 
        end

        local cur = math.floor(globals.tickcount() / duration) % #clantags
        local clantag = clantags[cur+1]
        clantagik1 = clantagik[cur+1]

        if ui.get(menu.miscTab.clanTag) then
            if ui.get(menu.miscTab.clantag_mode) == "velours" then
                if clantag ~= clantag_prev then
                    clantag_prev = clantag
                    client.set_clan_tag(clantag)
                end
            elseif ui.get(menu.miscTab.clantag_mode) == "velours.lua" then
                if clantagik1 ~= clantag_prev then
                    clantag_prev = clantagik1
                    client.set_clan_tag(clantagik1)
                end
            end
        end
    end)
    ui.set_callback(menu.miscTab.clanTag, function() client.set_clan_tag('\0') end)

    function getspeed(player_index)
        return vector(entity.get_prop(player_index, "m_vecVelocity")):length()
    end




    ui.update(menu.configTab.list,getConfigList())
    if database.read(lua.database.configs) == nil then
        database.write(lua.database.configs, {})
    end
    ui.set(menu.configTab.name, #database.read(lua.database.configs) == 0 and "" or database.read(lua.database.configs)[ui.get(menu.configTab.list)+1].name)
    ui.set_callback(menu.configTab.list, function(value)
        local protected = function()
            if value == nil then return end
            local name = ""
        
            local configs = getConfigList()
            if configs == nil then return end
        
            name = configs[ui.get(value)+1] or ""
        
            ui.set(menu.configTab.name, name)
        end

        if pcall(protected) then

        end
    end)

    ui.set_callback(menu.configTab.load, function()
        local name = ui.get(menu.configTab.name)
        if name == "" then
            notifications.new( "Config name is empty", 255, 120, 120)
            return
        end

        local protected = function()
            print("Loading config: " .. name)

            local config = getConfig(name)
            if not config then
                error("Config not found: " .. name)
            end

            loadSettings(config.config)

            
            print("Config loaded successfully: " .. name)
        end

        local status, err = pcall(protected)
        if status then
            name = name:gsub('*', '')
            notifications.new(string.format('Successfully loaded "%s"', name), 0, 255, 0)
        else
            notifications.new(string.format('Failed to load "%s": %s', name, err), 255, 120, 120)
        end
    end)

    ui.set_callback(menu.configTab.save, function()

            local name = ui.get(menu.configTab.name)
            if name == "" then return end
        
            for i, v in pairs(presets) do
                if v.name == name:gsub('*', '') then
                    notifications.new(string.format('You can`t save built-in preset "%s"', name:gsub('*', '')), 255, 120, 120)
                    return
                end
            end

            if name:match("[^%w%s%p]") ~= nil then
                notifications.new(string.format('Failed to save "%s" due to invalid characters', name), 255, 120, 120)
                return
            end
        local protected = function()
            saveConfig(menu, name)
            ui.update(menu.configTab.list, getConfigList())
        end
        if pcall(protected) then
            notifications.new(string.format('Successfully saved "%s"', name), 255, 255, 255)
        end
    end)

    ui.set_callback(menu.configTab.create, function()
        local name = ui.get(menu.configTab.create_name)
        if name == "" then return end
        for i, v in pairs(presets) do
            if v.name == name:gsub('*', '') then
                notifications.new(string.format('You can`t create built-in preset "%s"', name:gsub('*', '')), 255, 120, 120)
                return
            end
        end
        if name:match("[^%w%s%p]") ~= nil then
            notifications.new(string.format('Failed to create "%s" due to invalid characters', name), 255, 120, 120)
            return
        end

        local protected = function()
            saveConfig(menu, name)
            ui.update(menu.configTab.list, getConfigList())
        end

        local status, err = pcall(protected)
        if status then
            name = name:gsub('*', '')
            notifications.new(string.format('Successfully created "%s"', name), 255, 255, 255)
        else
            notifications.new(string.format('Failed to created "%s": %s', name, err), 255, 120, 120)
        end
    end)

    ui.set_callback(menu.configTab.delete, function()
        local name = ui.get(menu.configTab.name)
        if name == "" or name == "*Default" then return end
        if deleteConfig(name) == false then
            notifications.new(string.format('Failed to delete "%s"', name), 255, 120, 120)
            ui.update(menu.configTab.list, getConfigList())
            return
        end

        for i, v in pairs(presets) do
            if v.name == name:gsub('*', '') then
                notifications.new(string.format('You can`t delete built-in preset "%s"', name:gsub('*', '')), 255, 120, 120)
                return
            end
        end

        local protected = function()
            deleteConfig(name)
        end

        if pcall(protected) then
            ui.update(menu.configTab.list, getConfigList())
            ui.set(menu.configTab.list, #presets + #database.read(lua.database.configs) - #database.read(lua.database.configs))
            ui.set(menu.configTab.name, #database.read(lua.database.configs) == 0 and "" or getConfigList()[#presets + #database.read(lua.database.configs) - #database.read(lua.database.configs)+1])
            notifications.new(string.format('Successfully deleted "%s"', name), 255, 255, 255)
        end
    end)

    --виев

    lerpd = function(start, vend, time)
        return start + (vend - start) * time
    end

    local current_fov = 0
    local current_x = 0
    local current_y = 0
    local current_z = 0

    local target_fov = 68
    local target_x = 0
    local target_y = 0
    local target_z = 0

    local animation_speed = 0.1

    viewmodel_ch = function()
        if ui.get(menu.visualsTab.viewmodel_en) then
            target_fov = ui.get(menu.visualsTab.viewmodel_fov)
            target_x = ui.get(menu.visualsTab.viewmodel_x) / 10
            target_y = ui.get(menu.visualsTab.viewmodel_y) / 10
            target_z = ui.get(menu.visualsTab.viewmodel_z) / 10
        else
            target_fov = 68
            target_x = 0
            target_y = 0
            target_z = 0
        end
    end

    local function animate_viewmodel()
        current_fov = lerpd(current_fov, target_fov, animation_speed)
        current_x = lerpd(current_x, target_x, animation_speed)
        current_y = lerpd(current_y, target_y, animation_speed)
        current_z = lerpd(current_z, target_z, animation_speed)

        client.set_cvar("viewmodel_fov", current_fov)
        client.set_cvar("viewmodel_offset_x", current_x)
        client.set_cvar("viewmodel_offset_y", current_y)
        client.set_cvar("viewmodel_offset_z", current_z)
    end

    client.set_event_callback("paint_ui", function()
        animate_viewmodel()
    end)

    ui.set_callback(menu.visualsTab.viewmodel_en, viewmodel_ch)
    ui.set_callback(menu.visualsTab.viewmodel_fov, viewmodel_ch)
    ui.set_callback(menu.visualsTab.viewmodel_x, viewmodel_ch)
    ui.set_callback(menu.visualsTab.viewmodel_y, viewmodel_ch)
    ui.set_callback(menu.visualsTab.viewmodel_z, viewmodel_ch)

    clamp2 = function(v, min, max) local num = v; num = num < min and min or num; num = num > max and max or num; return num end

    easing, m_alpha = require "gamesense/easing", 0

    scope_overlay = ui.reference('VISUALS', 'Effects', 'Remove scope overlay')

    g_paint_ui = function()
        ui.set(scope_overlay, true)
    end

    g_paint = function()
        ui.set(scope_overlay, false)

        local width, height = client.screen_size()
        local offset, initial_position, speed, color =
            ui.get(menu.visualsTab.custom_offset) * height / 1080, 
            ui.get(menu.visualsTab.custom_initial_pos) * height / 1080, 
            12, { ui.get(menu.visualsTab.custom_color) }

        local me = entity.get_local_player()
        local wpn = entity.get_player_weapon(me)

        local scope_level = entity.get_prop(wpn, 'm_zoomLevel')
        local scoped = entity.get_prop(me, 'm_bIsScoped') == 1
        local resume_zoom = entity.get_prop(me, 'm_bResumeZoom') == 1

        local is_valid = --[[entity.is_alive(me) and ]]wpn ~= nil and scope_level ~= nil
        local act = is_valid and scope_level > 0 and scoped and not resume_zoom

        local FT = speed > 3 and globals.frametime() * speed or 1
        local alpha = easing.linear(m_alpha, 0, 1, 1)

        renderer.gradient(width/2 - initial_position + 2, height / 2, initial_position - offset, 1, color[1], color[2], color[3], 0, color[1], color[2], color[3], alpha*color[4], true)
        renderer.gradient(width/2 + offset, height / 2, initial_position - offset, 1, color[1], color[2], color[3], alpha*color[4], color[1], color[2], color[3], 0, true)

        renderer.gradient(width / 2, height/2 - initial_position + 2, 1, initial_position - offset, color[1], color[2], color[3], 0, color[1], color[2], color[3], alpha*color[4], false)
        renderer.gradient(width / 2, height/2 + offset, 1, initial_position - offset, color[1], color[2], color[3], alpha*color[4], color[1], color[2], color[3], 0, false)
        
        m_alpha = clamp2(m_alpha + (act and FT or -FT), 0, 1)
    end

    ui_callback = function(c)
        local master_switch, addr = ui.get(c), ''

        if not master_switch then
            m_alpha, addr = 0, 'un'
        end
        
        local _func = client[addr .. 'set_event_callback']

        _func('paint_ui', g_paint_ui)
        _func('paint', g_paint)
    end

    ui.set_callback(menu.visualsTab.custom_scope, ui_callback)
    ui_callback(menu.visualsTab.custom_scope)


    start_time = client.unix_time()
    function get_elapsed_time()
        local elapsed_seconds = client.unix_time() - start_time
        local hours = math.floor(elapsed_seconds / 3600)
        local minutes = math.floor((elapsed_seconds - hours * 3600) / 60)
        local seconds = math.floor(elapsed_seconds - hours * 3600 - minutes * 60)
        return string.format("%02d:%02d:%02d", hours, minutes, seconds)
    end

    icon_texture = renderer.load_png(readfile("csgo/materials/panorama/images/amnesia_water.png"))


    g_paint_handler = function()
        if ui.is_menu_open() then

            local menu_pos = { ui.menu_position() }
            local menu_size = { ui.menu_size() }
            local speed = globals.frametime() * 8


            local hours, minutes = client.system_time()
            local time = string.format("%02d:%02d", hours, minutes)


            if menu_pos[1] and menu_size[1] then

                renderer.gradient(
                    menu_pos[1],
                    menu_pos[2] - panel_height - panel_offset,
                    menu_size[1],
                    panel_height,
                    panel_color[1], panel_color[2], panel_color[3], panel_color[4],
                    panel_color[1] * 0.8, panel_color[2] * 0.8, panel_color[3] * 0.8, panel_color[4],
                    true
                )


                local border_thickness = 2
                renderer.gradient(
                    menu_pos[1] - border_thickness,
                    menu_pos[2] - panel_height - panel_offset - border_thickness,
                    menu_size[1] + border_thickness * 2,
                    border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    false
                )
                renderer.gradient(
                    menu_pos[1] - border_thickness,
                    menu_pos[2] - panel_offset,
                    menu_size[1] + border_thickness * 2,
                    border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    false
                )
                renderer.gradient(
                    menu_pos[1] - border_thickness,
                    menu_pos[2] - panel_height - panel_offset,
                    border_thickness,
                    panel_height + border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    true
                )
                renderer.gradient(
                    menu_pos[1] + menu_size[1],
                    menu_pos[2] - panel_height - panel_offset,
                    border_thickness,
                    panel_height + border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    true
                )


                renderer.texture(
                    icon_texture,
                    menu_pos[1] + 5,
                    menu_pos[2] - panel_height - panel_offset + 5,
                    15, 15,
                    255, 255, 255, 255
                )
                renderer.rectangle(
                    menu_pos[1] + 4,
                    menu_pos[2] - panel_height - panel_offset + 4,
                    17, 17,
                    0, 0, 0, 100
                )


                renderer.text(
                    menu_pos[1] + 25 + 1,
                    menu_pos[2] - panel_height - panel_offset + 6,
                    0, 0, 0, 100,
                    "", 0, lua_name .. " / " .. script_build
                )
                renderer.text(
                    menu_pos[1] + 25,
                    menu_pos[2] - panel_height - panel_offset + 5,
                    text_color[1], text_color[2], text_color[3], text_color[4],
                    "", 0, lua_name .. " / " .. script_build
                )


                renderer.text(
                    menu_pos[1] + menu_size[1] - 51,
                    menu_pos[2] - panel_height - panel_offset + 6,
                    0, 0, 0, 100,
                    "", 0, time
                )
                renderer.text(
                    menu_pos[1] + menu_size[1] - 50,
                    menu_pos[2] - panel_height - panel_offset + 5,
                    text_color[1], text_color[2], text_color[3], text_color[4],
                    "", 0, time
                )


                renderer.text(
                    menu_pos[1] + menu_size[1] - 351,
                    menu_pos[2] - panel_height - panel_offset + 6,
                    0, 0, 0, 100,
                    my_font, 0
                )
                renderer.text(
                    menu_pos[1] + menu_size[1] - 350,
                    menu_pos[2] - panel_height - panel_offset + 5,
                    text_color[1], text_color[2], text_color[3], text_color[4],
                    my_font, 0
                )
            end
        end
    end


    g_paint_handler_u = function()
        if ui.is_menu_open() then

            local menu_pos = { ui.menu_position() }
            local menu_size = { ui.menu_size() }
            local speed = globals.frametime() * 8

            local hours, minutes = client.system_time()
            local time = string.format("%02d:%02d", hours, minutes)

            if menu_pos[1] and menu_size[1] then
                renderer.gradient(
                    menu_pos[1],
                    menu_pos[2] + menu_size[2] + panel_offset,
                    menu_size[1],
                    panel_height,
                    panel_color[1], panel_color[2], panel_color[3], panel_color[4],
                    panel_color[1] * 0.8, panel_color[2] * 0.8, panel_color[3] * 0.8, panel_color[4],
                    true
                )

                local border_thickness = 2
                renderer.gradient(
                    menu_pos[1] - border_thickness,
                    menu_pos[2] + menu_size[2] + panel_offset,
                    menu_size[1] + border_thickness * 2,
                    border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    false
                )
                renderer.gradient(
                    menu_pos[1] - border_thickness,
                    menu_pos[2] + menu_size[2] + panel_offset + panel_height,
                    menu_size[1] + border_thickness * 2,
                    border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    false
                )
                renderer.gradient(
                    menu_pos[1] - border_thickness,
                    menu_pos[2] + menu_size[2] + panel_offset,
                    border_thickness,
                    panel_height + border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    true
                )
                renderer.gradient(
                    menu_pos[1] + menu_size[1],
                    menu_pos[2] + menu_size[2] + panel_offset,
                    border_thickness,
                    panel_height + border_thickness,
                    255, 255, 255, 50,
                    255, 255, 255, 0,
                    true
                )

                renderer.texture(
                    icon_texture,
                    menu_pos[1] + 5,
                    menu_pos[2] + menu_size[2] + panel_offset + 5,
                    15, 15,
                    255, 255, 255, 255
                )
                renderer.rectangle(
                    menu_pos[1] + 4,
                    menu_pos[2] + menu_size[2] + panel_offset + 4,
                    17, 17,
                    0, 0, 0, 100
                )

                renderer.text(
                    menu_pos[1] + 25 + 1,
                    menu_pos[2] + menu_size[2] + panel_offset + 6,
                    0, 0, 0, 100,
                    "", 0, lua_name .. " / " .. script_build
                )
                renderer.text(
                    menu_pos[1] + 25,
                    menu_pos[2] + menu_size[2] + panel_offset + 5,
                    text_color[1], text_color[2], text_color[3], text_color[4],
                    "", 0, lua_name .. " / " .. script_build
                )

                renderer.text(
                    menu_pos[1] + menu_size[1] - 51,
                    menu_pos[2] + menu_size[2] + panel_offset + 6,
                    0, 0, 0, 100,
                    "", 0, time
                )
                renderer.text(
                    menu_pos[1] + menu_size[1] - 50,
                    menu_pos[2] + menu_size[2] + panel_offset + 5,
                    text_color[1], text_color[2], text_color[3], text_color[4],
                    "", 0, time
                )

                renderer.text(
                    menu_pos[1] + menu_size[1] - 351,
                    menu_pos[2] + menu_size[2] + panel_offset + 6,
                    0, 0, 0, 100,
                    my_font, 0
                )
                renderer.text(
                    menu_pos[1] + menu_size[1] - 350,
                    menu_pos[2] + menu_size[2] + panel_offset + 5,
                    text_color[1], text_color[2], text_color[3], text_color[4],
                    my_font, 0
                )
            end
        end
    end


    lerp = function(start, vend, time)
        return start + (vend - start) * time
    end

    current_aspect = 0
    target_aspect = 0

    animation_speed2 = 0.1

    function update_aspect()
        if ui.get(menu.visualsTab.asp) then
            target_aspect = ui.get(menu.visualsTab.asp_v) / 50
        else
            target_aspect = 0
        end
    end

    function animate_aspect()
        current_aspect = lerp(current_aspect, target_aspect, animation_speed2)

        client.set_cvar("r_aspectratio", current_aspect)
    end

    client.set_event_callback("paint", function()
        animate_aspect()
    end)

    ui.set_callback(menu.visualsTab.asp, update_aspect)
    ui.set_callback(menu.visualsTab.asp_v, update_aspect)


    function tpdistance()
        if ui.get(menu.visualsTab.third_) then
            client.exec("cam_idealdist ", ui.get(menu.visualsTab.third_dis))
        else
            client.exec("cam_idealdist ", 100)
        end
    end
    ui.set_callback(menu.visualsTab.third_dis, tpdistance)


    event_callback("aim_fire", function(e)
        wanted_dmg = e.damage
        wanted_hitbox = hitgroup_names[e.hitgroup + 1] or "?"
    end)
    event_callback("aim_hit", function(e)
        if not ui.get(menu.miscTab.console_logs) then return end

        local function color_log(r, g, b, text)
            client.color_log(r, g, b, text .. "\0")
        end

        local who = entity.get_player_name(e.target)
        local group = hitgroup_names[e.hitgroup + 1] or "?"
        local dmg = e.damage
        local health = entity.get_prop(e.target, "m_iHealth")
        local bt = globals.tickcount() - e.tick
        local hc = math.floor(e.hit_chance)

        local r, g, b, a = ui.get(calar)

        local is_alive = health ~= 0
        local prefix = is_alive and "hit" or "killed"
        local color = is_alive and {r, g, b} or {255, 50, 50}

        color_log(color[1], color[2], color[3], "velours ~ ")
        color_log(color[1], color[2], color[3], prefix .. " ")
        color_log(200, 200, 200, who .. " ")
        color_log(color[1], color[2], color[3], "in " .. group .. " ")
        color_log(200, 200, 200, "(" .. dmg .. "dmg) ")

        if is_alive then
            color_log(200, 200, 200, "| " .. health .. "hp ")
        end

        color_log(200, 200, 200, "| bt:" .. bt .. "t ")
        color_log(200, 200, 200, "| hc:" .. hc .. "%\n")
    end)

    event_callback("aim_miss", function(e)
        if not ui.get(menu.miscTab.console_logs) then return end

        local function color_log(r, g, b, text)
            client.color_log(r, g, b, text .. "\0")
        end

        local who = entity.get_player_name(e.target)
        local group = hitgroup_names[e.hitgroup + 1] or "?"
        local reason = e.reason
        local bt = globals.tickcount() - e.tick
        local hc = math.floor(e.hit_chance)

        if reason == "?" then
            if ui.get(menu.miscTab.console_logs_custom_vibor) then
                if ui.get(menu.miscTab.console_logs_resolver) == "resolver" then
                    reason = "resolver"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "kitty :3" then
                    reason = "kitty :3"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "desync" then
                    reason = "desync"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "lagcomp failure" then
                    reason = "lagcomp failure"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "spread" then
                    reason = "spread"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "occlusion" then
                    reason = "occlusion"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "wallshot failure" then
                    reason = "wallshot failure"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "unprediction error" then
                    reason = "unprediction error"
                elseif ui.get(menu.miscTab.console_logs_resolver) == "unregistered shot" then
                    reason = "unregistered shot"
                end
            else
                reason = "?"
            end
        end

        local r, g, b, a = ui.get(calar)

        local highlight_color = {r, g, b}
        if e.reason == "?" then
            highlight_color = {255, 0, 0}
        elseif e.reason == "spread" then
            highlight_color = {255, 0, 0}
        end

        color_log(highlight_color[1], highlight_color[2], highlight_color[3], "velours :3 - ")
        color_log(200, 200, 200, "missed shot to ")
        color_log(highlight_color[1], highlight_color[2], highlight_color[3], who .. " ")
        color_log(200, 200, 200, "in ")
        color_log(highlight_color[1], highlight_color[2], highlight_color[3], group .. " ")
        color_log(200, 200, 200, "due to ")
        color_log(highlight_color[1], highlight_color[2], highlight_color[3], reason .. " ")
        color_log(200, 200, 200, "| bt:" .. bt .. " ")
        color_log(200, 200, 200, "| hc:" .. hc .. "%\n")
    end)

    function aim_hit(e)
        local group = hitgroup_names[e.hitgroup + 1] or "?"


        if ui.get(menu.visualsTab.on_screen_logs) and func.includes(ui.get(menu.visualsTab.on_screen_v), "Hit") then
            notifications.new(string.format("\a75DB67FFHit \aFFFFFFFF%s in the \a75DB67FF%s\aFFFFFFFF for \a75DB67FF%d \aFFFFFFFFdamage (%d remaining)", entity.get_player_name(e.target), group, e.damage, entity.get_prop(e.target, "m_iHealth") ), 255,255,255,255) 
        end
    end

    event_callback("aim_hit", aim_hit)

    function aim_miss(e)
        local aim_fire_data = {}
        local group = hitgroup_names[e.hitgroup + 1] or "?"
        local reason = e.reason
        local hitchance = math.floor(e.hit_chance + 0.5)

        if reason == "?" then
            local custom_reason = ui.get(menu.miscTab.console_logs_resolver)  -- Получаем выбранную опцию из комбобокса
            if custom_reason then
                reason = custom_reason
            end
        end

        -- Отображение уведомления
        if ui.get(menu.visualsTab.on_screen_logs) and func.includes(ui.get(menu.visualsTab.on_screen_v), "Miss") then
            notifications.new(string.format(
                "\aE05C5CFFMissed\aFFFFFFFF shot at %s due to \aE05C5CFF%s (aimed: %s, hc: %i)", 
                entity.get_player_name(e.target), 
                reason,
                group,
                hitchance
            ), 255, 255, 255, 255)
        end
    end

    event_callback("aim_miss", aim_miss)

    lastmiss2 = 0
    last_hurt_time = 0

    event_callback("player_hurt", function(cmd)
        local victim = client.userid_to_entindex(cmd.userid)
        if victim == entity.get_local_player() then
            last_hurt_time = globals.curtime()
        end
    end)

    event_callback("bullet_impact", function(cmd)
        if not entity.is_alive(entity.get_local_player()) then return end
        local ent = client.userid_to_entindex(cmd.userid)
        if ent ~= client.current_threat() then return end
        if entity.is_dormant(ent) or not entity.is_enemy(ent) then return end

        if globals.curtime() - last_hurt_time < 0.5 then return end

        local ent_origin = { entity.get_prop(ent, "m_vecOrigin") }
        ent_origin[3] = ent_origin[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
        local local_head = { entity.hitbox_position(entity.get_local_player(), 0) }
        local closest = GetClosestPoint(ent_origin, { cmd.x, cmd.y, cmd.z }, local_head)
        local delta = { local_head[1]-closest[1], local_head[2]-closest[2] }
        local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)

        if math.abs(delta_2d) <= 80 and globals.curtime() - lastmiss2 > 0.015 then
            if ui.get(menu.visualsTab.on_screen_logs) and func.includes(ui.get(menu.visualsTab.on_screen_v), "Evaded") then
                local evadedplayer = entity.get_player_name(ent)
                notifications.new("\affc0cbFFEvaded\aFFFFFFFF Miss at: \ad8bfd8ff" .. evadedplayer .. "\aFFFFFFFF", 255, 255, 255)
            end
            lastmiss2 = globals.curtime()
            data.stats.evaded = data.stats.evaded + 1
        end
    end)

    event_callback('paint_ui', function ()
        local isAATab = ui.get(tabPicker) == "Anti-aim" and ui.get(aaTabs) == "Settings"
        if isAATab then
            traverse_table_on(binds)
            else
                traverse_table(binds)
        end 
        if (globals.mapname() ~= vars.mapname) then
            vars.breaker.cmd = 0
            vars.breaker.defensive = 0
            vars.breaker.defensive_check = 0
            vars.mapname = globals.mapname()
        end
    end)

    event_callback("round_start", function()
        vars.breaker.cmd = 0
        vars.breaker.defensive = 0
        vars.breaker.defensive_check = 0
    end)

    event_callback("player_connect_full", function(e)
        local ent = client.userid_to_entindex(e.userid)
        if ent == entity.get_local_player() then
            vars.breaker.cmd = 0
            vars.breaker.defensive = 0
            vars.breaker.defensive_check = 0
        end
    end)


    dragging2 = (function()
        local a = {}
        local b, c, d, e, f, g, h, i, j, k, l, m, n, o

        local p = {
            __index = {
                drag = function(self, ...)
                    local q, r = self:get()
                    local s, t = a.drag(q, r, ...)
                    if q ~= s or r ~= t then
                        self:set(s, t)
                    end
                    return s, t
                end,
                set = function(self, q, r)
                    local j, k = client.screen_size()
                    ui.set(self.x_reference, q / j * self.res)
                    ui.set(self.y_reference, r / k * self.res)
                end,
                get = function(self)
                    local j, k = client.screen_size()
                    return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
                end
            }
        }

        function a.new(u, v, w, x)
            x = x or 10000
            local j, k = client.screen_size()
            local y = ui.new_slider('LUA', 'A', u .. ' window position', 0, x, v / j * x)
            local z = ui.new_slider('LUA', 'A', '\n' .. u .. ' window position y', 0, x, w / k * x)
            ui.set_visible(y, false)
            ui.set_visible(z, false)
            return setmetatable({ name = u, x_reference = y, y_reference = z, res = x }, p)
        end

        function a.drag(q, r, A, B, C, D, E)
            if globals.framecount() ~= b then
                c = ui.is_menu_open()
                f, g = d, e
                d, e = ui.mouse_position()
                i = h
                h = client.key_state(0x01) == true
                m = l
                l = {}
                o = n
                n = false
                j, k = client.screen_size()
            end

            if c and i ~= nil then
                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                    n = true
                    q, r = q + d - f, r + e - g
                    if not D then
                        q = math.max(0, math.min(j - A, q))
                        r = math.max(0, math.min(k - B, r))
                    end
                end
            end

            table.insert(l, { q, r, A, B })
            return q, r, A, B
        end

        return a
    end)()


    dragginger = (function()
        local a = {}
        local b, c, d, e, f, g, h, i, j, k, l, m, n, o

        local p = {
            __index = {
                drag = function(self, ...)
                    local q, r = self:get()
                    local s, t = a.drag(q, r, ...)
                    if q ~= s or r ~= t then
                        self:set(s, t)
                    end
                    return s, t
                end,
                set = function(self, q, r)
                    local j, k = client.screen_size()
                    ui.set(self.x_reference, q / j * self.res)
                    ui.set(self.y_reference, r / k * self.res)
                end,
                get = function(self)
                    local j, k = client.screen_size()
                    return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
                end
            }
        }

        function a.new(u, v, w, x)
            x = x or 10000
            local j, k = client.screen_size()
            local y = ui.new_slider('LUA', 'A', u .. ' window position', 0, x, v / j * x)
            local z = ui.new_slider('LUA', 'A', '\n' .. u .. ' window position y', 0, x, w / k * x)
            ui.set_visible(y, false)
            ui.set_visible(z, false)
            return setmetatable({ name = u, x_reference = y, y_reference = z, res = x }, p)
        end

        function a.drag(q, r, A, B, C, D, E)
            if globals.framecount() ~= b then
                c = ui.is_menu_open()
                f, g = d, e
                d, e = ui.mouse_position()
                i = h
                h = client.key_state(0x01) == true
                m = l
                l = {}
                o = n
                n = false
                j, k = client.screen_size()
            end

            if c and i ~= nil then
                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                    n = true
                    q, r = q + d - f, r + e - g
                    if not D then
                        q = math.max(0, math.min(j - A, q))
                        r = math.max(0, math.min(k - B, r))
                    end
                end
            end

            table.insert(l, { q, r, A, B })
            return q, r, A, B
        end

        return a
    end)()


    local panelDragger = dragginger.new("Debug Panel", 200, 200)

    velours.level_system = {
        xp = 0,
        level = 0 
    }

    local level_file = "csgo/cache/level.txt"
    local level_data_file = "csgo/cache/level_data.txt"

    function load_level_data()
        local file_content = readfile(level_data_file)
        if file_content then
            local level, xp = file_content:match("(%d+),(%d+)")
            if level and xp then
                return tonumber(level), tonumber(xp)
            end
        end
        return 0, 0
    end


    local my = {
        entity = entity.get_local_player()
    }

    function d_lerp(a, b, t)
        return a + (b - a) * t
    end

    degree_to_radian = function(degree)
        return (math.pi / 180) * degree
    end

    angle_to_vector = function(x, y)
        local pitch = degree_to_radian(x)
        local yaw = degree_to_radian(y)
        return math.cos(pitch) * math.cos(yaw), math.cos(pitch) * math.sin(yaw), -math.sin(pitch)
    end

    set_movement = function(cmd, desired_pos)
        local local_player = entity.get_local_player()
        local vec_angles = {
            vector(
                entity.get_origin( local_player )
            ):to(
                desired_pos
            ):angles()
        }

        local pitch, yaw = vec_angles[1], vec_angles[2]

        cmd.in_forward = 1
        cmd.in_back = 0
        cmd.in_moveleft = 0
        cmd.in_moveright = 0
        cmd.in_speed = 0
        cmd.forwardmove = 800
        cmd.sidemove = 0
        cmd.move_yaw = yaw
    end


    do_return = function(cmd)
        if bot_data.start_position and bot_data.should_return then
            local lp_origin = vector(entity.get_origin(entity.get_local_player()))
            if bot_data.start_position:dist2d(lp_origin) > 5 then
                if not client.key_state(0x57) and not client.key_state(0x41) and not client.key_state(0x53) and not client.key_state(0x44) and not ui.get(refs.quickPeek[2]) then
                    set_movement( cmd, bot_data.start_position )
                end
            else
                bot_data.should_return = false
                bot_data.shot_fired = false
                bot_data.reached_max_distance = false
            end
        end
    end

    function renderer_trace_positions()
            renderer.indicator(r, g, b, 255, text)
        end


    intersect = function(x, y, w, h)
        local cx, cy = ui.mouse_position()
        return cx >= x and cx <= x + w and cy >= y and cy <= y + h
    end

    checkboxes = function(checkbox_name,checkbox_state,x,y)

        local color = {63,63,63,255}

        if intersect(x,y - 35 + dbs.size,55,10) then

            if client.key_state(0x1) then

                if clicked == false then
                    ui.set(checkbox_state,not ui.get(checkbox_state)) 
                end
                clicked = true
                
            else
                clicked = false
            end
    
        end

        if ui.get(checkbox_state) then
            color = {255,255,255,255}
        else
            color = {24,24,24,255}
        end

        renderer.rectangle(x - 1,y - 35 + dbs.size,8,8,24,24,24,255)
        renderer.rectangle(x, y - 34 + dbs.size,6,6, color[1],color[2],color[3],color[4])
        renderer.text(x + 10, y - 37 + dbs.size,255,255,255,255,"-",0,string.upper(checkbox_name))

        dbs.size = dbs.size + 10
        
    end

    slider_e = function(slider_name,slider_value,min_value,max_value,slider_addition,x,y)

        local slider_text_bool = 0
        if slider_name ~= "" then
            slider_text_bool = 12
        else
            slider_text_bool = 0
        end
    
        
        if slider_name ~= "" then
            renderer.text(x - 1,y- 35 + dbs.size,220,220,220,255,"-",0,string.upper(slider_name))
        end
        local mpos =  vector(ui.mouse_position())


    
        
        

        if intersect(x - 1,y - 36 + dbs.size + slider_text_bool,60,4) then
            slider_data.hovered_another = true
            dbs.should_drag = false
            if client.key_state(0x1) then
                
                ui.set(slider_value, math.max(min_value,math.min(max_value,math.floor(min_value + (max_value - min_value) * ((mpos.x  - (x - 1)) / 60)))))
                slider_data.ref = slider_value

                slider_data.last_item = true
            end
        end

        
        if slider_data.last_item then
            if client.key_state(0x25) then
                if is_math == false or start_timer > 200 then
                    ui.set(slider_data.ref,math.max(min_value,math.min(max_value,ui.get(slider_data.ref) - 1)))
                    if start_timer > 200 then
                        start_timer = 0
                    end 
                end
                start_timer = start_timer + 1
                is_math = true
            elseif  client.key_state(0x27) then
                if is_math == false or start_timer > 200 then
                    ui.set(slider_data.ref,math.max(min_value,math.min(max_value,ui.get(slider_data.ref) + 1)))
                    if start_timer > 200 then
                        start_timer = 0
                    end 
                end
                start_timer = start_timer + 1
                is_math = true
            else
                is_math = false
                start_timer = 0
            end
        end


        local base = (ui.get(slider_value) - min_value) / (max_value - min_value) * 60
    
    
        renderer.rectangle(x,y - 35 + dbs.size + slider_text_bool,60,2,24,24,24,255)
        renderer.rectangle(x,y - 35 + dbs.size + slider_text_bool,base,2,220,220,220,255)
        renderer.circle(x + base, y - 34 + dbs.size + slider_text_bool , 220,220,220,255, 3, 0, 1)
        
    
        
        dbs.size = dbs.size + (slider_name ~= "" and 17 or 12)
    end

    round_rectangle = function(x, y, w, h, r, g, b, a, thickness)
        renderer.rectangle(x, y, w, h, r, g, b, a)
        renderer.circle(x, y, r, g, b, a, thickness, -180, 0.25)
        renderer.circle(x + w, y, r, g, b, a, thickness, 90, 0.25)
        renderer.rectangle(x, y - thickness, w, thickness, r, g, b, a)
        renderer.circle(x + w, y + h, r, g, b, a, thickness, 0, 0.25)
        renderer.circle(x, y + h, r, g, b, a, thickness, -90, 0.25)
        renderer.rectangle(x, y + h, w, thickness, r, g, b, a)
        renderer.rectangle(x - thickness, y, thickness, h, r, g, b, a)
        renderer.rectangle(x + w, y, thickness, h, r, g, b, a)
    end
    function slow_e(w, h)
        if not (ui.get(menu.visualsTab.slow_down)) or not entity.is_alive(entity.get_local_player()) and ui.is_menu_open() or not entity.is_alive(entity.get_local_player()) then
            return 
        end

        local slowdowncolor = { 255, 255, 255, 200 }
        local slow_status = math.floor(entity.get_prop(entity.get_local_player(), "m_flVelocityModifier") * 100)

        if slow_status < 100 and slow_status > 0 then

            
        
            local percentage = slow_status * ui.get(menu.visualsTab.widgets_slow_length) / 100


            if ui.get(menu.extras.icon1) then 
                local add = ui.get(menu.extras.text1) and 16 or 0
                slow_turtle_pos = math.lerp(slow_turtle_pos, w / 2 - 12.5,globals.frametime() * 10)
                renderer.texture(slow_turtle,slow_turtle_pos,dbs.slow_y-30 - add, 25 , 25, 255,255,255,255,"f")
            end

            if func.includes(ui.get(menu.visualsTab.widgets_slow), "Show procents") then 
                renderer.text(dbs.slow_x,dbs.slow_y - 12,255,255,255,255,"c",0,100 - slow_status .. "%")
            end


            renderer.rectangle(dbs.slow_x - ui.get(menu.visualsTab.widgets_slow_length) / 2 - 1,dbs.slow_y - 4,ui.get(menu.visualsTab.widgets_slow_length) + 2, ui.get(menu.visualsTab.widgets_slow_width) + 4,0,0,0,130)
            
        
        

            local slowdowncolor = ui.get(menu.visualsTab.slow_down) and  func.includes(ui.get(menu.visualsTab.widgets_slow), "Dynamic color") and {255 - (slow_status*2),2.55 * slow_status,0,slowdowncolor[4]} or { 255, 255, 255, 255 }
            
            if ui.get(menu.visualsTab.slow_down) and  func.includes(ui.get(menu.visualsTab.widgets_slow), "Blackout") then 
                renderer.gradient(dbs.slow_x - ui.get(menu.visualsTab.widgets_slow_length) / 2 + 1,dbs.slow_y - 2,percentage, ui.get(menu.visualsTab.widgets_slow_width), slowdowncolor[1], slowdowncolor[2], slowdowncolor[3],slowdowncolor[4],12, 12, 12,130,true)
            else
                renderer.rectangle(dbs.slow_x - ui.get(menu.visualsTab.widgets_slow_length) / 2 + 1,dbs.slow_y - 2, percentage, ui.get(menu.visualsTab.widgets_slow_width), slowdowncolor[1], slowdowncolor[2], slowdowncolor[3],255)
            end

            return
        end

        slow_turtle_pos = w / 2 - 110
    end
    function slow_a(w, h)
        if ui.is_menu_open() and (ui.get(menu.visualsTab.slow_down)) then 

            local cx,cy = ui.mouse_position()

            if dbs.is_dragging and not client.key_state(0x01) then 
                dbs.is_dragging = false 
            end
        
            if dbs.is_dragging and client.key_state(0x01) and dbs.last_item == "Slow" then 
                dbs.slow_x = cx - dbs.drag_slow_x
                dbs.slow_y = cy - dbs.drag_slow_y
            end
        
        
            if intersect(dbs.slow_x - ui.get(menu.extras.length) / 2,dbs.slow_y - 10,ui.get(menu.extras.length),20) and client.key_state(0x01) then 
                dbs.last_item = "Slow"
                dbs.is_dragging = true 
                dbs.drag_slow_x = cx - dbs.slow_x
                dbs.drag_slow_y = cy - dbs.slow_y
                dbs.slow_menu = false
                should_shoot = false
            end

            if intersect(dbs.slow_x - ui.get(menu.extras.length) / 2,dbs.slow_y - 10,ui.get(menu.extras.length),20) and client.key_state(0x02) then 
                dbs.slow_menu = true
                dbs.defensive_menu = false
                should_shoot = false
            end

            if ui.get(menu.extras.icon1) then 

                local add = func.includes(ui.get(menu.visualsTab.widgets_slow), "Show procents") and 16 or 0
                renderer.texture(slow_turtle,dbs.slow_x - 25/2,dbs.slow_y-30 - add, 25 , 25, 255,255,255,255,"f")
            end

            if func.includes(ui.get(menu.visualsTab.widgets_slow), "Show procents") then 
                renderer.text(dbs.slow_x,dbs.slow_y - 12,255,255,255,255,"c",0,"100%")
            end
        
            renderer.rectangle(dbs.slow_x - ui.get(menu.visualsTab.widgets_slow_length) / 2 - 1,dbs.slow_y - 4,ui.get(menu.visualsTab.widgets_slow_length) + 2, ui.get(menu.visualsTab.widgets_slow_width) + 4,0,0,0,150)
            
        
        

            local slowdowncolor = { 255, 255, 255, 255 }
            if ui.get(menu.visualsTab.slow_down) and  func.includes(ui.get(menu.visualsTab.widgets_slow), "Blackout")  then 
                renderer.gradient(dbs.slow_x - ui.get(menu.visualsTab.widgets_slow_length) / 2 + 1,dbs.slow_y - 2,ui.get(menu.visualsTab.widgets_slow_length) - 2, ui.get(menu.visualsTab.widgets_slow_width), slowdowncolor[1], slowdowncolor[2], slowdowncolor[3],slowdowncolor[4],12, 12, 12,130,true)
            else
                renderer.rectangle(dbs.slow_x - ui.get(menu.visualsTab.widgets_slow_length) / 2 + 1,dbs.slow_y - 2, ui.get(menu.visualsTab.widgets_slow_length) - 2, ui.get(menu.visualsTab.widgets_slow_width), slowdowncolor[1], slowdowncolor[2], slowdowncolor[3],255)
            end

        else
            dbs.slow_menu = false 
        end

        if dbs.slow_x ~= w/2 and not dbs.is_dragging then 
            dbs.slow_x = math.lerp(dbs.slow_x,w/2,globals.frametime() * 10)
        end
    end

    function slow_c(w, h)
        if ui.is_menu_open() and dbs.slow_menu and (ui.get(menu.visualsTab.slow_down)) then 

            if intersect(dbs.slow_x + 85,dbs.slow_y - 50,82,100) then 
                should_shoot = false
            end

            round_rectangle(dbs.slow_x + 90,dbs.slow_y - 50 , 70, 90 , 24,24,24,100,5)
            renderer.gradient(dbs.slow_x + 90,dbs.slow_y - 40, 35, 1, 24,24,24,0,255,255,255,255, true)
            renderer.gradient(dbs.slow_x + 90 + 35,dbs.slow_y - 40, 35, 1, 255,255,255,255, 24,24,24,0 ,true)
            renderer.text(dbs.slow_x + 90 + 33,dbs.slow_y - 47, 255,255,255,255, "-c", 0, "SETTINGS")


            checkboxes("Text",menu.extras.text1,dbs.slow_x + 90,dbs.slow_y + 3)
            checkboxes("Turtle",menu.extras.icon1,dbs.slow_x + 90,dbs.slow_y + 3)
            checkboxes("Gradient",menu.extras.gradient1,dbs.slow_x + 90,dbs.slow_y + 3)
            checkboxes("Dynamic",menu.extras.dynamic,dbs.slow_x + 90,dbs.slow_y + 3)
            slider_e("length",menu.extras.length1,20,150,"º",dbs.slow_x + 90,dbs.slow_y + 3)
            slider_e("width",menu.extras.width1,1,15,"º",dbs.slow_x + 90 ,dbs.slow_y + 3)
        end
    end

        

    event_callback("bullet_impact", function(e)
        if not ui.get(menu.visualsTab.bul_trace) then
            return
        end
        if client.userid_to_entindex(e.userid) ~= entity.get_local_player() then
            return
        end
        local lx, ly, lz = client.eye_position()
        queue[globals.tickcount()] = {lx, ly, lz, e.x, e.y, e.z, globals.curtime() + ui.get(menu.visualsTab.bul_dur)}
    end)

    function is_grenade(weapon_class)
        return weapon_class == "CBaseCSGrenade" or
            weapon_class == "CDecoyGrenade" or
            weapon_class == "CFlashbang" or
            weapon_class == "CHEGrenade" or
            weapon_class == "CIncendiaryGrenade" or
            weapon_class == "CSmokeGrenade" or
            weapon_class == "CMolotovGrenade"
    end

    local lowammo = renderer.load_svg([[<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg" version="1.1" xml:space="preserve">
    <g>
    <title>Layer 1</title>
    <path class="st0" d="m507.915,23.067c-11.469,-11.484 -138.625,27.094 -178.829,58.907l119.954,119.953c31.813,-40.219 70.375,-167.36 58.875,-178.86z" fill="#ffffff" id="svg_2" stroke="null"/>
    <path class="st0" d="m266.743,143.677l-41.344,10.328l-185.188,185.203l12.047,12.063l-16.359,16.344l-12.063,-12.047l-25.828,25.828l151.594,151.608l25.844,-25.844l-12.063,-12.063l16.359,-16.359l12.063,12.047l185.188,-185.171l10.344,-41.359c0,0 18.703,-18.719 48.25,-48.234l-120.594,-120.579c-29.532,29.5 -48.25,48.235 -48.25,48.235z" fill="#ffffff" id="svg_3" stroke="null"/>
    </g>

    </svg>
    ]])
    low_ammo_icon, low_ammo_warning, alpha, alpha_direction = renderer.load_svg([[
    <svg width="50px" height="50px" viewBox="0 0 50 50" xmlns="http://www.w3.org/2000/svg"><path d="M25 39.7l-.6-.5C11.5 28.7 8 25 8 19c0-5 4-9 9-9 4.1 0 6.4 2.3 8 4.1 1.6-1.8 3.9-4.1 8-4.1 5 0 9 4 9 9 0 6-3.5 9.7-16.4 20.2l-.6.5zM17 12c-3.9 0-7 3.1-7 7 0 5.1 3.2 8.5 15 18.1 11.8-9.6 15-13 15-18.1 0-3.9-3.1-7-7-7-3.5 0-5.4 2.1-6.9 3.8L25 17.1l-1.1-1.3C22.4 14.1 20.5 12 17 12z"/></svg>
    ]]), false, 255, -1

    function renderer.rectangle_outline(x, y, w, h, r, g, b, a, thickness)
        renderer.rectangle(x, y, w, thickness, r, g, b, a)
        renderer.rectangle(x, y + h - thickness, w, thickness, r, g, b, a)
        renderer.rectangle(x, y, thickness, h, r, g, b, a)
        renderer.rectangle(x + w - thickness, y, thickness, h, r, g, b, a)
    end

    function renderer.rounded_rectangle(x, y, w, h, r, g, b, a, radius, filled)
        local side = filled or false

        local data_circle = {
            {x + radius, y, 180},
            {x + w - radius, y, 90},
            {x + radius, y + h - radius * 2, 270},
            {x + w - radius, y + h - radius * 2, 0}
        }

        for _, data in ipairs(data_circle) do
            if data then
                renderer.circle(data[1], data[2], r, g, b, a, radius, data[3], 0.25)
            end
        end

        local data_rect = {
            {x + radius, y, w - radius * 2, h - radius * 2},
            {x + radius, y - radius, w - radius * 2, radius},
            {x + radius, y + h - radius * 2, w - radius * 2, radius},
            {x, y, radius, h - radius * 2},
            {x + w - radius, y, radius, h - radius * 2}
        }

        for _, rect in ipairs(data_rect) do
            if rect then
                renderer.rectangle(rect[1], rect[2], rect[3], rect[4], r, g, b, a)
            end
        end
    end

    client.set_event_callback("paint_ui", function()
        if ui.get(menu.visualsTab.ammo_low) then
            local lp = entity.get_local_player()

            local weapon = entity.get_player_weapon(lp)
            if not weapon then return end

            local weapon_class = entity.get_classname(weapon)

            if weapon_class == "CKnife" or weapon_class == "CWeaponTaser" or is_grenade(weapon_class) or entity.get_classname(entity.get_player_weapon(entity.get_local_player())) == "CC4" then
                return
            end

            local ammo = entity.get_prop(weapon, "m_iClip1")

            local text = "Low Ammo: "
            local r, g, b = 255, 255, 0

            if ammo == 3 then
                r, g, b = 255, 165, 0
            elseif ammo == 2 then
                r, g, b = 255, 0, 0
            elseif ammo == 1 then
                text = "Last ammo!"
                r, g, b = 255, 0, 0
            end

            local low_ammo_warning = ammo <= 4 and ammo > 0

            if not low_ammo_warning then return end

            alpha = alpha + (alpha_direction * 5)
            if alpha <= 50 or alpha >= 255 then
                alpha_direction = -alpha_direction
            end

            local x, y = client.screen_size()

            local icon_x, icon_y = x / 2 - 50, y / 2 - 95
            local text_x, text_y = x / 2, y / 2 - 90

            renderer.texture(low_ammo, icon_x - 2, icon_y, 25, 25, r, g, b, alpha)

            local text_width = renderer.measure_text(nil, ("%s %d"):format(text, ammo))
            local iw, ih = renderer.measure_text(nil, 17)
            local rx, ry, rw, rh = text_x + iw + 12, text_y, text_width, 2

            renderer.rounded_rectangle(text_x, text_y, iw + 11, rh + ih + 5, 21, 21, 21, 255, 5, true)

            renderer.rounded_rectangle(rx - 9, text_y, rw + 16, rh + ih + 5, 18, 18, 18, 150, 5, true)
            renderer.texture(lowammo, text_x + 6, text_y - 1, 25, 25, r, g, b, alpha)
            renderer.text(rx + 2, text_y + 3.5, 255, 255, 255, 255, nil, 0, ("%s %d"):format(text, ammo))

            renderer.rectangle_outline(rx + 1, ry, rw, rh + 2, 0, 0, 0, 255, 1)
            renderer.rectangle(rx + 2, ry + 1, rw - 2, rh, 16, 16, 16, 180)

            local modifier = math.min(ammo / 4, 1)
            renderer.rectangle(rx + 2, ry + 1, math.floor((rw - 3) * modifier), rh, r, g, b, 210)
        end
    end)

    local curtime = globals.curtime
    local unset_event_callback = client.unset_event_callback
    local render_circle_outline, measure_text, render_text, render_rect, render_gradient, render_blur = 
        renderer.circle_outline, renderer.measure_text, renderer.text, renderer.rectangle, renderer.gradient, renderer.blur
    local table_insert = table.insert
    local ui_get = ui.get

    local screen_width, screen_height = client.screen_size()

    local WIDTH = 6
    local HEIGHT = (screen_height / 2) + screen_height / 12
    local TIME_TO_PLANT_BOMB = 3
    local INDICATOR_TEXT_GAP = 36
    local OUTER_CIRCLE_RADIUS = 6
    local OUTER_CIRCLE_THICKNESS = OUTER_CIRCLE_RADIUS / 2
    local INNER_CIRCLE_RADIUS = OUTER_CIRCLE_RADIUS - 1
    local INNER_CIRCLE_THICKNESS = (OUTER_CIRCLE_RADIUS - 1) / 3

    local timeAtBombWillBePlanted
    local isBombBeingPlanted = false
    local indicators = {}

    function lerp(a, b, t)
        return a + (b - a) * t
    end

    function innerCircleOutlinePercentage()
        local timeElapsed = (curtime() + TIME_TO_PLANT_BOMB) - timeAtBombWillBePlanted
        local timeElapsedInPerc = (timeElapsed / TIME_TO_PLANT_BOMB * 100) + 0.5
        return timeElapsedInPerc * 0.01
    end

    function draw_indicators()
        for i = 1, #indicators do
            local indicator = indicators[i]
            local text = indicator.text
            local r, g, b, a = indicator.r, indicator.g, indicator.b, indicator.a

            local textH = HEIGHT + (i * -INDICATOR_TEXT_GAP) + (#indicators * INDICATOR_TEXT_GAP)
            local m_textW, m_textH = measure_text('+b', text)

            render_gradient(WIDTH, textH, m_textW + 40, m_textH + 4, 0, 0, 0, 150, 0, 0, 0, 0, true)
            render_blur(WIDTH, textH, m_textW + 40, m_textH + 4, 5)
            render_rect(WIDTH, textH, 3, m_textH + 4, r, g, b, a)
            render_text(WIDTH + 10, textH + 2, r, g, b, a, '+b', 0, text)

            if isBombBeingPlanted and text:find('Bombsite') then
                local cricleW = WIDTH + m_textW + OUTER_CIRCLE_RADIUS + 4
                local cricleH = textH + (m_textH / 1.71)

                render_circle_outline(cricleW, cricleH, 0, 0, 0, 100, OUTER_CIRCLE_RADIUS, 0, 1.0, OUTER_CIRCLE_THICKNESS)
                render_circle_outline(cricleW, cricleH, 255, 255, 255, 200, INNER_CIRCLE_RADIUS, 0, innerCircleOutlinePercentage(), INNER_CIRCLE_THICKNESS)
            end
        end

        indicators = {}
    end

    client.set_event_callback('bomb_beginplant', function ()
        timeAtBombWillBePlanted = curtime() + TIME_TO_PLANT_BOMB
        isBombBeingPlanted = true
    end)

    client.set_event_callback('bomb_abortplant', function ()
        isBombBeingPlanted = false
    end)

    client.set_event_callback('bomb_planted', function ()
        isBombBeingPlanted = false
    end)

    event_callback("paint_ui", function()
        if ui.get(menu.visualsTab.trace_target) then
        local me = entity.get_local_player()

        local target = client.current_threat()

        if not target then
            return
        end

        local color = {ui.get(menu.visualsTab.trace_color)}
        local to_origin = vector(entity.get_origin(client.current_threat()))
        local origin_to_screen = vector(renderer.world_to_screen(to_origin.x, to_origin.y, to_origin.z))
        local screen_size = vector(client.screen_size())

        if  ((origin_to_screen.x ~= nil) and (origin_to_screen.y ~= nil)) and ((origin_to_screen.x ~= 0) and (origin_to_screen.y ~= 0)) then
            renderer.line(screen_size.x/2, screen_size.y, origin_to_screen.x, origin_to_screen.y, color[1], color[2], color[3], color[4])
        end
    end

    end)
    local tracer = {
        queue = {},
        bullet_impact_f = function(self, e)
            if client.userid_to_entindex(e.userid) ~= entity.get_local_player() then return end
            
            local lx, ly, lz = client.eye_position()
            local duration = ui.get(menu.visualsTab.bul_dur)
    
            local start_r, start_g, start_b = math.random(0, 255), math.random(0, 255), math.random(0, 255)
            local end_r, end_g, end_b = math.random(0, 255), math.random(0, 255), math.random(0, 255)
            self.queue[globals.tickcount()] = {
                lx, ly, lz, e.x, e.y, e.z, globals.curtime() + duration,
                start_r, start_g, start_b, end_r, end_g, end_b
            }
        end,
        render_func = function(self)
            if not ui.get(menu.visualsTab.bul_trace) then return end
    
            for tick, data in pairs(self.queue) do
                if globals.curtime() <= data[7] then
                    local x1, y1 = renderer.world_to_screen(data[1], data[2], data[3])
                    local x2, y2 = renderer.world_to_screen(data[4], data[5], data[6])
    
                    if x1 and x2 and y1 and y2 then
                        local r, g, b
                        local line_width = ui.get(menu.visualsTab.tracers_width)
    
                        if ui.get(menu.visualsTab.rgb_tracers) then
                            local duration = ui.get(menu.visualsTab.bul_dur)
                            local time_left = (data[7] - globals.curtime()) / duration
                            local speed = ui.get(menu.visualsTab.rgb_speed) / 400
                            
                            local progress = 1 - (time_left * speed)

                            r = math.floor(data[8] + (data[11] - data[8]) * progress)
                            g = math.floor(data[9] + (data[12] - data[9]) * progress)
                            b = math.floor(data[10] + (data[13] - data[10]) * progress)
                        else
                            r, g, b = ui.get(menu.visualsTab.bul_color)
                        end
    
                        for i = 1, line_width do
                            renderer.line(x1 + i, y1, x2 + i, y2, r, g, b, 255)
                            renderer.line(x1, y1 + i, x2, y2 + i, r, g, b, 255)
                        end
                    end
                else
                    self.queue[tick] = nil
                end
            end
        end
    }

    client.set_event_callback("bullet_impact", function(e)
        tracer.bullet_impact_f(tracer, e)
    end)
    
    client.set_event_callback("paint", function()
        tracer.render_func(tracer)
    end)

    -- NO WAY START HELL

    smoke_radius_units = 125
    smoke_duration = 17.55
    molotov_duration = 7

    molotovs_temp = {}
    molotovs_cells = {}
    molotovs_created_at = {}

    function distance(x1, y1, x2, y2)
        return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
    end

    function is_molotov_burning(molotov)
        local fire_count = entity.get_prop(molotov, "m_fireCount")
        return fire_count ~= nil and fire_count > 0
    end

    function draw_ground_circle_3d(x, y, z, radius, r, g, b, a, accuracy, width, outline, start_degrees, percentage)
        local accuracy = accuracy ~= nil and accuracy or 3
        local width = width ~= nil and width or 1
        local outline = outline ~= nil and outline or false
        local start_degrees = start_degrees ~= nil and start_degrees or 0
        local percentage = percentage ~= nil and percentage or 1

        local screen_x_line_old, screen_y_line_old
        for rot=start_degrees, percentage*360, accuracy do
            local rot_temp = math.rad(rot)
            local lineX, lineY, lineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z

            local distance = 256

            --local screen_x_line, screen_y_line = renderer_world_to_screen(lineX, lineY, lineZ+distance/2)
            --renderer.text(screen_x_line, screen_y_line-5, 255, 255, 255, 255, "c-", 0, "START")
            --local screen_x_line, screen_y_line = renderer_world_to_screen(lineX, lineY, lineZ-distance/2)
            --renderer.text(screen_x_line, screen_y_line-5, 255, 255, 255, 255, "c-", 0, "END")

            local fraction, entindex_hit = client_trace_line(-1, lineX, lineY, lineZ+distance/2, lineX, lineY, lineZ-distance/2)
            if fraction > 0 and 1 > fraction then
                lineZ = lineZ+distance/2-(distance * fraction)
            end

            local screen_x_line, screen_y_line = renderer.world_to_screen(lineX, lineY, lineZ)
            --renderer.text(screen_x_line, screen_y_line-5, 255, 255, 255, 255, "c-", 0, fraction)
            if screen_x_line ~=nil and screen_x_line_old ~= nil then
                for i=1, width do
                    local i=i-1
                    renderer.line(screen_x_line, screen_y_line-i, screen_x_line_old, screen_y_line_old-i, r, g, b, a)
                end
                if outline then
                    local outline_a = a/255*160
                    renderer.line(screen_x_line, screen_y_line-width, screen_x_line_old, screen_y_line_old-width, 16, 16, 16, outline_a)
                    renderer.line(screen_x_line, screen_y_line+1, screen_x_line_old, screen_y_line_old+1, 16, 16, 16, outline_a)
                end
            end
            screen_x_line_old, screen_y_line_old = screen_x_line, screen_y_line
        end
    end

    function draw_circle_3d(x, y, z, radius, r, g, b, a, accuracy, width, outline, start_degrees, percentage)
        local accuracy = accuracy ~= nil and accuracy or 3
        local width = width ~= nil and width or 1
        local outline = outline ~= nil and outline or false
        local start_degrees = start_degrees ~= nil and start_degrees or 0
        local percentage = percentage ~= nil and percentage or 1

        local screen_x_line_old, screen_y_line_old
        for rot=start_degrees, percentage*360, accuracy do
            local rot_temp = math.rad(rot)
            local lineX, lineY, lineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
            local screen_x_line, screen_y_line = renderer.world_to_screen(lineX, lineY, lineZ)
            if screen_x_line ~=nil and screen_x_line_old ~= nil then
                for i=1, width do
                    local i=i-1
                    renderer.line(screen_x_line, screen_y_line-i, screen_x_line_old, screen_y_line_old-i, r, g, b, a)
                end
                if outline then
                    local outline_a = a/255*160
                    renderer.line(screen_x_line, screen_y_line-width, screen_x_line_old, screen_y_line_old-width, 16, 16, 16, outline_a)
                    renderer.line(screen_x_line, screen_y_line+1, screen_x_line_old, screen_y_line_old+1, 16, 16, 16, outline_a)
                end
            end
            screen_x_line_old, screen_y_line_old = screen_x_line, screen_y_line
        end
    end

    function lerp(a, b, percentage)
        return b + (b - a) * percentage
    end

    function lerp_pos(x1, y1, z1, x2, y2, z2, percentage)
        local x = (x2 - x1) * percentage + x1
        local y = (y2 - y1) * percentage + y1
        local z = (z2 - z1) * percentage + z1
        return x, y, z
    end

    function on_run_command(e)
        if not ui.get(menu.visualsTab.molotov_radius) then
            return
        end

        entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_is_dormant, entity_get_steam64, entity_get_player_name, entity_hitbox_position, entity_get_game_rules, entity_get_all = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.is_dormant, entity.get_steam64, entity.get_player_name, entity.hitbox_position, entity.get_game_rules, entity.get_all 
        --reset everything, get molotovs
        molotovs_temp = {}
        molotovs_cells = {}
        molotovs = entity_get_all("CInferno")

        if #molotovs == 0 then
            return
        end

        local curtime = globals.curtime()

        for i=1, #molotovs do
            local molotov = molotovs[i]
            if is_molotov_burning(molotov) then
                local origin_x, origin_y, origin_z = entity.get_prop(molotov, "m_vecOrigin")

                local cell_radius = 40
                local molotov_radius = 0
                local center_x, center_y, center_z

                local cells = {}
                local cells_checked = {}
                local highest_distance = 0
                local cell_max_1, cell_max_2

                --accumulate burning cells
                for i=1, 64 do
                    if entity.get_prop(molotov, "m_bFireIsBurning", i) == 1 then
                        local x_delta = entity.get_prop(molotov, "m_fireXDelta", i)
                        local y_delta = entity.get_prop(molotov, "m_fireYDelta", i)
                        local z_delta = entity.get_prop(molotov, "m_fireZDelta", i)
                        table_insert(cells, {x_delta, y_delta, z_delta})
                    end
                end

                for i=1, #cells do
                    local cell = cells[i]
                    local x_delta, y_delta, z_delta = unpack(cell)

                    for i2=1, #cells do
                        local cell2 = cells[i2]
                        local distance = distance(x_delta, y_delta, cell2[1], cell2[2])
                        if distance > highest_distance then
                            highest_distance = distance
                            cell_max_1 = cell
                            cell_max_2 = cell2
                        end
                    end
                end

                if cell_max_1 ~= nil and cell_max_2 ~= nil then
                    local x1, y1, z1 = origin_x+cell_max_1[1], origin_y+cell_max_1[2], origin_z+cell_max_1[3]
                    local x2, y2, z2 = origin_x+cell_max_2[1], origin_y+cell_max_2[2], origin_z+cell_max_2[3]

                    local center_x_delta, center_y_delta, center_z_delta = lerp_pos(cell_max_1[1], cell_max_1[2], cell_max_1[3], cell_max_2[1], cell_max_2[2], cell_max_2[3], 0.5)
                    local center_x, center_y, center_z = origin_x+center_x_delta, origin_y+center_y_delta, origin_z+center_z_delta
                    
                    local radius = highest_distance/2+cell_radius

                    molotovs_temp[molotov] = {center_x, center_y, center_z, radius}
                    molotovs_cells[molotov] = cells
                end
            end
        end
    end
    client.set_event_callback("run_command", on_run_command)

    function on_paint()

        local_player = entity.get_local_player()

        --make everything work while we're dead, dont really need to care about performance
        if local_player == nil or not entity.is_alive(local_player) or entity.get_prop(local_player, "m_MoveType") == MOVETYPE_NOCLIP then
            on_run_command()
        end

        if ui.get(menu.visualsTab.molotov_radius) then
            local r, g, b, a = ui.get(menu.visualsTab.molotov_radius_reference)
            for i=1, #molotovs do
                molotov = molotovs[i]
                if molotovs_temp[molotov] ~= nil then
                    local center_x, center_y, center_z, radius = unpack(molotovs_temp[molotov])
                    local a_multiplier = 1

                    if molotovs_created_at[grenade] ~= nil then
                        local time_since_created = curtime - molotovs_created_at[grenade]
                        a_multiplier = math_max(0, 1 - time_since_created / molotov_duration)
                    end
                    draw_circle_3d(center_x, center_y, center_z, radius, r, g, b, a*a_multiplier, 9, 1, true)
                end
            end
        end

        if ui.get(menu.visualsTab.smoke_radius) then
            local r, g, b, a = ui.get(menu.visualsTab.smoke_radius_reference)
            grenades = entity.get_all("CSmokeGrenadeProjectile")
            local tickcount = globals.tickcount()
            tickinterval = globals.tickinterval()
            curtime = globals.curtime()

            for i = 1, #grenades do
                local grenade = grenades[i]
                local x, y, z = entity.get_prop(grenade, "m_vecOrigin")
                local wx, wy = renderer.world_to_screen(x, y, z)

                if wx ~= nil then
                    local did_smoke_effect = entity.get_prop(grenade, "m_bDidSmokeEffect") == 1

                    if did_smoke_effect then
                        local ticks_created = entity.get_prop(grenade, "m_nSmokeEffectTickBegin")
                        if ticks_created ~= nil then
                            local time_since_explosion = tickinterval * (tickcount - ticks_created)
                            if time_since_explosion > 0 and smoke_duration - time_since_explosion > 0 then
                                local radius = smoke_radius_units

                                if 0.3 > time_since_explosion then
                                    radius = radius * 0.6 + (radius * (time_since_explosion / 0.3)) * 0.4
                                    a = a * (time_since_explosion / 0.3)
                                end

                                if 1.0 > smoke_duration - time_since_explosion then
                                    radius = radius * (((smoke_duration - time_since_explosion) / 1.0) * 0.3 + 0.7)
                                end

                                draw_circle_3d(x, y, z, radius, r, g, b, a, 9, 1, true)
                            end
                        end
                    end
                end 
            end
        end
    end

    client.set_event_callback("paint", on_paint)

    -- HELL THIS FAUAWJHFEJ

    local original_angles = nil

    local function on_paint(c)
        if ui.get(menu.miscTab.auto_smoke) and ui.get(menu.miscTab.auto_smoke_bind) then
            if not ui.get(menu.miscTab.auto_smoke_cam) then
                if not original_angles then
                    original_angles = { client.camera_angles() }
                end
            end


            client.exec("use weapon_smokegrenade")
            client.delay_call(0.3, function()
                client.camera_angles(90, 0)
                client.delay_call(0.35, function()
                    client.exec("+attack2")
                    client.delay_call(0.30, function()
                        client.exec("-attack2")
                        client.delay_call(0.7, function()
                            client.exec("slot2")
                            client.exec("slot1")

                            if not ui.get(menu.miscTab.auto_smoke_cam) then
                                if original_angles then
                                    client.camera_angles(original_angles[1], original_angles[2])
                                    original_angles = nil
                                end
                            end
                        end)
                    end)
                end)
            end)
        end
    end

    event_callback("paint", on_paint)

local thirdperson = {ui.reference("Visuals", "Effects", "Force third person (alive)")}

function hsv_to_rgb(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r * 255, g * 255, b * 255
end

renderer_triangle = function(v2_A, v2_B, v2_C, r, g, b, a)
    local function i(j, k, l)
        local m = (k.y - j.y) * (l.x - k.x) - (k.x - j.x) * (l.y - k.y)
        if m < 0 then return true end
        return false
    end
    if i(v2_A, v2_B, v2_C) then renderer.triangle(v2_A.x, v2_A.y, v2_B.x, v2_B.y, v2_C.x, v2_C.y, r, g, b, a)
    elseif i(v2_A, v2_C, v2_B) then renderer.triangle(v2_A.x, v2_A.y, v2_C.x, v2_C.y, v2_B.x, v2_B.y, r, g, b, a)
    elseif i(v2_B, v2_C, v2_A) then renderer.triangle(v2_B.x, v2_B.y, v2_C.x, v2_C.y, v2_A.x, v2_A.y, r, g, b, a)
    elseif i(v2_B, v2_A, v2_C) then renderer.triangle(v2_B.x, v2_B.y, v2_A.x, v2_A.y, v2_C.x, v2_C.y, r, g, b, a)
    elseif i(v2_C, v2_A, v2_B) then renderer.triangle(v2_C.x, v2_C.y, v2_A.x, v2_A.y, v2_B.x, v2_B.y, r, g, b, a)
    else renderer.triangle(v2_C.x, v2_C.y, v2_B.x, v2_B.y, v2_A.x, v2_A.y, r, g, b, a)
    end
end

function nimbus_world_circle(origin, size)
    if origin[1] == nil then
        return
    end

    local last_point = nil
    local color_g = {ui.get(menu.miscTab.colorchinareal)}

    for i = 0, 360, 5 do
        local new_point = {
            origin[1] - (math.sin(math.rad(i)) * size),
            origin[2] - (math.cos(math.rad(i)) * size),
            origin[3]
        }

        local actual_color = color_g
        local gradient_g = ui.get(menu.miscTab.gradientchina)

        if (gradient_g) then
            local hue_offset = 0

            hue_offset = ((globals.realtime() * (ui.get(menu.miscTab.speedchina) * 50)) + i) % 360
            hue_offset = math.min(360, math.max(0, hue_offset))

            local r, g, b = hsv_to_rgb(hue_offset / 360, 1, 1)

            color_g = {r, g, b, 255}
        end

        if last_point ~= nil then
            local old_screen_point = {renderer.world_to_screen(last_point[1], last_point[2], last_point[3])}
            local new_screen_point = {renderer.world_to_screen(new_point[1], new_point[2], new_point[3])}

            if old_screen_point[1] and new_screen_point[1] then
                renderer.line(old_screen_point[1], old_screen_point[2], new_screen_point[1], new_screen_point[2], color_g[1], color_g[2], color_g[3], 255)
            end
        end

        last_point = new_point
    end
end

client.set_event_callback("paint_ui", function()
    local hat_selection = ui.get(menu.miscTab.enablechina)

    if hat_selection == "None" or hat_selection ~= "Nimbus" then 
        return 
    end

    if not master_state or (not ui.get(thirdperson[1]) or not ui.get(thirdperson[2])) or lp() == nil or entity.is_alive(lp()) == false then
        return
    end


    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then
        return
    end

    local head_pos = {entity.hitbox_position(lp, 0)}

    head_pos[3] = head_pos[3] + 5
    nimbus_world_circle(head_pos, 10)
end)

-- конец нимба

-- чайна хат

local thirdperson = {ui.reference("Visuals", "Effects", "Force third person (alive)")}

lp = entity.get_local_player


function hsv_to_rgb(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r * 255, g * 255, b * 255
end

renderer_triangle = function(v2_A, v2_B, v2_C, r, g, b, a)
    local function i(j, k, l)
        local m = (k.y - j.y) * (l.x - k.x) - (k.x - j.x) * (l.y - k.y)
        if m < 0 then return true end
        return false
    end
    if i(v2_A, v2_B, v2_C) then renderer.triangle(v2_A.x, v2_A.y, v2_B.x, v2_B.y, v2_C.x, v2_C.y, r, g, b, a)
    elseif i(v2_A, v2_C, v2_B) then renderer.triangle(v2_A.x, v2_A.y, v2_C.x, v2_C.y, v2_B.x, v2_B.y, r, g, b, a)
    elseif i(v2_B, v2_C, v2_A) then renderer.triangle(v2_B.x, v2_B.y, v2_C.x, v2_C.y, v2_A.x, v2_A.y, r, g, b, a)
    elseif i(v2_B, v2_A, v2_C) then renderer.triangle(v2_B.x, v2_B.y, v2_A.x, v2_A.y, v2_C.x, v2_C.y, r, g, b, a)
    elseif i(v2_C, v2_A, v2_B) then renderer.triangle(v2_C.x, v2_C.y, v2_A.x, v2_A.y, v2_B.x, v2_B.y, r, g, b, a)
    else renderer.triangle(v2_C.x, v2_C.y, v2_B.x, v2_B.y, v2_A.x, v2_A.y, r, g, b, a)
    end
end

function world_circle(origin, size)
    if origin[1] == nil then
        return
    end

    local last_point = nil
    local color_g = {ui.get(menu.miscTab.colorchinareal)}

    for i = 0, 360, 5 do
        local new_point = { --Rotate point
            origin[1] - (math.sin(math.rad(i)) * size),
            origin[2] - (math.cos(math.rad(i)) * size),
            origin[3]
        }

        local actual_color = color_g
        local gradient_g = ui.get(menu.miscTab.gradientchina)

        if (gradient_g) then
            local hue_offset = 0

            hue_offset = ((globals.realtime() * (ui.get(menu.miscTab.speedchina) * 50)) + i) % 360
            hue_offset = math.min(360, math.max(0, hue_offset))

            local r, g, b = hsv_to_rgb(hue_offset / 360, 1, 1)

            color_g = {r, g, b, 255}
        end

        if last_point ~= nil then
            local old_screen_point = {renderer.world_to_screen(last_point[1], last_point[2], last_point[3])}
            local new_screen_point = {renderer.world_to_screen(new_point[1], new_point[2], new_point[3])}
            local origin_screen_point = {renderer.world_to_screen(origin[1], origin[2], origin[3] + 8)}

            if old_screen_point[1] ~= nil and new_screen_point[1] ~= nil and origin_screen_point[1] ~= nil then
                renderer_triangle({x = old_screen_point[1], y = old_screen_point[2]}, {x = new_screen_point[1], y = new_screen_point[2]}, {x = origin_screen_point[1], y = origin_screen_point[2]}, color_g[1], color_g[2], color_g[3], 50)     
                renderer.line(old_screen_point[1], old_screen_point[2], new_screen_point[1], new_screen_point[2], color_g[1], color_g[2], color_g[3], 255)
            end
        end

        --Update
        last_point = new_point
    end
end

client.set_event_callback("paint_ui", function()
    local hat_selection = ui.get(menu.miscTab.enablechina)

    if hat_selection == "None" or hat_selection ~= "China" then 
        return 
    end

    if (not ui.get(thirdperson[1]) or not ui.get(thirdperson[2])) or lp() == nil or entity.is_alive(lp()) == false then
        return
    end

    
    world_circle({entity.hitbox_position(lp(), 0)}, 10)
end)

function hidechat()
    if ui.get(menu.miscTab.hidechatbox) then
        cvar.cl_chatfilters:set_int(0)
    else
        cvar.cl_chatfilters:set_int(63)
    end 
end

function onshutdown()
    cvar.cl_chatfilters:set_int(63)
end

client.set_event_callback("run_command", hidechat)

materials = {
    "vgui_white",
    "vgui/hud/800corner1",
    "vgui/hud/800corner2",
    "vgui/hud/800corner3",
    "vgui/hud/800corner4"
}

ui.set_callback(menu.miscTab.vgui_color, function()
    updated = false

    local r, g, b, a = ui.get(menu.miscTab.vgui_color)

    for _, mat in pairs(materials) do
        local material = materialsystem.find_material(mat, true)

        if not material then return false end
        material:alpha_modulate(a)
        material:color_modulate(r, g, b)
    end

    updated = true
end)

ui.set_callback(menu.miscTab.vgui_color_checkbox, function()
    if updated then return false end
    local r, g, b, a = ui.get(menu.miscTab.vgui_color)

    for _, mat in pairs(materials) do
        local material = materialsystem.find_material(mat, true)

        if not material then return false end
        material:alpha_modulate(a)
        material:color_modulate(r, g, b)
    end

    updated = true
end)

snowflakes = {}

function create_snowflake()
    return {
        x = math.random(0, client.screen_size()),
        y = math.random(-50, 0),
        size = math.random(2, 5),
        speed = math.random(ui.get(menu.visualsTab.snowflake_speed))
    }
end

function initialize_snowflakes()
    snowflakes = {}
    for i = 1, ui.get(menu.visualsTab.snowflake_count) do
        table.insert(snowflakes, create_snowflake())
    end
end

function update_snowflakes()
    if not ui.get(menu.visualsTab.snowball) then return end

    for i, snowflake in ipairs(snowflakes) do
        if ui.get(menu.visualsTab.animates_left_down) then
            snowflake.x = snowflake.x - snowflake.speed * 0.5
            snowflake.y = snowflake.y + snowflake.speed
        else
            snowflake.y = snowflake.y + snowflake.speed
        end

        if snowflake.y > client.screen_size() or snowflake.x < 0 then
            snowflakes[i] = create_snowflake()
        end
    end
end


function render_snowflakes()
    if not ui.get(menu.visualsTab.snowball) then return end

    for _, flake in ipairs(snowflakes) do
        renderer.rectangle(flake.x, flake.y, flake.size, flake.size, 255, 255, 255, 255)
    end
end

client.set_event_callback("paint", function()
    update_snowflakes()
    render_snowflakes()
end)

ui.set_callback(menu.visualsTab.snowflake_count, initialize_snowflakes)
ui.set_callback(menu.visualsTab.snowflake_speed, initialize_snowflakes)
ui.set_callback(menu.visualsTab.snowball, function()
    if ui.get(menu.visualsTab.snowball) then
        initialize_snowflakes()
    end
end)

fireballs = {}

function create_fireball()
    return {
        x = math.random(0, client.screen_size()),
        y = math.random(-50, 0),
        size = math.random(2, 5),
        speed = math.random(ui.get(menu.visualsTab.fireball_speed))
    }
end

function initialize_fireballs()
    fireballs = {}
    for i = 1, ui.get(menu.visualsTab.fireball_count) do
        table.insert(fireballs, create_fireball())
    end
end

function update_fireballs()
    if not ui.get(menu.visualsTab.fireball) then return end

    for i, fireball in ipairs(fireballs) do
        if ui.get(menu.visualsTab.animate_left_down) then
            fireball.x = fireball.x - fireball.speed * 0.5
            fireball.y = fireball.y + fireball.speed
        else
            fireball.y = fireball.y + fireball.speed
        end

        if fireball.y > client.screen_size() or fireball.x < 0 then
            fireballs[i] = create_fireball()
        end
    end
end


function render_fireballs()
    if not ui.get(menu.visualsTab.fireball) then return end

    for _, flake in ipairs(fireballs) do
        renderer.rectangle(flake.x, flake.y, flake.size, flake.size, 255, 69, 0, 255)
    end
end

client.set_event_callback("paint", function()
    update_fireballs()
    render_fireballs()
end)

ui.set_callback(menu.visualsTab.fireball_count, initialize_fireballs)
ui.set_callback(menu.visualsTab.fireball_speed, initialize_fireballs)
ui.set_callback(menu.visualsTab.fireball, function()
    if ui.get(menu.visualsTab.fireball) then
        initialize_fireballs()
    end
end)

function update_checkboxes()
    if ui.get(menu.visualsTab.fireball) then
        ui.set(menu.visualsTab.snowball, false)
        ui.set_visible(menu.visualsTab.snowball, true)
        ui.set_enabled(menu.visualsTab.snowball, false)
    elseif ui.get(menu.visualsTab.snowball) then
        ui.set(menu.visualsTab.fireball, false)
        ui.set_visible(menu.visualsTab.fireball, true)
        ui.set_enabled(menu.visualsTab.fireball, false)
    else
        ui.set_enabled(menu.visualsTab.fireball, true)
        ui.set_enabled(menu.visualsTab.snowball, true)
    end
end

ui.set_callback(menu.visualsTab.fireball, function()
    update_checkboxes()
end)

ui.set_callback(menu.visualsTab.snowball, function()
    update_checkboxes()
end)

update_checkboxes()

isWaitingForSelection = false

ui.set_callback(menu.miscTab.settingsmatchqwe, function()
    if isWaitingForSelection then
        local selected = ui.get(menu.miscTab.settingsmatchqwe)
        if selected == "Test CFG" then
            client.exec([[
                sv_cheats 1;
                sv_regeneration_force_on 1;
                mp_limitteams 0;
                mp_autoteambalance 0;
                mp_roundtime 60;
                mp_roundtime_defuse 60;
                mp_maxmoney 60000;
                mp_startmoney 60000;
                mp_freezetime 0;
                mp_buytime 9999;
                mp_buy_anywhere 1;
                sv_infinite_ammo 1;
                ammo_grenade_limit_total 5;
                bot_kick;
                bot_stop 1;
                mp_warmup_end;
                mp_restartgame 1;
                mp_respawn_on_death_ct 1;
                mp_respawn_on_death_t 1;
                sv_airaccelerate 100;
            ]])
        end
        isWaitingForSelection = false
    end
end)

ui.set_callback(menu.miscTab.settingsmatch, function()
    local isChecked = ui.get(menu.miscTab.settingsmatch)
    
    if isChecked then
        isWaitingForSelection = true
    else
        isWaitingForSelection = false
    end
end)

is_dropping = false

client.set_event_callback("setup_command", function(cmd)
    if not ui.get(menu.miscTab.drop_grenades_helper) or not ui.get(menu.miscTab.drop_grenades_hotkey) then return end
    
    if is_dropping then return end

    is_dropping = true

    client.exec("slot4")
    client.delay_call(0.2, function()
        client.exec("drop")
        client.delay_call(0.5, function()
            is_dropping = false
        end)
    end)
end)

local killsay_normal = {
    "1 пидорасина ебаная спи",
    "круто вчера туалет помыла шлюха",
    "игрок?",
    "парашыч ебаный",
    "1 животно ебаное ",
    "оттарабанен 100 сантиметровым фалосом",
    "обоссан",
    "by SANCHEZj hvh boss",
    "але уебище химера яв гетни потом вырыгивай что то",
    "ебать ты на хуек присел нихуева",
    "заглотнул коки яки",
    "в сон нахуй",
    "уебашил дилдом по ебалу",
    "сбил пидораса обоссаного",
    "глотай овца",
    "трахнут",
    "поспи хуйсоска",
    "лови припиздок немощный",
    "слишком сочный для velours lua",
    "sleep",
    "изи упал нищий",
    "посажен на хуй",
    "GLhf.exe Activated",
    "what you do dog??",
    "!medic НЮХАЙ БЭБРУ я полечился",
    "1 week lou doggo ovnet",
    "l2p bot",
    "why you sleep dog???",
    "лови тапыча мусор",
    "1 мусор учись играть",
    "$$$ 1 TAP UFF YA $$$ ∩ ( ͡⚆ ͜ʖ ͡⚆) ∩",
    "че, пососал глупый даун?",
    "я ķ¤нɥåλ ϯβ¤£ü ɱåɱķ£ β Ƥ¤ϯ",
    "улетаешь со своего ванвея хуесос",
    "0 iq",
    "сразу видно кфг иссуе мб конфиг у меня прикупишь ?",
    "iq ? HAHAHA",
    "Best and cheap configurations for gamesense, ot and neverlose waiting for your order  at ---> vk.com/id498406374",
    "ХАХАХАХАХХАХА НИЩИЙ УЛЕТЕЛ (◣_◢)",
    "земля те землей хуйло чиста еденицей отлетел))",
    "Создатель JS REZOLVER"
}

local killsay_ad = {
    "Got rekt by velours.lua",
    "Don't be a pussy go and buy velours.lua",
    "1 by velours.lua",
    "Just get velours.lua already, TG: velourscsgo",
    "Stop using a PASTE, go and buy velours.lua",
    "NN Blasted by velours.lua",
    "You won't kill me because I use velours.lua",
    "$$$ OwNeD By velours.lua $$$",
    "Don't be a piece of shit just get velours.lua",
    "Too ez for velours.lua"
}

revenge_list = {
    "1"
}

simple_1 = {
    "1"
}

killsay_pharases = {
    {'⠀1', 'nice iq'},
    {'cgb gblfhfc', 'спи пидорас'},
    {'пздц', 'игрок'},
    {'1 моча', 'изи'},
    {'куда ты', 'сынок ебаный'},
    {'найс аа хуесос', 'долго делал?'},
    {'ебать что', 'как я убил ахуеть'},
    {'over all pidoras'},
    {'nice iq', 'churka)'},
    {'1 чмо', 'нищий без велоурс'},
    {'лол', 'как же я тебя выебал'},
    {'че за луашку юзаешь'},
    {'чей кфг юзаешь'},
    {'найс айкью', 'хуесос'},
    {']f]f]f]f]f]f]', 'хахахаха'},
    {'jq ,kz', 'ой бля', 'найс кфг уебище'},
    {'jq', 'я в афк чит настраивал хаха'},
    {'какой же у тебя сочный ник'},
    {'хуйсос анимешный', 'думал не убью тебя?)'},
    {'моча ебаная', 'кого ты пытаешься убить'},
    {'mad cuz bad?', 'hhhhhh retardw'},
    {'учись пока я жив долбаеб'},
    {'еблан', 'включи монитор'},
    {'1', 'опять умер моча'},
    {'egc', 'упссс', 'сорри'},
    {'хахаха ебать я тебя трахнул'},
    {'nice iq', 'u sell'},
    {'изи шлюха', 'че в хуй?'},
    {'получай тварь ебаная', 'фу нахуй'},
    {']f]f]f]f]f]]f]f', 'как же мне похуй долбаеб'},
    {'изи моча', 'я ору с тебя какой же ты сочный'},
    {'ez owned', 'weak dog + rat'},
    {'пиздец ты легкий ботик'},
    {'1', 'не отвечаю?', 'мне похуй'},
    {'как же мне похуй', 'ботик'},
    {'retard', 'just fucking bot'},
    {'♕ V E L O U R S > A L L ♕'},
    {'нюхай пятку сын шаболды ёбаной','сосешь хуже мегионских цыпочек'},
    {'омг nice small pisunchik','ты нихуя не ледженд'},
    {'OWNED, сын шлюхи ёбаной','позволь моей писечке исследовать недры шахты твоей матери'},
    {'целуй писичку fucking no legend','твоя писичка такая же маленькая как и iqshe4ka'},
    {'в следущей раз выйграешь ледженда','Are you legend? ','ВЫ ТАКОЙ ЖЕ ТАНЦОР КАК ЛЯСТИЧКИ NOLEGENDICKI'},
    {'Твоя мать такая же жирная как idle nolegend (140)','накончал на твою лысинку она как у батька шамелисика'},
    {'твоя мамаша приготовила мне вкусные бутербродики как у gachi nolegend','ты очень хорошо лижешь пяточки научи клокедика legendicka'},
    {'шлюха ебаная так же сдохла как бабка фиппа и маута','сын шлюхи у тебя такие же компьютерики как у vanino nolegend'},
    {'твоя мамаша лижет мороженное ой блять это же моя писечка','у твоей матери такая же узкая пизда как глаза d4ssh legend'},
    {'ты такой же ебаный пес как  l4fn nolegend','мда играешь ты конечно хуево не то что virtual legendick'},
    {'разбомбил тебе ебасосину как бомбят walper nolegend','ты никогда не будешь legend с такой small pise4ka'},
    {'пока ты сосешь хуй мы чилим на острове legendickov','шлюха ебаная так же сдохла как бабка фиппа и маута'},
    {'хочешь купить config by legendick? ПОШЕЛ НАХУЙ СЫН ШЛЮХИ ЁБАНОЙ','ЭХХХ КАК ЖЕ АХУЕННО СОСЕТ ТВОЯ МАМАША МОЙ PISUN4IK'},
    {'e1','рандерандерандеву твоя мать шлюха сосала наяву','пузо твоей матери шлюхи такое же большое как у shirazu nolegend'},
}
    
death_say = {
    {'ну фу', 'хуесос'},
    {'что ты делаешь', 'моча умалишенная'},
    {'бля', 'я стрелял вообще чи шо?'},
    {'чит подвел'},
    {'БЛЯЯЯЯЯЯЯЯЯЯЯЯТЬ', 'как же ты меня заебал'},
    {'ну и зачем', 'дал бы клип', 'пиздец клоун'},
    {'ахахахах', 'ну да', 'опять сын шлюхи убил бестолковый'},
    {'м', 'пон)', 'найс чит'},
    {'да блять', 'какой джиттер поставить сука'},
    {'ну фу', 'ублюдок', 'ебаный'},
    {'да сука', 'где тимейты блять', 'как же сука они меня бесят'},
    {'lf ,kznm', 'да блять', 'опять я мисснул'},
    {'да блять', 'ало', 'я вообще стрелять буду нет'},
    {'хех', 'ты сам то хоть понял', 'как меня убил'},
    {'сука', 'опять по дезу ебаному'},
    {'бля', 'клиентнуло', 'лаки'},
    {'понятно', 'ик ак ты так играешь', 'еблан бестолковый'},
    {'ну блять', 'он просто пошел', 'пиздец'},
    {'&', 'и че это', 'откуда ты меня убил?'},
    {'тварь', 'ебаная', 'ЧТО ТЫ ДЕЛАЕШЬ'},
    {'YE LF', 'ну да', 'хуесос', 'норм играешь'},
    {'сочник ебаный', 'как же ты меня заебал уже', 'что ты делаешь'},
    {'хуевый без скита', 'как ты меня убиваешь с пастой своей'},
    {'подпивас ебаный', 'как же ты меня переиграл'},
    {'бля', 'признаю, переиграл'},
    {'как ты меня убиваешь', 'ебаный owosh'},
    {'дефектус че ты делаешь', 'пиздец'},
    {'хуйсосик анимешный', 'как ты убиваешь', 'эт пздц'},
    {'бля ну бро', 'посмотри на мою команду', 'это пзиидец'},
    {'ммм', 'хуесосы бездарные в команде'},
    {'ik.[f', 'шлюха пошла нахуй'},
    {'ndfhm t,fyfz', 'тварь ебаная как же ты меня бесишь'},
    {'фу нахуй', 'опять в бекшут'},
    {'только так и умеешь да?', 'блядь ебаная'},
    {'нахуй ты меня трешкаешь', 'шлюха ебаная'},
    {'ну повезло тебе', 'дальше то что хуесос'},
    {'ебанная ты мразь', 'которая мне все проебала'},
    {'ujcgjlb', 'господи', 'мразь убогая'},
    {'хахахах', 'ну бля заебись фристенд в чите)'},
    {'фу ты заебал конч'},
    {')', 'хорош)'},
    {'норм трекаешь', 'ублюдина'},
    {'а че', 'хайдшоты на фд уже не работают?'},
    {'всмысле', 'ты же ебучий иван золо', 'ты как играть научился?'}
}

miss_words = {
    "как я промазал с позором",
    "боже я опять мисснул",
    "НУ ЕБАННАЯ ПАСТА ОПЯТЬ МИСАЕТ СУКА",
    "заебусь в тебя долбоеба мисать",
    "я опять миснул? это значит ты облизал мои яйца",
    "повезет же тебе жирному",
    "свиноблядь в следующий раз я тебе еблет снесу",
    "бля, снова в хохла мисснул",
    "VELOURS FUCKING LEGEND AGAIN MISSED? NOOO",
    "сука я щас просто возьму и депну твою родню в казик",
    "я тебе щас нос в голову вобью, хочешь?",
    "ты настолько беден как адам, что в тебя чит мисснул позорище",
    "засраный хуедав моржовый ты хули прыгаешь как на члене?",
    "хех... опять мисс",
    "это пиздец ты настолько уебан тупой что в тебя чит не хочет стрелять, 1",
    "мразь ебучая",
    "НУ ЕБАННЫЙ РЕЗОЛЬВЕР В ЭТОЙ ПАСТЕ КОГДА ЕГО УЖЕ ПОЧИНЯТ?",
    "але мандариновый жиробас, ты когда прыгать перестанешь?"
}

last_killer = nil

killsay_func = function(e)
    if not ui.get(menu.miscTab.killsay) then return end

    ent = entity.get_local_player()
    victim_userid, attacker_userid = e.userid, e.attacker

    if victim_userid == nil or attacker_userid == nil then
        return
    end

    attacker_entindex = client.userid_to_entindex(attacker_userid)
    victim_entindex = client.userid_to_entindex(victim_userid)
    if attacker_entindex ~= ent or not entity.is_enemy(victim_entindex) then
        return
    end

    selected_type = ui.get(menu.miscTab.killsay_type)
    add_type = ui.get(menu.miscTab.killsay_add)

    local tbl
    if selected_type == "Default" then
        tbl = killsay_normal
    elseif selected_type == "Ad" then
        tbl = killsay_ad
    elseif selected_type == "Revenge" then
        if last_killer and last_killer == victim_entindex then
            tbl = revenge_list
        else
            return
        end
    elseif add_type == "Miss" then
        return
    elseif selected_type == "Delayed 1" then
        client.delay_call(5, function()
            client.exec("say 1")
        end)
        return
    else
        return
    end

    client.delay_call(1, function()
        client.exec("say " .. tbl[client.random_int(1, #tbl)])
    end)
end

function on_aim_miss(e)
    if not ui.get(menu.miscTab.killsay) or not func.includes(ui.get(menu.miscTab.killsay_add), "Miss") then return end

    client.delay_call(1, function()
        client.exec("say " .. miss_words[client.random_int(1, #miss_words)])
    end)
end

track_last_killer = function(e)
    ent = entity.get_local_player()
    victim_userid, attacker_userid = e.userid, e.attacker

    if victim_userid == nil or attacker_userid == nil then
        return
    end

    attacker_entindex = client.userid_to_entindex(attacker_userid)
    victim_entindex = client.userid_to_entindex(victim_userid)


    if victim_entindex == ent and entity_is_enemy(attacker_entindex) then
        last_killer = attacker_entindex
    end
end


client.set_event_callback('player_death', function(e)
    if not ui.get(menu.miscTab.killsay) then return end
    delayed_msg = function(delay, msg)
        return client.delay_call(delay, function()
            client.exec('say ' .. msg)
        end)
    end

    delay = 2.3
    me = entity.get_local_player()
    victim = client.userid_to_entindex(e.userid)
    attacker = client.userid_to_entindex(e.attacker)

    killsay_delay = 0
    deathsay_delay = 0

    if victim ~= attacker and attacker == me and ui.get(menu.miscTab.killsay_type) == "Delayed" then
        phase_block = killsay_pharases[math.random(1, #killsay_pharases)]

        for i = 1, #phase_block do
            phase = phase_block[i]
            interphrase_delay = #phase_block[i] / 24 * delay
            killsay_delay = killsay_delay + interphrase_delay

            delayed_msg(killsay_delay, phase)
        end
    end

    if victim == me and attacker ~= me and ui.get(menu.miscTab.killsay_type) == "Delayed" then
        phase_block = death_say[math.random(1, #death_say)]

        for i = 1, #phase_block do
            phase = phase_block[i]
            interphrase_delay = #phase_block[i] / 20 * delay
            deathsay_delay = deathsay_delay + interphrase_delay

            delayed_msg(deathsay_delay, phase)
        end
    end
end)

client.set_event_callback("player_death", killsay_func)
client.set_event_callback("player_death", track_last_killer)
client.set_event_callback("aim_miss", on_aim_miss)


    event_callback("paint_ui", function()
    if ui.get(menu.visualsTab.fpsboost) then
            cvar.r_shadows:set_float(0)
            cvar.cl_csm_static_prop_shadows:set_float(0)
            cvar.cl_csm_shadows:set_float(0)
            cvar.cl_csm_world_shadows:set_float(0)
            cvar.cl_foot_contact_shadows:set_float(0)
            cvar.cl_csm_viewmodel_shadows:set_float(0)
            cvar.cl_csm_rope_shadows:set_float(0)
            cvar.cl_csm_sprite_shadows:set_float(0)
            cvar.r_dynamic:set_float(0)
            cvar.cl_autohelp:set_float(0)
            cvar.r_eyesize:set_float(0)
            cvar.r_eyeshift_z:set_float(0)
            cvar.r_eyeshift_y:set_float(0)
            cvar.r_eyeshift_x:set_float(0)
            cvar.r_eyemove:set_float(0)
            cvar.r_eyegloss:set_float(0)
            cvar.r_drawtracers_firstperson:set_float(0)
            cvar.r_drawtracers:set_float(0)
            cvar.fog_enable_water_fog:set_float(0)
            cvar.mat_postprocess_enable:set_float(0)
            cvar.cl_disablefreezecam:set_float(0)
            cvar.cl_freezecampanel_position_dynamic:set_float(0)
            cvar.r_drawdecals:set_float(0)
            cvar.muzzleflash_light:set_float(0)
            cvar.r_drawropes:set_float(0)
            cvar.r_drawsprites:set_float(0)
            cvar.cl_disablehtmlmotd:set_float(0)
            cvar.cl_freezecameffects_showholiday:set_float(0)
            cvar.cl_bob_lower_amt:set_float(0)
            cvar.cl_detail_multiplier:set_float(0)
            cvar.mat_drawwater:set_float(0) 
        else
            cvar.r_shadows:set_float(1)
            cvar.cl_csm_static_prop_shadows:set_float(1)
            cvar.cl_csm_shadows:set_float(1)
            cvar.cl_csm_world_shadows:set_float(1)
            cvar.cl_foot_contact_shadows:set_float(1)
            cvar.cl_csm_viewmodel_shadows:set_float(1)
            cvar.cl_csm_rope_shadows:set_float(1)
            cvar.cl_csm_sprite_shadows:set_float(1)
            cvar.r_dynamic:set_float(1)
            cvar.cl_autohelp:set_float(1)
            cvar.r_eyesize:set_float(1)
            cvar.r_eyeshift_z:set_float(1)
            cvar.r_eyeshift_y:set_float(1)
            cvar.r_eyeshift_x:set_float(1)
            cvar.r_eyemove:set_float(1)
            cvar.r_eyegloss:set_float(1)
            cvar.r_drawtracers_firstperson:set_float(1)
            cvar.r_drawtracers:set_float(1)
            cvar.fog_enable_water_fog:set_float(1)
            cvar.mat_postprocess_enable:set_float(1)
            cvar.cl_disablefreezecam:set_float(1)
            cvar.cl_freezecampanel_position_dynamic:set_float(1)
            cvar.r_drawdecals:set_float(1)
            cvar.muzzleflash_light:set_float(1)
            cvar.r_drawropes:set_float(1)
            cvar.r_drawsprites:set_float(1)
            cvar.cl_disablehtmlmotd:set_float(1)
            cvar.cl_freezecameffects_showholiday:set_float(1)
            cvar.cl_bob_lower_amt:set_float(1)
            cvar.cl_detail_multiplier:set_float(1)
            cvar.mat_drawwater:set_float(1)
        end
    end)

    ui.set_callback(menu.miscTab.filtercons, function()
        if menu.miscTab.filtercons then
            cvar.developer:set_int(0)
            cvar.con_filter_enable:set_int(1)
            cvar.con_filter_text:set_string("IrWL5106TZZKNFPz4P4Gl3pSN?J370f5hi373ZjPg%VOVh6lN")
            client.exec("con_filter_enable 1")
        else
            cvar.con_filter_enable:set_int(0)
            cvar.con_filter_text:set_string("")
            client.exec("con_filter_enable 0")
        end
    end)

    event_callback("shutdown", function()
        cvar.con_filter_enable:set_int(0)
        cvar.con_filter_text:set_string("")
        client.exec("con_filter_enable 0")
        ui.set(ref.aimbot, true)
        client.set_clan_tag("\0")
        traverse_table_on(refs)
        ui.set(refs.hitChance, L_hc)
    end)

    event_callback("round_prestart", function()
        queue = {}
        collectgarbage()
        collectgarbage("collect")
        notifications.clear()
    end)

    event_callback("paint_ui", function()
        local w,h = client.screen_size()
        if not entity.get_local_player() then return end
        slow_e(w, h)
        slow_a(w, h)
        notifications.render()
    end)


    event_callback("setup_command", function(cmd)
        if not should_shoot then
            cmd.in_attack = false
            cmd.in_attack2 = 0
        end
        should_shoot = true
        fastladder(cmd)
        jumpscout(cmd)
        charge_dt()
    end)


    event_callback('paint_ui', function()
        if ui.get(menu.configTab.info_panel_pos) == "Up" then
            g_paint_handler()
        elseif ui.get(menu.configTab.info_panel_pos) == "Down" then
            g_paint_handler_u()
        elseif ui.get(menu.configTab.info_panel_pos) == "Off" then
            return
        end
        renderer_trace_positions()
        local target = client.current_threat()
        if target then local threat_origin = vector(entity.get_origin(target)) threat_origin_wts_x = renderer.world_to_screen(threat_origin.x, threat_origin.y, threat_origin.z) end
    end)