class ApplicationController < ActionController::Base
    include ::ActionView::Layouts
    include ActionController::Flash  
    include ActionController::Helpers

    protect_from_forgery with: :null_session
end
