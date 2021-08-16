class ApplicationController < ActionController::API
include Response

  rescue_from ActiveRecord::RecordNotFound do |exception|
    json_response({message: exception.message}, :not_found)
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    json_response({ message: exception.message}, 422)
  end
end
