class JournalRubric
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Content::Sortable
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  
  # -= Validations =-
  #TODO Add Validation of UNIQ scoped [site_id, parent_id] - parent: may be only Rubric
  validates_uniqueness_of   :slug, :scope => [:site_id]
  
  # -= Fields =-
  
  # -= Associations =-
  has_many :journal_articles, :class_name => "JournalArticle", :foreign_key => "parent_id"
  
  # -= Medthos =-
  
  class << self
    # Create new empty rubric
    def create_new(args = {})
      args = {
        :title => Journalist::UniqGenerator.generate(:prefix => self.model_name.human)
        }.merge(args)
        
      create(args)
    end
    
  end
  
  def parent
    self.site
  end
  
end