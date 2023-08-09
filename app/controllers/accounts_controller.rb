require 'byebug'
class AccountsController < ApplicationController

    def create
        account = Account.new(account_params)
        if account.save
            render json: {data: account}
        else
            render json: {error: account.errors}
        end
    end

    def show
        account = Account.find_by(id: params[:id])
        if account.present?
            render json: {data: account}
        else
            render json: {message: "account not found !"}
        end
    end

    def account_details
        account = Account.find_by(cust_id: params[:cust_id])
        if account.present? && params[:input] == "n"
            render json: {message: " welcome to our banking app #{account.name}",data: account.name}
        elsif account.present? && params[:input] == "na"
            render json: {message: "your account details are : ", name: account.name, amount: account.amount}
        else
            puts "incorrect choice !!"
        end
    end

    def check_balance
        account = Account.find_by(cust_id: params[:cust_id])
        p_pin = params[:pin]
        if account.present? && account.pin == p_pin
            render json: {message: "your account balance is #{account.amount}"}
        else
            render json: {message: "Account not found !"}
        end
    end

    def deposit
        money = params[:deposit_money]
        p_pin = params[:pin]
        account = Account.find_by(cust_id: params[:cust_id])
        if account.present? && account.pin == p_pin
            n_amount = account.amount + money.to_i
            account.update(amount: n_amount)
            tr = Transaction.create(cust_id: account.cust_id,transaction_type: "deposit",amount: money,account_id: account.id)
            render json: {message: "successfully deposit #{money} in your account !", data: account}
        else
            render json: {error: "Account not found !"}
        end
    end

    def withdraw
        money = params[:withdraw_money]
        p_pin = params[:pin]
        account = Account.find_by(cust_id: params[:cust_id])
        if account.present? && account.pin == p_pin
            n_amount = account.amount - money.to_i
            account.update(amount: n_amount)
            tr = Transaction.create(cust_id: account.cust_id,transaction_type: "withdraw",amount: money,account_id: account.id)
            render json: {message: "successfully withdraw #{money} from your account !", data: account}
        else
            render json: {error: "Account not found !"}
        end
    end

    def transfer
        money = params[:transfer_money]
        p_pin = params[:pin]
        sender = Account.find_by(cust_id: params[:sender_id])
        receiver = Account.find_by(cust_id: params[:receiver_id])
        byebug
        if sender.present? && receiver.present? && sender.pin == p_pin
            s_amount = sender.amount - money.to_i
            r_amount = receiver.amount + money.to_i
            sender.update(amount: s_amount)
            receiver.update(amount: r_amount)
            s_tr = Transaction.create(cust_id: sender.cust_id,transaction_type: "transfer",amount: money,account_id: sender.id)
            r_tr = Transaction.create(cust_id: receiver.cust_id,transaction_type: "received",amount: money,account_id: receiver.id)
            render json: {message: "successfully transfrred #{money} to #{receiver.name}, and your updated_balance is" , data: sender }

        else
            render json: {error: " try again ! sender or receiver account is not fount"}
        end
    end

    def transaction_history
        account = Account.find_by(cust_id: params[:cust_id],pin: params[:pin])
        if account.present?
            tr = Transaction.where(cust_id: params[:cust_id])
            render json: {message: "your all transactions are:" , data: tr}
        else
            render json: {message: "account not found with this id or password !!"}
        end
    end

    private

    def account_params
        params.require(:account).permit(:cust_id, :name, :pin, :amount)
    end
end
