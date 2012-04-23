FactoryGirl.define do
  ## Routers and RouteAliases ##

  factory :router do
    slug 'route1'
    prefix 'collections'
    site { FactoryGirl.build(:site) }
    routerable { FactoryGirl.build(:journal_rubric) }
  end

end
