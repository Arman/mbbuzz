# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def shorten_text(text,size)
    return text.first(size)+'...' unless text.length<=size
    text.to_s
  end
  
  def checklist(name, collection, value_method, display_method, selected)
    selected ||= []
    
    ERB.new(%{
    <div class="checklist" style="border:1px solid #666; width:20em; height:5em; overflow:auto">
      <% for item in collection %>
        <%= check_box_tag name, item.send(value_method), selected.include?(item.send(value_method)) %> <%=h item.send(display_method) %><br />
      <% end %>
    </div>}).result(binding)
  end
end
