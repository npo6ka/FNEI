local FneiMainController = {
  classname = "FNFneiMainController",
}

local pages = "main-pages"
local cont_gui

function FneiMainController.init_event(gui_name, content_gui)
  pages = Page:new(pages, gui_name, 12, FneiMainController.redraw_content, FneiMainController.redraw_content)
  cont_gui = content_gui

  Events.add_custom_event(gui_name, "choose-elem-button", "fluid", FneiMainController.open_fluid_recipe_event)
  Events.add_custom_event(gui_name, "choose-elem-button", "item", FneiMainController.open_item_recipe_event)
end

function FneiMainController.draw_content()
  cont_gui.set_search_field(FneiMainController.get_search_field())
  FneiMainController.redraw_content()
end

function FneiMainController.redraw_content()
  FneiMainController.set_page_list()
  cont_gui.draw_page_label(pages)
  cont_gui.draw_item_list(pages:get_list_for_tab(pages:get_cur_page()))
  if Settings.get_val("focus-search") then
    cont_gui.focus_on_search()
  end
end

function FneiMainController.set_page_list()
  local search_text = Translate.tolower(FneiMainController.get_search_field():gsub(" ", "-"):gsub("%p", "%%%0"))
  local page_list = {}

  function prot_iterate(prots, prot_name)
    for _, prot in pairs(prots) do
      local term = prot.name

      if string.find(term:lower(), search_text) then
        table.insert(page_list, prot_name .. "\t" .. prot.name)
      else
        term = Translate.translate(prot.name, prot_name)
        if term and string.find(term, search_text) then
          table.insert(page_list, prot_name .. "\t" .. prot.name)
        end
      end
    end
  end

  prot_iterate(get_item_list(), "item")
  prot_iterate(get_fluid_list(), "fluid")

  pages.num_per_page = 12 * Settings.get_val("fnei-line-count")
  pages:set_page_list(page_list)
end

function FneiMainController.search_event(event)
  if event.text then
    FneiMainController.set_search_field(event.text)
    FneiMainController.redraw_content()
  elseif event.button == defines.mouse_button_type.right then
    FneiMainController.set_search_field("")
    FneiMainController.draw_content()
  end
end

function FneiMainController.set_search_field(str)
  Player.get_storage().fnei_search = str
end

function FneiMainController.get_search_field()
  return Player.get_storage().fnei_search or ""
end

function FneiMainController.open_item_recipe_event(event, elem_name)
  if elem_name == "item" then
    local _,pos =  string.find(event.element.name, "item\t")

    if pos then
      elem_name = string.sub(event.element.name, pos + 1)
    end

    local contr = Controller.get_cont("recipe")

    if event.button == defines.mouse_button_type.right then
      contr.add_element_in_recipe_list("usage", "item", elem_name)
      Controller.open_event("recipe")
    else
      contr.add_element_in_recipe_list("craft", "item", elem_name)
      Controller.open_event("recipe")
    end
  end
end

function FneiMainController.open_fluid_recipe_event(event, elem_name)
  if elem_name == "fluid" then
    local _,pos =  string.find(event.element.name, "fluid\t")

    if pos then
      elem_name = string.sub(event.element.name, pos + 1)
    end

    local contr = Controller.get_cont("recipe")

    if event.button == defines.mouse_button_type.right then
      contr.add_element_in_recipe_list("usage", "fluid", elem_name)
      Controller.open_event("recipe")
    else
      contr.add_element_in_recipe_list("craft", "fluid", elem_name)
      Controller.open_event("recipe")
    end
  end
end

return FneiMainController