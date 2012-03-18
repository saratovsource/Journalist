require 'spec_helper'

describe Comment do
  it 'should have a valid factory' do
    FactoryGirl.build(:comment).should be_valid_verbose
  end
  
  describe "Comment with child and commentable element" do
    before do
      @first_comment = FactoryGirl.create("first comment")
    end
    it "should have child comments" do
      @first_comment.children.should_not be_empty
    end
    
    it "should have commentable object" do
      @first_comment.commentable.should_not be_nil
    end
    
    describe "Caching" do
      it "should have cache_marker field" do
        @first_comment.should respond_to(:cache_marker)
      end
      
      it "should have cache_marker value for instance" do
        @first_comment.cache_marker.should_not be_nil
        lambda { 
          @first_comment.message = "test"
          @first_comment.save
          @first_comment.reload
           }.should change(@first_comment, :cache_marker)
      end
    end
    
    describe "Commentable" do
      it "should have one root element" do
        @first_comment.commentable.comments.roots.should have(1).items
      end
      
      it "should have 2 all comments" do
        @first_comment.commentable.comments.should have(1).items
        @first_comment.commentable.comments.first.children.should have(1).items
      end
    end
    
    describe "Render" do
      it "should have render method" do
        @first_comment.should respond_to(:render)
      end

      it "should render test page" do
        @first_comment.render(:block).should include(@first_comment.owner.name)
      end
    end
    
  end
end