class EndUser::GroupsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_user, only: [:update, :destroy, :complete]
  before_action :notification_index, only: [:index, :show, :user_join_groups]

  def index
    @group = Group.new
    @groups = Group.page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @join_group = current_end_user.groups.with_attached_group_image.includes(:user_groups, :owner, users: [icon_attachment: [:blob]])
  end

  def show
    @group = Group.find(params[:id])
    users = []
    # パブリックユーザーを名前の順に取得し配列に代入する
    published_users = @group.users.with_attached_icon.where(status: "published").where.not(status: "freeze").order(name: :ASC)
    users.push(published_users)
    # ログイン中のユーザーを配列に加える
    if @group.users.include?(current_end_user)
      users << current_end_user
    end
    # 1次元配列にし、ログイン中のユーザーが公開だった場合、名前が被るので取り除く
    users.flatten!
    users = users.uniq { |user| user.id }
    @members = Kaminari.paginate_array(users).page(params[:page]).per(1)
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    if @group.save
      # 作成時にオーナーをgroup.usersの配列に入れる
      @group.users << current_end_user
      redirect_to group_complete_path(@group), notice: "グループを作成しました。"
    else
      render :error
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループが正常に編集されました。"
    else
      render :error
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, alert: "グループを削除しました。"
  end

  def user_join_groups
    @groups = current_end_user.groups.page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @post_tags = PostingTag.display_show_type("post")
  end

  private

  def ensure_correct_user
    group = Group.find(params[:id])
    unless group.is_ownerd_by?(current_end_user)
      redirect_to groups_path, alert: "オーナーではないため編集できません。"
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end
end
