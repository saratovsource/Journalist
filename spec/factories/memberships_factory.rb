FactoryGirl.define do
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

end
