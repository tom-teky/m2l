class TargetsController < ApplicationController
  def index
    @targets = Account.where('id <> ?', [current_account.id])
  end
end
