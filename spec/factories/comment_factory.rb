FactoryGirl.define do
  ## Comments ##

  factory :comment do
    message "Comment"
    site { FactoryGirl.build(:site)}
    owner { FactoryGirl.build("frenchy user") }
    commentable { FactoryGirl.build(:journal_rubric) }

    factory "second comment" do
      message "This is a second comment"
    end

    factory "first comment" do
      message "This is a first comment"
      children {
        [
          FactoryGirl.build("second comment")
          ]
      }
    end

  end
end
