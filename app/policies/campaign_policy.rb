class CampaignPolicy < ApplicationPolicy
  def content_review?
    create?
  end

  def practices_review?
    create?
  end

  def approved_content?
    create?
  end

  def practices_review_index?
    create?
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
    create?
  end

  def unmark_for_review?
    create?
  end

end
