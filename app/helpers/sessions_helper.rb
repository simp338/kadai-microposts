module SessionsHelper
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user
    #current_userがいない場合、!一個でnot false=>trueになり、さらに!があり、!true=>not true=>falseとなる
  end
  
end
