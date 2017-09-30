RSpec.describe '/api/generate' do
  it 'generates complete vim configuration' do
    visit '/api/generate'
    expect(page.response_headers['Content-Type']).to include 'text/plain'
    topics_present? 'Variables', 'Startup Screen', 'Clipboard', 'MACOSX'
  end

  it 'can exclude certain topics from generated vim configuration' do
    visit '/api/generate?exclude=macosx'
    topics_absent?  'MACOSX'
    topics_present? 'Variables', 'Startup Screen', 'Clipboard'
  end

  it 'includes only certain topics in generated vim configuration' do
    visit '/api/generate?only=macosx'
    topics_absent?  'Startup Screen', 'Clipboard'
    topics_present? 'MACOSX', 'Variables'
  end

  it 'always includes some topics and config' do
    visit '/api/generate?only=/'
    topics_absent?  'MACOSX', 'Startup Screen', 'Clipboard'
    topics_present? 'Variables', 'Plugin Manager'

    expect(page.body).to include('~/.vimrc.pre')
    expect(page.body).to include('plug#begin')
    expect(page.body).to include('plug#end')
    expect(page.body).to include('~/.vimrc.local')
    expect(page.body).not_to include('colorscheme')
  end

  it 'excluding nothing works as expected' do
    visit '/api/generate'
    complete = page.body
    visit '/api/generate?exclude='
    expect(page.body).to eq complete
  end
end

# tested in /pages_controller specs
RSpec.describe '/api/customize' do
end

RSpec.describe '/api/topics' do
  it 'works similarly to /api/generate endpoint' do
    expect(TopicList).to receive(:from_params)
      .with('key' => 'val', 'keep_required' => false)
    visit '/api/topics?key=val'
  end
  it 'returns a JSON representation of topics' do
    visit '/api/topics'
    expect(page.response_headers['Content-Type']).to eq 'application/json'
    expect { JSON.parse(page.body) }.not_to raise_error
  end
  it 'does not add in `required` topics' do
    visit '/api/topics?only=/'
    response = JSON.parse(page.body)
    expect(response).to be_empty

    visit '/api/topics?only=mouse'
    response = JSON.parse(page.body)
    expect(response.size).to eq(1)
    expect(response[0]['name']).to eq 'mouse'
  end

  it 'can return a list of topics with their IDs' do
    visit '/api/topics?list=1'
    response = JSON.parse(page.body)
    expect(response).to be_a(Hash)
    expect(response['variables']).to eq 0
    expect(response.size).to eq TopicList.new.reject_empty.size
  end
end

RSpec.describe '/api/sections' do
  it 'returns an empty list with no parameters' do
    visit '/api/sections'
    expect(page.body).to eq('[]')
  end
  it 'returns a JSON for array of requested sections only' do
    visit '/api/sections?only=45001,50000,50001'
    expect(page.response_headers['Content-Type']).to eq 'application/json'
    expect { JSON.parse(page.body) }.not_to raise_error
    response = JSON.parse(page.body)
    expect(response.size).to eq 2

    expect(response[0]['sections'].size).to eq 1
    expect(response[1]['sections'].size).to eq 2
  end
  it 'does not add in `required` topics' do
    visit '/api/sections?only=/'
    response = JSON.parse(page.body)
    expect(response).to be_empty

    visit '/api/sections?only=05001'
    response = JSON.parse(page.body)
    expect(response.size).to eq(1)
    expect(response[0]['name']).to eq 'spell'
  end

  it 'expects sections IDs in a 5 digit format' do
    visit '/api/sections?only=5001'
    response = JSON.parse(page.body)
    expect(response.size).to eq(0)

    visit '/api/sections?only=05001'
    response = JSON.parse(page.body)
    expect(response.size).to eq(1)
  end
end
