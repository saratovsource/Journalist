FactoryGirl.define do
  # site
  
  factory :site do
    name 'Nahalno'
    subdomain 'shop'
    created_at Time.now
  end
  
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

  ## Memberships ##
  factory :membership do
    role 'admin'
    account { Account.where(:name => "Bart Simpson").first || Factory('admin user') }

    factory :admin do
      role 'admin'
      account { Factory('admin user', :locale => 'en') }
    end

    factory :editor do
      role 'editor'
      account { Factory('frenchy user', :locale => 'en') }
    end

    factory :author do
      role 'author'
      account { Factory('brazillian user', :locale => 'en') }
    end

  end
  
  ## Journal Items ##
  
  factory :journal_rubric do
    title 'Test Rubric'
    slug 'test_rubric'
    description "this is a test text block with a link to rubric http://example.com/test_rubric is a link of Test Rubric We want to parce this text"
    site { FactoryGirl.build(:site)}
    owner { FactoryGirl.build("admin user") }
  end
  
  
  ## Routers and RouteAliases ##
  
  factory :router do
    slug 'route1'
    prefix 'collections'
    site { FactoryGirl.build(:site) }
    routerable { FactoryGirl.build(:journal_rubric) }
  end
end