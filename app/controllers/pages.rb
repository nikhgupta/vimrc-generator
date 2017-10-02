VimRCG::App.controllers :pages, map: '/' do
  get :index do
    render 'index'
  end

  get :customize do
    render 'customization'
  end

  get :api do
    render 'api-docs'
  end
end
