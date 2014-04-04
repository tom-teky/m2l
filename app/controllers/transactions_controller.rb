class TransactionsController < ApplicationController
  def index
    @src_transactions = Transaction.where(src_account_id: current_account.id)
    @dst_transactions = Transaction.where(dst_account_id: current_account.id)
  end

  def new
    raise ActiveRecord::RecordNotFound unless current_account.can_perform_a_transaction?

    @targets = Account.where('id <> ?', [current_account.id])
    @target = @targets.find(params[:target_id])
    @transaction = Transaction.new
    @transaction.src_account_id = current_account.id
    @transaction.dst_account_id = @target.id
  end

  def create
    raise ActiveRecord::RecordNotFound unless current_account.can_perform_a_transaction?

    dst_account = Account.find(params[:target_id])
    current_account.transact_to!(dst_account, params[:transaction][:amount].to_i.abs)

    render :thanks, status: 201
  end

end
