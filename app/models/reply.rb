require 'rmmseg'
require 'rmmseg/ferret'
class Reply < ActiveRecord::Base
    belongs_to :forum, :counter_cache => true
    belongs_to :topic, :counter_cache => true
     #……………………………………………………其他实现………………………………………………………………
  delegate :title, :to => :topic
   
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
      :store_class_name => true,
      :analyzer => RMMSeg::Ferret::Analyzer.new
    })
 
  def created_at_s
    created_at.to_s(:db)
  end
 
  def updated_at_s
    updated_at.to_s(:db)
  end
#……………………………………………………其他实现………………………………………………………………
end
