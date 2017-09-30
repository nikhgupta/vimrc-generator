RSpec.describe Topic do
  context 'with a simple config file' do
    let(:subject) { topic_for('11_simple') }

    it 'has an id, name and a path' do
      expect(subject.id).to eq 11
      expect(subject.name).to eq 'simple'
      expect(subject.sanitized_name).to eq 'Simple'
      expect(subject.path).to include('vimrc/11_simple.vim')
      expect(subject).not_to be_required
    end

    it 'extracts metadata from config file' do
      expect(subject.action).to eq 'ADVANCED'
      expect(subject.metadata['group'].count).to eq 3
      expect(subject.metadata['group']).to  include('BASIC', 'SOMETHING')
      expect(subject.metadata['action']).to include('ADVANCED', 'IGNORED')
    end

    it 'extracts sections and headings from config file' do
      expect(subject.sections.count).to eq 2
      expect(subject.headings.count).to eq 2
      expect(subject).to be_present

      expect(subject[0].content).to  eq('set somefeature')
      expect(subject[0].headings).to include(/title for a feature/)
      expect(subject[1].content).to  eq('set someotherfeature')
      expect(subject[1].headings).to include(/title for another feature/)
    end
  end

  context 'config files without numbers in file name' do
    let(:subject) { topic_for('no-priority', false) { '' } }

    it 'assigns name to the config file' do
      expect(subject.name).to eq 'no-priority'
      expect(subject.sanitized_name).to eq 'No Priority'
    end
    it 'assigns least priority to the config file' do
      expect(subject.id).to eq 999
    end
  end

  context 'config files with all lines commented out' do
    let(:subject) do
      topic_for('11_simple') do |content|
        content.lines.map { |line| "\" #{line}" }.join
      end
    end

    it 'assigns an id and name to the config file' do
      expect(subject.id).to eq 11
      expect(subject.name).to eq 'simple'
    end

    it 'returns empty metadata for config file' do
      expect(subject.metadata).to be_empty
    end

    it 'return empty sections for config file' do
      expect(subject.sections).to be_empty
      expect(subject.metadata).to be_empty
      expect(subject).not_to be_present
    end
  end

  context 'complex configuration file' do
    let(:subject) { topic_for('21_complex') }
    it 'ignores sections with commented config' do
      expect(subject.headings).not_to include(/config commented out/)
      content = subject.map(&:content).join
      expect(content).not_to include 'ObsoleteFunc'
    end

    it 'marks as required if relevant metadata is present' do
      expect(subject).to be_required
    end

    it 'extracts multiple/nested headers correctly' do
      expect(subject.sections.count).to    eq 6
      expect(subject.headings.count).to    eq 9
      expect(subject[1].headings.count).to eq 3

      expect(subject.headings).to include(/depends on ruby/)
      expect(subject.headings).to include(/title for another feature/)
      expect(subject.headings).to include(/multiple indented headers/)
      expect(subject.headings).not_to include(/commented out/)
      expect(subject[1].headings).to include(/multiple headers/)
    end
  end
end
