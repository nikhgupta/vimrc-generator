module VimRCG
  class App < Padrino::Application
    register ScssInitializer
    register Padrino::Mailer
    register Padrino::Helpers
    enable :sessions
  end
end
