class PackageDetailsSaver
  attr_reader :index_data, :details_data

  def initialize(index_data: nil, details_data: nil)
    @index_data = index_data
    @details_data = details_data
  end

  def call
    rec = create_or_update_package!
    create_or_update_authors!(rec)
    create_or_update_maintainers!(rec)
  end

  private

  def package_record
    ::Package.find_or_initialize_by(name: package_name)
  end

  def package_name
    index_data.fetch('Package')
  end

  def version
    index_data.fetch('Version')
  end

  def published_at
    value = details_data.fetch('Date/Publication')
    begin
      Time.zone.parse(value)
    rescue
      nil
    end
  end

  def title
    details_data.fetch('Title')
  end

  def description
    details_data.fetch('Description')
  end

  def users(data)
    data.map(&method(:user))
  end

  def user(data)
    u = User.find_or_create_by!(name: data['name'])
    u.update(email: data['email']) if u.email.blank? && data['email'].present?
    u
  end

  def authors
    hash = PackageAuthorListParser.new(data: details_data).call
    users(hash)
  end

  def maintainers
    value = details_data.fetch('Maintainer')
    return [] if value.blank?
    hash = [/(?<name>.+)\s+<(?<email>[^>]+)>/.match(value)&.named_captures].compact.presence || ['name' => value]
    users(hash)
  end

  def create_or_update_package!
    rec = package_record
    rec.version = version
    rec.published_at = published_at
    rec.title = title
    rec.description = description
    rec.save!
    rec
  end

  def create_or_update_authors!(rec)
    rec.authors = authors
    rec.save!
    rec
  end

  def create_or_update_maintainers!(rec)
    rec.maintainers = maintainers
    rec.save!
    rec
  end
end
