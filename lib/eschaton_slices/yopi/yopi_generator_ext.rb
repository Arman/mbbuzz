module YopiGeneratorExt

  def map
    @map ||= Google::Map.existing(:var => 'map')
  end

end