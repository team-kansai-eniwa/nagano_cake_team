class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private

  def render_404
    render template: 'errors/not_found', status: :not_found
  end
end
