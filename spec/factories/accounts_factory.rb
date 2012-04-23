FactoryGirl.define do
  # Accounts ##
  factory :account do
    name 'Bart Simpson'
    email 'bart@simpson.net'
    password 'easyone'
    password_confirmation 'easyone'
    locale 'en'

    factory "admin user" do
      name "Admin"
      email "admin@locomotiveapp.org"
    end

    factory "frenchy user" do
      name "Jean Claude"
      email "jean@frenchy.fr"
      locale 'fr'
    end

    factory "brazillian user" do
      name "Jose Carlos"
      email "jose@carlos.com.br"
      locale 'pt-BR'
    end

    factory "italian user" do
      name "Paolo Rossi"
      email "paolo@paolo-rossi.it"
      locale 'it'
    end

  end

end
