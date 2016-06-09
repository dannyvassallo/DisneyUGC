class CampaignPolicy < ApplicationPolicy
  def content_review?
    create?
  end

  def practices_review?
    user.present? && (user.reviewer? || user.admin?)
  end

  def approved_content?
    practices_review?
  end

  def practices_review_index?
    practices_review?
  end

  def download_all_posts?
    create?
  end

  def download_selected_posts?
    create?
  end

  def posts_for_review?
    create?
  end

  def approve_posts?
    practices_review?
  end

  def unmark_for_review?
    create?
  end

end
