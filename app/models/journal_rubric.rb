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
  references_many :journal_articles
  
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
  
  # Override fullpath method
  def fullpath(force = false)
    if read_attribute(:fullpath).present? && !force
      return read_attribute(:fullpath)
    end
    
    #TODO Add segment form settind, example:   http://localhost:8080/[rubrics]/rubric-1
    #                                                                ^^^^^^^^          
    # for generate full path to rubruc
    return File.join [self.parent_path, self.slug]
  end
  
  # Override parent_path method
  def parent_path
    "/"
  end
end