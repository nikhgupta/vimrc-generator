VimRCG::App.controllers :generator, map: '/api/' do
  # generated vim configuration
  get :generate do
    content_type 'text/plain'
    list = TopicList.from_params(params)
    render 'generate', locals: { list: list }
  end

  post :customize do
    content_type 'text/plain'
    required_sections = params['sections'].select { |_k, v| v.to_i > 0 }.keys
    list = TopicList.with_sections(required_sections)
    render 'generate', locals: { list: list }
  end

  # topics
  get :topics do
    content_type 'application/json'
    params['keep_required'] = false
    list = TopicList.from_params(params)
    list = params['list'] ? list.map { |t| [t.name, t.id] }.to_h : list.to_a
    list.to_json
  end

  # sections
  get :sections do
    content_type 'application/json'
    list = TopicList.with_sections(params[:only])
    list.to_a.to_json
  end
end
