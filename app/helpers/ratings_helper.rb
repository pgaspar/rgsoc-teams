module RatingsHelper
  def rounded_points_for(subject, precision=2)
    points = subject.try(:average_points) || subject.try(:points)
    points.round precision if points
  end

  def field_tooltip(key)
    key = key.to_s
    { data:
      { toggle: 'popover',
        placement: 'left',
        container: 'body',
        trigger: 'hover',
        content: tooltip_text_for(key),
        html: true },
      title: key.titleize }
  end

  private

  def tooltip_text_for(key)
    key = key.gsub(/_student_\d/, '')
    simple_format tooltips[key]
  end

  def tooltips
    @tooltips ||= YAML.load_file('config/tooltips.yml')
  end
end
