RSpec.describe '/' do
  before(:each) { visit '/' }

  it 'is branded' do
    expect(page.status_code).to eq 200
    expect(page).to have_title('VimRCG')
    expect(page).to have_content('VimRC Generator')
  end

  it 'provides command to generate complete vim config' do
    code  = app.url_for(:generator, :generate)
    code  = Regexp.escape(code) + '.*?~\/\.vimrc'
    code += Regexp.escape('; vim +PlugInstall +q')
    expect(page).to have_css('code', text: Regexp.new(code))
  end

  it 'provides button to generate a custom Vim configuration' do
    expect(page).to have_selector(:link_or_button, text: /customize now/i)
    click_link_or_button(text: /customize now/i)
    expect(page.current_path).to eq app.url_for(:pages, :customize)
    expect(page.status_code).to eq 200
  end

  # Thank you! for a beautiful theme :)
  it 'gives attribution to the designer of the theme' do
    expect(page).to have_link('Xiaoying Riley')
  end
end

RSpec.describe '/customize' do
  before(:each) { visit '/customize' }
  let(:list) { TopicList.from_params }

  it 'is branded' do
    expect(page.status_code).to eq 200
    expect(page).to have_title('VimRCG')
    expect(page).to have_content('VimRC Generator')
  end

  it 'clearly, defines the reason this page exists' do
    expect(page).to have_css('h1', text: 'Customization')
  end

  it 'has sidebar with links to all topics in the configuration' do
    expect(page).to have_selector('ul#doc-menu li a', count: list.size)
  end

  it 'has all topics listed along with code in their sections', :slow do
    expect(page).to have_selector('.doc-section', count: list.size)
    list.each do |topic|
      expect(page).to have_topic_customization_section(topic)
    end
  end

  # test various scrollspy related behaviour
  xit 'clicking on a sidebar link navigates to that topic', :js
  xit 'scrolling main content also scrolls sidebar if required', :js

  it 'has a always visible button for generating vim configuration' do
    expect(page).to have_selector('form#customize-config')
    expect(page).to have_selector("input[type='submit']#generate-config")
    expect(TopicList).to receive(:with_sections)
      .with(kind_of(Array)).and_call_original
    click_on 'Generate'
  end
end
