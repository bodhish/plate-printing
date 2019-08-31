class ApplicationPresenter
  def initialize(view_context, params = nil)
    @view = view_context
    @params = params
  end

  private

  attr_reader :view, :params

  delegate(:current_user, to: :view)
end
