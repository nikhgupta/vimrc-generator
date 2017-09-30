require 'forwardable'

class Topic
  include VimRCG::Utility
  extend Forwardable

  attr_reader :id, :name, :path, :metadata, :content, :sections
  def_delegators :@sections, :[], :map, :take, :first, :last

  HEADER_REGEX   = /^\s*\"\s*-->\s*/m
  METADATA_REGEX = /^\s*\"\s*-->\s*([a-z]+):(.*)$/

  def initialize(path)
    self.path = path
    @content  = File.read(path)
    @metadata = parse_metadata(content)
    @sections = parse_sections(content)
  end

  def path=(path)
    @path = path
    @name = File.basename(path, '.vim').downcase
    match = @name.match(/^(\d+)_(.*)$/)
    @id, @name = match ? [match[1].to_i, match[2]] : [999, @name]
  end

  def sanitized_name
    metadata['name'] ? metadata['name'][0] : @name.titleize
  end

  def action
    metadata['action'][0] if metadata && metadata['action']
  end

  def required?
    !empty? && metadata['action'].include?('REQUIRED')
  end

  def headings
    sections.map(&:headings).flatten
  end

  def empty?
    metadata.empty? || sections.empty?
  end

  def present?
    !empty?
  end

  def to_h
    { id: id, name: name, metadata: metadata, sections: sections.map(&:to_h) }
  end

  def select_sections(ids = [])
    return if ids.empty?
    @sections = ids.map{ |id| @sections[id] }.compact
  end

  protected

  def parse_metadata(content)
    data = content.lines.map do |line|
      match = line.match(METADATA_REGEX)
      [match[1], from_csv(match[2])] if match
    end.compact.to_h
    return data if data.empty?
    { 'action' => ['RECOMMENDED'], 'group' => ['DEFAULTS'] }.merge(data)
  end

  def parse_sections(content)
    @sections = []
    last_section = nil
    content.gsub(METADATA_REGEX, '').strip
           .split(HEADER_REGEX).map do |data|
      section = Section.create(data, last_section)
      next unless section
      @sections << section if section.valid?
      last_section = section.valid? ? nil : section
    end
    @sections.reject(&:comments_only?)
  end
end
