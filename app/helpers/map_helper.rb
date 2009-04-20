module MapHelper
  
  def init_map(search_center)
    run_map_script do
      map = Google::Map.new(:controls => [:small_map, :map_type],
                            :center => search_center,
                            :zoom => 10)

      map.click do |script, location|
        map.open_info_window(:location => location, :text => 'hello istanbul!')
      end
    end
    
  end
  

    
    

  
end
