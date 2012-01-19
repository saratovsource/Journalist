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
  
  factory :journal_rubric do
    title 'Rubric 1'
    description 'Description 1'
    site { Factory(:site, :name => 'site1') }
    owner { Factory('admin user', :locale => 'en') }
  end
  
  factory :journal_article do
    title "Article 1"
    description "Description of Article 1"
    journal_rubric { Factory(:journal_rubric) }
    owner { Factory('frenchy user', :locale => 'en') }
  end
end