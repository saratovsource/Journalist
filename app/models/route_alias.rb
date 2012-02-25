class RouteAlias < AbstractRouter
  belongs_to :router
  
  validates_presence_of :router
end