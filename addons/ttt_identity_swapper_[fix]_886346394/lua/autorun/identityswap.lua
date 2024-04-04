if SERVER then
  AddCSLuaFile()
end

hook.Add("PostGamemodeLoaded", "TTTInitIdentSwap", function()
    if (GAMEMODE_NAME == "terrortown") then

      if CLIENT then
        local function IdentSwaprInit()

          local GM = gmod.GetGamemode()
          local Player = debug.getregistry().Player

          local oldNick = Player.Nick
          local oldName = Player.Name
          local oldGetName = Player.GetName

          local oldIsDetective = Player.IsDetective
          local oldGetBaseKarma = Player.GetBaseKarma

          local oldTargetID = GM.HUDDrawTargetID
          local oldPlayerID = 13441

          local function tmpNick( ent )
            local client = LocalPlayer()
            if ent:GetNWBool("IdentSwapInDisguise") then
              if (client:IsTraitor() and ent:IsTraitor()) or client:IsSpec() then
                return oldNick(ent) .. " (Disguised as " .. ent:GetNWString("IdentSwapName") .. ")"
              else
                return ent:GetNWString("IdentSwapName")
              end
            end
            return oldNick( ent )
          end

          local function tmpIsDetective( ent )
            return ent:GetNWBool("IdentSwapInDisguise") and ent:GetNWBool("IdentSwapIsDetective") or oldIsDetective(ent)
          end

          local function tmpGetBaseKarma( ent )
            return ent:GetNWBool("IdentSwapInDisguise") and ent:GetNWInt("IdentSwapKarma") or oldGetBaseKarma(ent)
          end

          GM.HUDDrawTargetID = function()
            local trace = LocalPlayer():GetEyeTrace(MASK_SHOT)
            local ent = trace.Entity

            if file.Exists("sh_spectator_deathmatch.lua", "LUA") then -- prevents SpecDM fix when SpecDM is not installed
              if IsValid(ent) and ent:IsPlayer() then
                local showalive = GetConVar("ttt_specdm_showaliveplayers")
                if (ent:IsGhost() and not LocalPlayer():IsGhost()) or (not ent:IsGhost() and LocalPlayer():IsGhost() and not showalive:GetBool()) then
                  return -- when one player is a ghost, quit
                end
              end
            end

            Player.Nick = tmpNick
            Player.Name = tmpNick
            Player.GetName = tmpNick
            Player.IsDetective = tmpIsDetective

            Player.GetBaseKarma = tmpGetBaseKarma

            for _, ply in pairs ( player.GetAll() ) do
              if ply:GetNWBool("IdentSwapInDisguise") and IsValid(ply:GetNWEntity("IdentSwapEnt",nil)) then
                ply.old_sb_tag = ply.sb_tag
                ply.sb_tag = ply:GetNWEntity("IdentSwapEnt",nil).sb_tag
              end
            end

            oldTargetID()

            local client = LocalPlayer()
            if IsValid(client.last_id) and client.last_id:IsPlayer() and client.last_id:GetNWBool("IdentSwapInDisguise") then
              client.last_id = client.last_id:GetNWEntity("IdentSwapEnt",nil)
            end

            for _, ply in pairs ( player.GetAll() ) do
              if ply.old_sb_tag then
                ply.sb_tag = ply.old_sb_tag
                ply.old_sb_tag = nil
              end
            end

            Player.Nick = oldNick
            Player.Name = oldName
            Player.GetName = oldGetName
            Player.IsDetective = oldIsDetective
            Player.GetBaseKarma = oldGetBaseKarma
          end

          local function IdentSwapDraw()
            local client = LocalPlayer()
            if not IsValid(client) then return end
            if not client:GetNWBool("IdentSwapInDisguise") then return end

            surface.SetFont("TabLarge")
            surface.SetTextColor(255, 0, 0, 230)

            local text = "You are disguised as " .. client:GetNWString("IdentSwapName")
            local w, h = surface.GetTextSize(text)

            surface.SetTextPos(36, ScrH() - 150 - h)
            surface.DrawText(text)
          end
          hook.Add("HUDPaint","IdentSwapDraw", IdentSwapDraw)

          function RADIO:GetTargetType()
            if not IsValid(LocalPlayer()) then return end
            local trace = LocalPlayer():GetEyeTrace(MASK_SHOT)

            if not trace or (not trace.Hit) or (not IsValid(trace.Entity)) then return end

            local ent = trace.Entity

            if ent:IsPlayer() then
              if ent:GetNWBool("disguised", false) then
                return "quick_disg", true
              elseif ent:GetNWBool("IdentSwapInDisguise", false) then
                if IsValid(ent:GetNWEntity("IdentSwapEnt",nil)) then
                  return ent:GetNWEntity("IdentSwapEnt",nil), false
                else
                  return nil, false
                end

              else
                return ent, false
              end
            elseif ent:GetClass() == "prop_ragdoll" and CORPSE.GetPlayerNick(ent, "") != "" then
              if DetectiveMode() and not CORPSE.GetFound(ent, false) then
                return "quick_corpse", true
              else
                return ent, false
              end
            end
          end
        end
        hook.Add( 'PostGamemodeLoaded', 'IdentSwaprInit', function() timer.Simple( 0.5, IdentSwaprInit ) end )


      end end end)
