VimRCG::App.controllers :pages, map: '/' do
  get :index do
    render 'index'
  end

  get :customize do
    render 'advanced'
  end
end
