class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def index
    @traffic_stats = TrafficLog.select(
      "date(convert_tz(created_at,'+00:00','+09:00')) as created_date,
      sum(case when device='pc' then 1 else 0 end) as pc_count, 
      sum(case when device='mobile' then 1 else 0 end) as mobile_count")
        .group("date(convert_tz(created_at,'+00:00','+09:00'))")
        .order("date(convert_tz(created_at,'+00:00','+09:00'))")
    @traffic_stats_sum = TrafficLog.select(
      "sum(case when device='pc' then 1 else 0 end) as pc_count, 
      sum(case when device='mobile' then 1 else 0 end) as mobile_count")
    @viral_stats = ViralAction.select("date(created_at) as created_date,count(*) as viral_count")
      .group("date(created_at)")
      .order("created_at")
    @viral_stats_sum = ViralAction.select("count(*) as viral_count")
    @user_stats = User.select(
      "date(users.created_at) as created_date,
      sum(case when device='pc' then 1 else 0 end) as pc_count
      ,sum(case when device='mobile' then 1 else 0 end) as mobile_count")
        .group("date(created_at)")
        .order("date(created_at)")
    @user_stats_sum = User.select(
      "sum(case when device='pc' then 1 else 0 end) as pc_count, 
      sum(case when device='mobile' then 1 else 0 end) as mobile_count")
        # @event_stats = @traffic_stats.joins(@viral_stats).where(@traffic_stats.create_date => @viral_stats.created)
  end
end