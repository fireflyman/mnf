authorization do
  role :guest do
    has_permission_on :users, :to => [:read_index,:create]
  end
 
  role :ptuser do
    includes :guest
    has_permission_on :users, :to => [:read_show,:update] do
      if_attribute :id => is {user.id}
    end
  end
 
  role :administrator do
    has_permission_on :users, :to => :manage
  end
end
 
privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :read_index, :includes => :index
  privilege :read_show, :includes => :show
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end