# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def shorten_text(text,size)
    return text.first(size)+'...' unless text.length<=size
    text.to_s
  end
end
