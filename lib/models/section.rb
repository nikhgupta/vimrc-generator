class Section
  def self.create(str, last = nil)
    return if str.to_s.strip.empty?
    section = last && last.invalid? ? last : new(str.lines[0])
    section.add_heading str.lines[0]
    section.content = str.lines[1..-1].join
    section
  end

  attr_reader :title, :headings, :content

  def initialize(title, content = nil)
    @headings    = []
    self.title   = title
    self.content = content
  end

  def title=(str)
    @title = str.to_s.strip
    @headings << @title
  end

  def content=(str)
    @content = str.to_s.strip
  end

  def add_heading(str)
    @headings << str.strip unless @headings.include?(str.strip)
  end

  def invalid?
    content.empty?
  end

  def valid?
    !invalid?
  end

  def comments_only?
    content !~ /^\s*[^\"]+/m
  end

  def to_h
    { title: title, headings: headings, content: content }
  end
end
