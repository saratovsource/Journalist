class JournalArticle
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Content::EditableContent
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Article::Stated
  
  # -= Associations =-
  referenced_in :journal_rubric
  
  # -= Indexes =-
  index :journal_rubric_id
  
  # -= Callbacks =-
  before_validation :set_owned_site
  
  #-= States =-
  state_machine do
    event :prepublish do
      transition [:drafted, :rewrited] => :prepublished, :if => lambda {|article| !article.journal_rubric.nil?}
    end
    
    state all - [:drafted, :trashed] do
      validates_presence_of     :journal_rubric
      validates_uniqueness_of   :slug, :scope => [:site_id, :journal_rubric_id]
      validates_presence_of :content
    end
    
  end
  
  # -= Validations =-
  validates_presence_of     :site
  
  # -= Methods =-
  class << self
    # Create new empty article
    def create_new(args = {})
      args = {
        :title => I18n.t('journal_article.default_title'),
        :slug => Journalist::UniqGenerator.generate(:prefix => "post")
        }.merge(args)
        
      create(args)
    end
  end
  
  protected
  
  def set_owned_site
    self.site = self.journal_rubric.site if self.journal_rubric.present?
  end
  
  
  def fullpath(force = false)
    if read_attribute(:fullpath).present? && !force
      return read_attribute(:fullpath)
    end
    
    slugs = [self.slug] #TODO Get all slugs of tree, if it be a tree
    
    return self.journal_rubric.nil? ? nil : File.join([self.parent_path, self.slug].compact)
  end
  
  # Override parent_path method
  def parent_path
    self.try(:journal_rubric).try(:fullpath)
  end
end