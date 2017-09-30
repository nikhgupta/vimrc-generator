RSpec.describe TopicList do
  before(:each) do
    files = Dir[File.join(Padrino.root, 'spec/fixtures/vimrc/*.vim')]
    allow(Dir).to receive(:glob).and_return files.reverse
  end

  let(:list) { described_class.new }

  describe '#all' do
    it 'collects all topics available' do
      expect(list.all).to eq list
      expect(list.topics.count).to eq 3
      expect(list.topic_names).to match_array(%w[simple another complex])
    end

    it 'returns the list when topics are already available' do
      list.where_id_in('11')
      expect(list.all.topic_ids).to eq [11]
    end
  end

  describe '#sort' do
    it 'sorts all existing topics by ID' do
      expect(list.topic_ids).to eq [21, 11, 110]
      expect(list.sort).to eq list
      expect(list.topic_ids).to eq [11, 21, 110]
    end
  end

  describe '#reject_empty' do
    it 'rejects/ignores empty topics' do
      allow(File).to receive(:read).and_return ''
      expect(list.reject_empty).to eq list
      expect(list).to be_empty
    end
  end

  describe '#where_in' do
    it 'selects topics where attribute value is in a given list' do
      expect(list.topic_ids).to eq [21, 11, 110]
      expect(list.where_in(:id, [11])).to eq list
      expect(list.topic_ids).to eq [11]
    end

    it 'selects required topics if not specifically ignored' do
      expect(list.where_in(:id, [11], true)).to eq list
      expect(list.topic_ids).to match_array([11, 21])
    end

    it 'converts list of values to be mapped from comma-separated str' do
      list.where_in(:name, 'simple, another')
      expect(list.topic_names).to match_array %w[simple another]
    end

    it 'makes no selections if list of values is empty' do
      list.sort.where_in(:name, '  ')
      expect(list.topic_names).to match_array %w[simple complex another]
    end
  end

  describe '#where_not_in' do
    it 'selects topics where attribute value is not in a given list' do
      expect(list.topic_ids).to eq [21, 11, 110]
      expect(list.where_not_in(:id, [11, 21])).to eq list
      expect(list.topic_ids).to eq [110]
    end

    it 'selects required topics if not specifically ignored' do
      expect(list.where_not_in(:id, [11, 21], true)).to eq list
      expect(list.topic_ids).to match_array [21, 110]
    end

    it 'converts list of values to be mapped from comma-separated str' do
      list.where_not_in(:name, 'simple ,   complex')
      expect(list.topic_names).to eq %w[another]
    end

    it 'makes no selections if list of values is empty' do
      list.where_not_in(:name, '  ')
      expect(list.topic_names).to match_array %w[simple complex another]
    end
  end

  describe '#where_id_in' do
    it 'delegates to #where_in' do
      expect(list).to receive(:where_in).with(:id, [51, 91], false)
      list.where_id_in '51,   91 '

      expect(list).to receive(:where_in).with(:id, [51, 91], true)
      list.where_id_in '51,   91 ', true
    end
  end

  describe '#where_metadata' do
    it 'select topics with metadata' do
      list.where_metadata(group: %w[BASIC])
      expect(list.count).to be 2
      expect(list.topic_ids).to match_array([110, 11])
      expect(list.topic_names).not_to include('complex')
    end

    it 'can use other array operations when matching metadata' do
      res = list.where_metadata(group: 'BASIC', op: :reject)
      expect(res).to eq list
      expect(list.count).to be 1
      expect(list.topic_names).to eq ['complex']
    end

    it 'can match comma-separated string values' do
      list.where_metadata(group: 'SOMETHING, COMPLEX')
      expect(list.count).to eq 1
    end
  end

  describe '#where_metadata_not' do
    it 'delegates to #where_metadata' do
      expect(list).to receive(:where_metadata)
        .with(key: :val, op: :reject)
      list.where_metadata_not(key: :val)
    end
  end

  describe '#find' do
    it 'returns the first topic matching an attribute' do
      topic = list.find :id, 11
      expect(topic).to be_a Topic
      expect(topic.name).to eq 'simple'
    end
  end

  describe '#reset!' do
    it 'resets topics list' do
      list.where_id_in '11,21'
      expect(list.size).to eq 2

      list.reset!
      expect(list.size).to eq 3
    end
  end

  describe '#has_topic?' do
    it 'checks if topic(s) is/are currently being included in list' do
      list.where_id_in('11', false)
      expect(list).to     have_topic(11)
      expect(list).to     have_topic('11')
      expect(list).to     have_topic('simple')

      expect(list).not_to have_topic('22')
      expect(list).not_to have_topic('110')
      expect(list).not_to have_topic('complex')
    end
  end

  describe '#topic_ids' do
    it 'returns array of current topic IDs' do
      list.where_in(:name, 'another,simple', false)
      expect(list.topic_ids).to match_array([11, 110])
    end

    describe '#topic_names' do
      it 'returns array of current topic IDs' do
        list.where_id_in('11,21', false)
        expect(list.topic_names).to match_array(%w[complex simple])
      end
    end

    describe '.from_params' do
      it 'resets list, fetches topics, sorts them and rejects empty' do
        expect(TopicList.from_params).to eq list
      end

      it 'selects topics with specified ids only' do
        list = TopicList.from_params ids: '91,51,11'
        expect(list.topic_ids).to eq [11, 21]
      end

      it 'selects topics with specified names only' do
        list = TopicList.from_params only: 'ANYTHING,'
        expect(list.topic_names).to eq ['complex']
      end

      it 'excludes topics with specified names' do
        list = TopicList.from_params exclude: 'simple,complex,'
        expect(list.topic_names).to contain_exactly('another', 'complex')
      end

      it 'can, optionally, filter out all required topics' do
        list = TopicList.from_params keep_required: false,
                                     only: 'simple', exclude: 'another,complex'
        expect(list.topic_names).to eq ['simple']

        list = TopicList.from_params keep_required: false,
                                     only: 'complex', exclude: 'complex'
        expect(list).to be_empty

        list = TopicList.from_params keep_required: false, only: 'whatever'
        expect(list).to be_empty
      end
    end
  end
end
