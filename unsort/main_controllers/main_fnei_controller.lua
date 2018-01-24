local FneiMainController = {
  classname = "FNFneiMainController",
}

local pages = "main-pages"
local cont_gui

function FneiMainController.init_event(gui_name, content_gui)
  pages = Page:new(pages, gui_name, 100, FneiMainController.draw_content, FneiMainController.draw_content)
  cont_gui = content_gui
end

function FneiMainController.draw_content()
  FneiMainController.set_page_list()
  cont_gui.draw_page_label(pages)
  cont_gui.draw_item_list(pages:get_list_for_tab(pages:get_cur_page()))
end

function FneiMainController.set_page_list()
  pages:set_page_list(get_item_list())
end

return FneiMainController