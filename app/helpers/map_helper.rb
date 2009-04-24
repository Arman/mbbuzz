module MapHelper
  
  def init_map(search_center, markers)
    run_map_script do
      map = Google::Map.new(:controls => [:small_map, :map_type],
                            :center => search_center,
                            :zoom => 9)
      map.click do |script, location|
        map.open_info_window(:location => location, :text => 'That''s tickling!')
      end
      markers.each do |location|
               map.add_marker :location => location
             end       
    end 
  end
  
end
