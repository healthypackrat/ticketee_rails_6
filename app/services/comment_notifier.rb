class CommentNotifier
  attr_reader :comment

  def initialize(comment)
    @comment = comment
  end

  def notify_watchers
    (comment.ticket.watchers.to_a - [comment.author]).each do |user|
      CommentMailer
        .with(comment: comment, user: user)
        .new_comment
        .deliver_later
    end
  end
end
