require "test_helper"

class UpdateMentorStatsJobTest < ActiveJob::TestCase
  test "update num solutions mentored if requested" do
    mentor = create :user

    Mentor::UpdateNumSolutionsMentored.expects(:call).with(mentor)

    UpdateMentorStatsJob.perform_now(mentor, update_num_solutions_mentored: true)
  end

  test "does not update num solutions mentored if not request" do
    mentor = create :user

    Mentor::UpdateNumSolutionsMentored.expects(:call).with(mentor).never

    UpdateMentorStatsJob.perform_now(mentor, update_num_solutions_mentored: false)
  end

  test "update satisfaction rating if requested" do
    mentor = create :user

    Mentor::UpdateSatisfactionRating.expects(:call).with(mentor)

    UpdateMentorStatsJob.perform_now(mentor, update_satisfaction_rating: true)
  end

  test "does not update satisfaction rating if not requested" do
    mentor = create :user

    Mentor::UpdateSatisfactionRating.expects(:call).with(mentor).never

    UpdateMentorStatsJob.perform_now(mentor, update_satisfaction_rating: false)
  end

  test "updates num solutions mentored and satisfaction rating if requested" do
    mentor = create :user

    Mentor::UpdateSatisfactionRating.expects(:call).with(mentor)

    UpdateMentorStatsJob.perform_now(mentor, update_num_solutions_mentored: true, update_satisfaction_rating: true)
  end
end
