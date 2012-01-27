class JournalArticle
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Content::EditableContent
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Article::Stated
  
  # -= Associations =-
  referenced_in :parent, :class_name => "JournalRubric"
  
  # -= Indexes =-
  index :parent_id
  
  # -= Callbacks =-
  before_validation :set_owned_site
  
  #-= States =-
  state_machine do
    event :prepublish do
      transition [:drafted, :rewrited] => :prepublished, :if => lambda {|article| !article.journal_rubric.nil?}
    end
    
    state all - [:drafted, :trashed] do
      validates_presence_of     :parent
      validates_uniqueness_of   :slug, :scope => [:site_id, :parent_id]
      validates_presence_of :content
    end
    
  end
  
  # -= Scopes =-
  scope :collection_for, ->(member, states, owner = nil) {
    where(:state => {'$in' => states}, :owner_id => owner.nil? ? nil : owner.id)
  }
  
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
    self.site = self.parent.site if self.parent.present?
  end
end