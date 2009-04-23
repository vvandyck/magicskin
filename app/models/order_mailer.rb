class OrderMailer < ActionMailer::Base
  

  def confirm order
    @subject        = 'skin order confirmation'
    @recipients     = order.email
    @bcc            = 'shop@modesphere.com'
    @from           = 'shop@modesphere.com'
    @sent_on        = Time.now
    @body["order" ] = order
  end

  def sent order
    @subject        = 'skin order sent'
    @recipients     = order.email
    @bcc            = 'shop@modesphere.com'
    @from           = 'shop@modesphere.com'
    @sent_on        = Time.now
    @body["order"]  = order
  end

end
