Vimspec::App.controllers :generator, map: "/" do
  get :index do
    render 'index'
  end

  get :generate do
    if params[:raw]
      content_type "text/plain"
      render :vimrc_raw
    else
      content_type "text/html"
      render :vimrc_html
    end
  end
end
