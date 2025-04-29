module TasksHelper
  def badge_class_for_status(status)
    case status.to_s
    when "active"    then "bg-primary"
    when "on_review" then "bg-warning text-dark"
    when "completed" then "bg-success"
    else                     "bg-secondary"
    end
  end

  def status_badge(task)
    content_tag :span, task.status.humanize,
                class: "badge #{badge_class_for_status(task.status)}"
  end
end