class PackageDetailsParser
  attr_reader :data

  def initialize(data: nil)
    @data = data
  end

  def call
    return {} if data.blank?
    Dcf.parse(data.to_s).first
  end
end
