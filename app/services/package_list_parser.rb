class PackageListParser
  attr_reader :data, :limit

  def initialize(data: nil, limit: nil)
    @data = data
    @limit = limit
  end

  def call
    res = Dcf.parse(data.to_s).to_a
    return res.first(limit) if limit.present? && limit.positive?
    res
  end
end
