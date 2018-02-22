TechHook = {
  classname = "FNTechHook",
}

local tech_buf = {}
local recipes_buf = {}

function TechHook.open_tech(force, name)
  local tech = force.technologies[name]
  if tech then
    for _,pre_tech in pairs(tech.prerequisites) do
      if pre_tech.researched == false then
        TechHook.open_tech(force, pre_tech.name)
        for _,effect in pairs(pre_tech.effects) do
          if effect.type == "unlock-recipe" then
            local recipe = force.recipes[effect.recipe]
            if recipe and recipe.enabled == true then
              table.insert(recipes_buf, recipe)
            end
          end
        end
        table.insert(tech_buf, { tech = pre_tech, progress = force.get_saved_technology_progress(pre_tech), enabled = pre_tech.enabled })

        pre_tech.researched = true
      end
    end
  end
end

function TechHook.reload_tech(force)
  for _,elem in pairs(tech_buf) do
    elem.tech.researched = false
    elem.tech.enabled = elem.enabled
    force.set_saved_technology_progress(elem.tech, elem.progress)
  end

  for _,recipe in pairs(recipes_buf) do
    recipe.enabled = true
  end
end

function TechHook.show_tech(name)
  local player = Player.get()

  if player and player.force.technologies[name] and global.fnei.cur_tech == nil then
    local force = player.force
    
    if force.current_research then
      local cur_progress = force.research_progress
      local tech = force.current_research

      global.fnei.cur_tech = {
        force = force,
        tech = tech,
        time = 0,
      }

      force.current_research = nil
      force.set_saved_technology_progress(tech, cur_progress)
    end

    TechHook.open_tech(force, name)
    force.current_research = name
    TechHook.reload_tech(force)

    Player.get_global().opened_gui = Controller.get_cur_con_name()
    Controller.close_event()
    player.opened = 2
    force.current_research = nil

    tech_buf = {}
    recipes_buf = {}
  end
end

function TechHook.return_prev_tech()
  local cur_tech = global.fnei.cur_tech

  if cur_tech.time > 0 then
    if cur_tech.force.current_research == nil then
      cur_tech.force.current_research = cur_tech.tech.name
    end
    
    global.fnei.cur_tech = nil
  else
    cur_tech.time = cur_tech.time + 1
  end
end

function TechHook.on_tick()
  if global.fnei.cur_tech then
    TechHook.return_prev_tech()
  end
end

function TechHook.on_gui_close(event)
  if event.gui_type == 2 then
    local contr = Player.get_global().opened_gui

    if not Settings.get_val("close-gui-when-tech-open") and Settings.get_val("need-show") and contr then
      Controller.open_gui_event(contr)
      Player.get_global().opened_gui = nil
    end
  end
end