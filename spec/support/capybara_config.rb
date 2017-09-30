require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.app = app(VimRCG::App)
Capybara.javascript_driver = :poltergeist
Capybara.ignore_hidden_elements = true
