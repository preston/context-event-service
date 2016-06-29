module ApplicationHelper
    def yes_or_no(b)
        b ? 'Yes' : 'No'
    end

    def text_with_icon(text, icon)
        "<i class=\"fa fa-#{icon}\"></i>&nbsp;&nbsp;#{text}".html_safe
    end

    def person_signed_in?
        !!@current_person
    end

    def current_person
        @current_person
    end

    def current_identity
        @current_identity
    end

    def current_jwt
        System::JsonWebToken.where('identity_id = ? AND expires_at > ?', current_identity, Time.now).order(expires_at: :desc).first
    end
end
