FactoryGirl.define do
  ## Journal Items ##

  factory :journal_rubric do
    title 'Test Rubric'
    slug 'test_rubric'
    description "this is a test text block with a link to rubric http://example.com/journal/test_rubric is a link of Test Rubric We want to parce this text"
    site { FactoryGirl.build(:site)}
    owner { FactoryGirl.build("admin user") }

    factory "test_comment_rubric" do
      title 'Comment Rubric'
      slug 'test_comment_rubric'
    end
  end


end
