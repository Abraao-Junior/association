module PeopleHelper
    def status_icon(person)
      if person.active
        content_tag(:span, class: "text-success") do
          concat(content_tag(:i, '', class: 'bi bi-check-circle'))
        end
      else
        content_tag(:span, class: "text-danger") do
          concat(content_tag(:i, '', class: 'bi bi-x-circle'))
        end
      end
    end
  end
  