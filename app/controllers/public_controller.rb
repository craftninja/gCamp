class PublicController < ApplicationController
  skip_before_action :verify_user
end
