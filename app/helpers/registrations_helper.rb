module RegistrationsHelper
  # #register_or_sold_out is going to return a registration link or some sold out text.
  def register_or_sold_out(event)
    # #sold_out? was defined in the Event model.
    # is the event sold out?
    if event.sold_out?
      # return some sold out text
      # style the 'Sold Out!' text
      # generate some HTML here in the helper.
      # since view helper methods are just straight up Ruby code (.rb) file extension
      # we need to use the built-in helper named 'content_tag'
      # this returns an HTML save string with the content - 'Sold Out!' - surrounded by the tag - span.
      content_tag(:span, 'Sold Out!', class: 'sold-out')
    else
      # return a registration link
      link_to 'Register!', new_event_registration_path(event), class: 'register'
    end
  end
end
