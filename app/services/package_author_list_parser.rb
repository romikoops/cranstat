class PackageAuthorListParser
  attr_reader :data

  def initialize(data: nil)
    @data = data
  end

  def call
    return [] if data.blank?
    authors_r_fields_data.presence || author_field_data
  end

  private

  def author_field_data
    values = data.fetch('Author').to_s.gsub(/\s\[.+?\]/, '').sub(', and ', ', ').split(', ').reject(&:blank?)
    values.map do |value|
      /(?<name>.+)\s+<(?<email>[^>]+)>/.match(value)&.named_captures.presence || { 'name' => value }
    end
  end

  # rubocop:disable Security/Eval
  def authors_r_fields_data
    res = eval(
      data.fetch('Authors@R', '[]')
        .gsub(/role\s*=/, 'role:')
        .gsub(/email\s*=/, 'email:')
        .gsub(/family\s*=/, 'family:')
        .gsub(/,\s*,/, ', email:')
    )
    return res if res.is_a?(Array)
    [res]
  end
  # rubocop:enable Security/Eval

  def c(*array)
    array
  end

  # rubocop:disable Lint/UnusedMethodArgument
  def person(first_name = nil, last_name = nil, role: nil, email: nil, family: nil)
    name = family.presence || "#{first_name} #{last_name}"
    res = { 'name' => name }
    res['email'] = email if email.present?
    res
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
