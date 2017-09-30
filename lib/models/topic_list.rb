require 'forwardable'

class TopicList
  include VimRCG::Utility
  extend Forwardable

  def self.with_sections(secs)
    secs = secs.to_s.scan(/\d+{5}/) unless secs.is_a?(Array)
    secs = secs.map { |val| [val.to_i / 1000, val.to_i % 1000] }
    new.with_sections(secs).reject_empty
  end

  def self.from_params(params = {})
    required = params.fetch(:keep_required, true)
    new.sort.reject_empty
       .where_in(:name, params[:only].to_s.downcase, required)
       .where_not_in(:name, params[:exclude].to_s.downcase, required)
       .where_id_in(params[:ids], required)
  end

  attr_accessor :topics
  def_delegators :@topics, :[], :count, :size, :map, :each, :each_slice,
                 :empty?, :any?

  def initialize
    reset!
  end

  def ==(other)
    to_a == other.to_a
  end

  def to_a
    sort.topics.map(&:to_h)
  end

  def topic_ids
    @topics.map(&:id)
  end

  def topic_names
    @topics.map(&:name)
  end

  def reset!
    @topics = []
    all
  end

  def all
    return self if any?
    pattern = File.join(Padrino.root, 'vimrc', '*.vim')
    @topics = Dir.glob(pattern).map { |path| Topic.new(path) }
    self
  end

  def sort
    @topics.sort_by!(&:id)
    self
  end

  def reject_empty
    @topics.select!(&:present?)
    self
  end

  def where_in(key, vals = nil, keep_required = false)
    vals = from_csv(vals.to_s.downcase) unless vals.is_a?(Array)
    vals = vals.map(&:to_s)
    return self if vals.empty?
    @topics = @topics.select do |t|
      val = t.send(key).to_s.downcase
      vals.include?(val) || (keep_required && t.required?)
    end
    self
  end

  def where_not_in(key, vals = nil, keep_required = false)
    vals = from_csv(vals.to_s.downcase) unless vals.is_a?(Array)
    vals = vals.map(&:to_s)
    return self if vals.empty?
    @topics = @topics.reject do |t|
      val = t.send(key).to_s.downcase
      vals.include?(val) && !(keep_required && t.required?)
    end
    self
  end

  def where_id_in(vals, keep_required = false)
    vals = from_csv(vals.to_s).map(&:to_i) unless vals.is_a?(Array)
    where_in(:id, vals, keep_required)
  end

  def where_metadata(options = {})
    op = options.delete(:op) || :select
    options.each do |key, val|
      val = from_csv(val) if val.is_a?(String)
      @topics = @topics.send(op) do |t|
        ([val].flatten - t.metadata[key.to_s.downcase]).empty?
      end
    end
    self
  end

  def where_metadata_not(options = {})
    where_metadata options.merge(op: :reject)
  end

  def with_sections(sections = [])
    sections = sections.group_by(&:first)
    @topics  = @topics.select{|t| sections.keys.include?(t.id)}
    @topics.each do |topic|
      next unless sections[topic.id]
      topic.select_sections sections[topic.id].map(&:last)
    end
    self
  end

  def find(key, val)
    @topics.detect { |t| t.send(key) == val }
  end

  def fetch_topic(name)
    name = name.to_s.strip.downcase
    return if name.empty?
    find(:name, name)
  end

  def topic?(id_or_name)
    @topics.any? do |t|
      val = id_or_name.to_s.downcase
      val = id_or_name.to_i if val =~ /\A\d+\z/
      t.id == val || t.name.downcase == val
    end
  end
  alias has_topic? topic?
end
