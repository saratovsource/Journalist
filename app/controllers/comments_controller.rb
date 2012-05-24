class CommentsController < ::BaseController
  layout false

  def form
    @comment = current_site.comments.web.find(params[:id])
  end

  def post
    @comment = current_site.comments.web.find(params[:id])
    @rtm = @comment.write_comment(params[:comment], current_account)
    redirect_to @rtm.fullpath
  end

end
