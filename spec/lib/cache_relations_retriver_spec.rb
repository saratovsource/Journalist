require 'spec_helper'

describe "Cache relations retriver" do
  it "does have not empty relations" do
    @comment = Factory.build(:comment)
    @comment.save
    @retriver = Journalist::Caching::CacheRelationsRetriver.new(@comment)
    @retriver.retrive_cache_relations!
    @retriver.should_not be_empty
  end
end