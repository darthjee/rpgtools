module ApplicationHelper
  def show_message(message)
    %Q(
      <p>
        <span>#{message.session.nick}:</span>
        #{message.text}
      <p>
      ).html_safe
  end
end
