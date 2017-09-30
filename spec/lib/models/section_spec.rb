RSpec.describe Section do
  let(:title)  { "  \n hello section \n\n   \n" }
  let(:content) { "  \n some  content \n\n   \n" }
  let(:subject) { described_class.new(title, content) }

  it 'has a title' do
    expect(subject.title).to eq 'hello section'
    expect(subject.headings.count).to be 1
    expect(subject.headings[0]).to eq 'hello section'
  end

  it 'has content' do
    expect(subject.content).to eq 'some  content'
  end

  it 'allows modification of title and content' do
    subject.title   = '  a '
    subject.content = '  b '
    expect(subject.title).to   eq 'a'
    expect(subject.content).to eq 'b'
  end

  it 'allows adding more headings' do
    subject.add_heading '       c '
    expect(subject.headings.count).to eq 2
    expect(subject.headings[0]).to eq 'hello section'
    expect(subject.headings[1]).to eq 'c'
  end

  it 'validates itself when content is present' do
    subject.content = "   \n \n"
    expect(subject).to be_invalid
    subject.content = "   \nc\n"
    expect(subject).to be_valid
  end

  it 'detects if content comprises of comments only' do
    subject.content = "\" a  \nc\n\" d  \n"
    expect(subject.content).to eq "\" a  \nc\n\" d"
    expect(subject).not_to be_comments_only

    subject.content = "\" a  \n\"c\n\" d  \n"
    expect(subject.content).to eq "\" a  \n\"c\n\" d"
    expect(subject).to be_comments_only
  end

  it 'can convert itself to a Hash' do
    expect(subject.to_h).to be_a Hash
    expect(subject.to_h).to eq(title: 'hello section',
                               headings: ['hello section'],
                               content: 'some  content')
  end

  describe '.create' do
    it 'creates a section from a given string' do
      section = described_class.create("title \n some content")
      expect(section.title).to eq 'title'
      expect(section.headings).to eq ['title']
      expect(section.content).to eq 'some content'
    end

    it 'merges section into previous one when previous one is invalid' do
      section = described_class.create('title1')
      expect(section.title).to eq 'title1'
      expect(section.headings).to eq ['title1']
      expect(section.content).to be_empty
      expect(section).to be_invalid

      section = described_class.create('title2', section)
      expect(section.title).to eq 'title1'
      expect(section.headings).to eq %w[title1 title2]
      expect(section.content).to be_empty
      expect(section).to be_invalid

      section = described_class.create("title3\nsome content", section)
      expect(section.title).to eq 'title1'
      expect(section.headings).to eq %w[title1 title2 title3]
      expect(section.content).to eq 'some content'
      expect(section).to be_valid

      newsection = described_class.create("title1\nsome content", section)
      expect(newsection.title).to eq 'title1'
      expect(newsection.headings).to eq ['title1']
      expect(newsection.content).to eq 'some content'
      expect(newsection).to be_valid
      expect(newsection).not_to eq section
    end
  end
end
