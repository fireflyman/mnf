require 'rmmseg'
require 'rmmseg/ferret'
class Topic < ActiveRecord::Base
     #……………………………………………………其他实现………………………………………………………………
  #如果想重新建立索引，只需要删除对应的文件夹，并重启服务,也可以使用Model.rebuild_index方法
  #=======================搜索部分=====================
  acts_as_ferret({
      :fields => {
        :title => {
          :store => :yes,
          :boost=> 20 #设置权重
        },
        :body => {
          :boost=> 1,
          :store => :yes,
          :term_vector => :with_positions_offsets
        },
        :author => {:store => :yes},
        :created_at_s => {:index => :untokenized,:store => :yes},
        :updated_at_s => {:index => :untokenized,:store => :yes}
      },
      :store_class_name=>true,
      :analyzer => RMMSeg::Ferret::Analyzer.new
    })
  def created_at_s
    created_at.to_s(:db)
  end

  def updated_at_s
    updated_at.to_s(:db)
  end
=begin
  def body
    first_reply.body
end
=end
#……………………………………………………其他实现………………………………………………………………
  belongs_to :forum,:counter_cache => true
  has_many :replies,:dependent => :destroy
  validates_presence_of :title, :body
  validates_length_of :body, :minimum => 16

  def last_post
    if self.has_replies
      return self.replies.sort_by{ |rep| rep.created_at }.last
    else
      return self
    end
  end

  def sticky?
    self.sticky == 1
  end

  def replies_count
    replies.size
  end

  def last_post_time
    self.last_post.created_at
  end

  def <=> (other)
    self.last_post_time <=> other.last_post_time
  end

  def has_replies
    !(self.replies.nil? || self.replies.empty?)
  end

  def do_reply(options = {})
    options.merge!(:title => '')
    replies.build(options)
  end

  def hit!
    self.class.increment_counter(:hits,id)
  end
end
