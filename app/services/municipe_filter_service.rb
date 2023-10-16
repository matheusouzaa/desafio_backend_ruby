class MunicipeFilterService
  def self.filter(params)
    MunicipeFilter.new(params).filter
  end
end